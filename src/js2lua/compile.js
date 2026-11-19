// js2lua: compiles the subset of JavaScript the Sour Empire engine uses into Lua that runs on runtime.lua.
// Every construct it does not know is an error, so a rule change that uses something new fails loudly at build time.
//   node compile.js in.js out.lua
const acorn = require('acorn');
const fs = require('fs');

const LUA_KW = new Set('and break do else elseif end false for function goto if in local nil not or repeat return then true until while'.split(' '));
const GLOBALS = new Set(['process', 'String', 'Number', 'Math', 'Object', 'Array', 'WeakMap', 'Set', 'Map', 'Infinity', 'window', 'Date', 'JSON', 'module', 'isNaN', 'parseInt', 'parseFloat', 'console']);
const ARR_STR_METHODS = new Set(['push', 'pop', 'shift', 'unshift', 'map', 'filter', 'forEach', 'some', 'every', 'find', 'findIndex', 'reduce', 'slice', 'splice', 'includes', 'indexOf',
  'join', 'reverse', 'fill', 'concat', 'flat', 'flatMap', 'sort', 'keys', 'entries', 'toLowerCase', 'toUpperCase', 'startsWith', 'endsWith', 'trim', 'split', 'substring', 'charAt',
  'repeat', 'padStart', 'padEnd', 'toString', 'toFixed', 'has', 'add', 'delete', 'get', 'set', 'values', 'toISOString']);
const TABLE_LIMIT = 120; // a scope with more names than this keeps them in a table (Lua allows 200 locals per function)

let tmpN = 0;
const tmp = () => '__v' + (++tmpN);
function fail(node, msg) { const l = node && node.loc ? ` (line ${node.loc.start.line})` : ''; throw new Error(msg + l); }

/* ---------- scopes ---------- */
class Scope {
  constructor(parent, isFn) { this.parent = parent; this.isFn = isFn; this.names = new Map(); this.table = null; }
  lookup(n) { for (let s = this; s; s = s.parent) if (s.names.has(n)) return { s, ref: s.names.get(n) }; return null; }
}
const luaName = n => (LUA_KW.has(n) || n.startsWith('__') || n.startsWith('JS_') || n === 'self' || n === '_ENV') ? n + '_' : n;
function patternNames(p, out) {
  if (!p) return out;
  if (p.type === 'Identifier') out.push(p.name);
  else if (p.type === 'ArrayPattern') p.elements.forEach(e => patternNames(e, out));
  else if (p.type === 'ObjectPattern') p.properties.forEach(q => patternNames(q.type === 'RestElement' ? q.argument : q.value, out));
  else if (p.type === 'RestElement') patternNames(p.argument, out);
  else if (p.type === 'AssignmentPattern') patternNames(p.left, out);
  else fail(p, 'pattern ' + p.type);
  return out;
}
// names declared directly in a list of statements (let/const/function), plus var anywhere below (not in nested functions) when fnBody
function blockDecls(stmts, fnBody) {
  const names = [];
  for (const s of stmts) {
    if (s.type === 'VariableDeclaration' && (s.kind !== 'var')) s.declarations.forEach(d => patternNames(d.id, names));
    if (s.type === 'FunctionDeclaration') names.push(s.id.name);
  }
  if (fnBody) { const walkVar = n => { if (!n || typeof n !== 'object') return; if (Array.isArray(n)) return n.forEach(walkVar);
      if (/Function/.test(n.type)) return; if (n.type === 'VariableDeclaration' && n.kind === 'var') n.declarations.forEach(d => patternNames(d.id, names));
      for (const k in n) if (k !== 'loc' && k !== 'type') walkVar(n[k]); };
    stmts.forEach(walkVar); }
  return [...new Set(names)];
}

/* ---------- the compiler ---------- */
let scope = null, tableN = 0;
function declare(sc, names) {
  const useTable = names.length > TABLE_LIMIT;
  if (useTable) sc.table = '__S' + (++tableN);
  for (const n of names) sc.names.set(n, useTable ? `${sc.table}.${luaName(n)}` : luaName(n));
  return useTable ? `local ${sc.table} = {}` : (names.length ? `local ${names.map(luaName).join(', ')}` : '');
}
function ref(name, node) {
  const r = scope.lookup(name);
  if (r) return r.ref;
  if (name === 'undefined') return 'nil';
  if (GLOBALS.has(name)) return 'JS_' + name;
  fail(node, 'unknown name ' + name);
}

// expressions known to give true or false
function isBool(n) {
  if (n.type === 'Literal' && typeof n.value === 'boolean') return true;
  if (n.type === 'BinaryExpression' && ['===', '!==', '==', '!=', '<', '>', '<=', '>=', 'instanceof', 'in'].includes(n.operator)) return true;
  if (n.type === 'UnaryExpression' && n.operator === '!') return true;
  if (n.type === 'LogicalExpression' && n.operator !== '??' && isBool(n.left) && isBool(n.right)) return true;
  return false;
}
// a condition: true or false in Lua
function cond(n) {
  if (n.type === 'LogicalExpression' && n.operator === '&&') return `(${cond(n.left)} and ${cond(n.right)})`;
  if (n.type === 'LogicalExpression' && n.operator === '||') return `(${cond(n.left)} or ${cond(n.right)})`;
  if (n.type === 'UnaryExpression' && n.operator === '!') return `(not ${cond(n.argument)})`;
  if (isBool(n)) return expr(n);
  return `__t(${expr(n)})`;
}
// values Lua treats as true for sure (so `c and a or b` is safe)
const luaTruthy = n => (n.type === 'Literal' && (typeof n.value === 'number' || typeof n.value === 'string')) || n.type === 'TemplateLiteral' || n.type === 'ObjectExpression' ||
  n.type === 'ArrayExpression' || /Function/.test(n.type);
const iife = body => `(function() ${body} end)()`;
const one = s => `(${s})`; // truncate a call to one value

function str(s) { // a Lua string literal; bytes outside ASCII pass through as UTF-8
  return '"' + s.replace(/[\\"\n\r\t\0]|[\x00-\x1f]/g, c => ({ '\\': '\\\\', '"': '\\"', '\n': '\\n', '\r': '\\r', '\t': '\\t' }[c] || '\\' + c.charCodeAt(0))) + '"';
}
function keyOf(p) {
  if (p.computed) return expr(p.key);
  if (p.key.type === 'Identifier') return str(p.key.name);
  if (p.key.type === 'Literal') return typeof p.key.value === 'number' ? String(p.key.value) : str(String(p.key.value));
  fail(p, 'key');
}
const fieldAccess = (obj, name) => /^[A-Za-z_][A-Za-z0-9_]*$/.test(name) && !LUA_KW.has(name) ? `${obj}.${name}` : `${obj}[${str(name)}]`;
const wrapObj = s => /^[A-Za-z_][A-Za-z0-9_.]*$/.test(s) ? s : `(${s})`;

function args(list) {
  if (!list.some(a => a.type === 'SpreadElement')) return list.map((a, i) => i === list.length - 1 ? one(expr(a)) : expr(a)).join(', ');
  return `__unpack(__spreadA({${list.map(a => a.type === 'SpreadElement' ? `{s=${expr(a.argument)}}` : `{v=${expr(a)}}`).join(', ')}}))`;
}

function expr(n) {
  switch (n.type) {
    case 'Literal':
      if (n.regex) fail(n, 'regex');
      if (n.value === null) return 'nil';
      if (typeof n.value === 'string') return str(n.value);
      if (typeof n.value === 'boolean') return String(n.value);
      if (typeof n.value === 'number') return Number.isFinite(n.value) ? String(n.value) : 'JS_Infinity';
      fail(n, 'literal');
    case 'Identifier': return ref(n.name, n);
    case 'TemplateLiteral': {
      const parts = [];
      n.quasis.forEach((q, i) => { if (q.value.cooked) parts.push(str(q.value.cooked)); if (n.expressions[i]) parts.push(`__str(${expr(n.expressions[i])})`); });
      return parts.length ? `(${parts.join(' .. ')})` : '""';
    }
    case 'ArrayExpression': {
      if (n.elements.some(e => e && e.type === 'SpreadElement')) return `__spreadA({${n.elements.map(e => e.type === 'SpreadElement' ? `{s=${expr(e.argument)}}` : `{v=${expr(e)}}`).join(', ')}})`;
      if (!n.elements.length) return '__mkA({__n=0})';
      const els = n.elements.map((e, i) => (i === n.elements.length - 1 ? one(e ? expr(e) : 'nil') : (e ? expr(e) : 'nil')));
      return `__mkA({[0]=${els[0]}${els.length > 1 ? ', ' + els.slice(1).join(', ') : ''}, __n=${els.length}})`;
    }
    case 'ObjectExpression': {
      if (n.properties.some(p => p.type === 'SpreadElement' || p.computed))
        return `__spreadO({${n.properties.map(p => p.type === 'SpreadElement' ? `{s=${expr(p.argument)}}` : `{k=${keyOf(p)}, v=${propVal(p)}}`).join(', ')}})`;
      const fields = [], keys = [];
      for (const p of n.properties) { const k = keyOf(p); fields.push(`[${k}]=${propVal(p)}`); if (p.key.type === 'Identifier' || typeof p.key.value === 'string') keys.push(k); }
      return `__mkO({${fields.join(', ')}}, {${keys.join(', ')}})`;
    }
    case 'FunctionExpression': case 'ArrowFunctionExpression': return fn(n);
    case 'UnaryExpression': {
      const a = n.argument;
      if (n.operator === '!') return `(not ${cond(a)})`;
      if (n.operator === '-') return `(-${expr(a)})`;
      if (n.operator === '+') return `__num(${expr(a)})`;
      if (n.operator === 'typeof') { if (a.type === 'Identifier' && !scope.lookup(a.name)) return `__typeof(${GLOBALS.has(a.name) ? 'JS_' + a.name : 'nil'})`; return `__typeof(${expr(a)})`; }
      if (n.operator === 'void') return `(function() local _ = ${expr(a)} end)()`;
      if (n.operator === 'delete') return iife(`${stmtDelete(a)} return true`);
      fail(n, 'unary ' + n.operator);
    }
    case 'BinaryExpression': {
      const L = expr(n.left), R = expr(n.right);
      switch (n.operator) {
        case '+': return `__add(${L}, ${R})`;
        case '-': return `(${L} - ${R})`; case '*': return `(${L} * ${R})`; case '/': return `(${L} / ${R})`; case '%': return `__mod(${L}, ${R})`;
        case '===': case '==': return `(${L} == ${R})`;
        case '!==': case '!=': return `(${L} ~= ${R})`;
        case '<': return `__lt(${L}, ${R})`; case '<=': return `__le(${L}, ${R})`; case '>': return `__gt(${L}, ${R})`; case '>=': return `__ge(${L}, ${R})`;
      }
      fail(n, 'binary ' + n.operator);
    }
    case 'LogicalExpression': {
      if (n.operator === '||') return isBool(n.left) ? `(${expr(n.left)} or ${expr(n.right)})` : `(__T(${expr(n.left)}) or ${expr(n.right)})`;
      if (n.operator === '&&') { if (isBool(n.left)) return `(${expr(n.left)} and ${expr(n.right)})`; const v = tmp(); return iife(`local ${v} = ${expr(n.left)}; if __t(${v}) then return ${expr(n.right)} end return ${v}`); }
      if (n.operator === '??') { const v = tmp(); return iife(`local ${v} = ${expr(n.left)}; if ${v} == nil then return ${expr(n.right)} end return ${v}`); }
      fail(n, 'logical');
    }
    case 'ConditionalExpression':
      if (luaTruthy(n.consequent)) return `(${cond(n.test)} and ${expr(n.consequent)} or ${expr(n.alternate)})`;
      return iife(`if ${cond(n.test)} then return ${expr(n.consequent)} end return ${expr(n.alternate)}`);
    case 'MemberExpression': {
      if (n.object.type === 'Super') fail(n, 'super');
      const o = expr(n.object);
      if (!n.computed) { const p = n.property.name; if (p === 'length') return `__len(${o})`; return fieldAccess(wrapObj(o), p); }
      return `__get(${o}, ${expr(n.property)})`;
    }
    case 'CallExpression': {
      const c = n.callee;
      if (c.type === 'MemberExpression' && !c.computed) {
        const m = c.property.name;
        if (c.object.type === 'Identifier' && !scope.lookup(c.object.name) && GLOBALS.has(c.object.name)) return `JS_${c.object.name}.${m}(${args(n.arguments)})`;
        if (ARR_STR_METHODS.has(m)) return `__call(${expr(c.object)}, ${str(m)}${n.arguments.length ? ', ' + args(n.arguments) : ''})`;
        return `${fieldAccess(wrapObj(expr(c.object)), m)}(${args(n.arguments)})`;
      }
      if (c.type === 'MemberExpression' && c.computed) return `__get(${expr(c.object)}, ${expr(c.property)})(${args(n.arguments)})`;
      const f = expr(c);
      return `${/^[A-Za-z_][A-Za-z0-9_.]*$/.test(f) ? f : '(' + f + ')'}(${args(n.arguments)})`;
    }
    case 'NewExpression': return `__new(${expr(n.callee)}${n.arguments.length ? ', ' + args(n.arguments) : ''})`;
    case 'AssignmentExpression': { const v = tmp(); return iife(assign(n, v) + ` return ${v}`); }
    case 'UpdateExpression': {
      const t = target(n.argument), v = tmp(), op = n.operator === '++' ? '+' : '-';
      return iife(`local ${v} = __num(${t.get}); ${t.set(`${v} ${op} 1`)} return ${n.prefix ? `${v} ${op} 1` : v}`);
    }
    case 'SequenceExpression': return iife(n.expressions.slice(0, -1).map(e => stmtExpr(e)).join(' ') + ` return ${expr(n.expressions[n.expressions.length - 1])}`);
    case 'ChainExpression': fail(n, 'optional chaining');
  }
  fail(n, 'expression ' + n.type);
}
function propVal(p) { if (p.kind !== 'init') fail(p, 'getter/setter'); return p.method ? fn(p.value) : expr(p.value); }

// an assignable place: how to read it and how to write it
function target(n) {
  if (n.type === 'Identifier') { const r = ref(n.name, n); return { get: r, set: v => `${r} = ${v}` }; }
  if (n.type === 'MemberExpression') {
    const o = tmp();
    const pre = `local ${o} = ${expr(n.object)};`;
    if (!n.computed) { const p = n.property.name;
      if (p === 'length') return { pre, get: `__len(${o})`, set: v => `${pre} __setlen(${o}, ${v})`, o };
      return { get: `(function() ${pre} return ${fieldAccess(o, p)} end)()`, set: v => `${pre} __set(${o}, ${str(p)}, ${v})` }; }
    const k = tmp(); const pre2 = `local ${o} = ${expr(n.object)}; local ${k} = ${expr(n.property)};`;
    return { get: `(function() ${pre2} return __get(${o}, ${k}) end)()`, set: v => `${pre2} __set(${o}, ${k}, ${v})` };
  }
  fail(n, 'assign target ' + n.type);
}
// an assignment as statements; `into` names a local that receives the value
function assign(n, into) {
  const op = n.operator;
  if (n.left.type === 'ArrayPattern' || n.left.type === 'ObjectPattern') {
    if (op !== '=') fail(n, 'compound destructuring');
    const v = into || tmp();
    return `local ${v} = ${expr(n.right)}; ` + destructAssign(n.left, v);
  }
  const L = n.left;
  // one evaluation of the object and key, then read-modify-write
  if (L.type === 'MemberExpression') {
    const o = tmp(), k = tmp(); const key = L.computed ? expr(L.property) : str(L.property.name);
    let s = `local ${o} = ${expr(L.object)}; local ${k} = ${key}; `;
    const cur = !L.computed && L.property.name === 'length' ? `__len(${o})` : `__get(${o}, ${k})`;
    const val = rhs(op, cur, n.right, n);
    const v = into || tmp();
    s += `local ${v} = ${val}; `;
    s += !L.computed && L.property.name === 'length' ? `__setlen(${o}, ${v})` : `__set(${o}, ${k}, ${v})`;
    return s;
  }
  if (L.type === 'Identifier') { const r = ref(L.name, L); const val = rhs(op, r, n.right, n);
    if (into) return `local ${into} = ${val}; ${r} = ${into}`;
    return `${r} = ${val}`; }
  fail(n, 'assign ' + L.type);
}
function rhs(op, cur, right, n) {
  const R = expr(right);
  switch (op) {
    case '=': return R;
    case '+=': return `__add(${cur}, ${R})`; case '-=': return `(${cur} - ${R})`; case '*=': return `(${cur} * ${R})`; case '/=': return `(${cur} / ${R})`; case '%=': return `__mod(${cur}, ${R})`;
    case '||=': return `(__T(${cur}) or ${R})`;
  }
  fail(n, 'assignment ' + op);
}
// destructuring into existing names
function destructAssign(p, src) {
  if (p.type === 'Identifier') return `${ref(p.name, p)} = ${src}; `;
  if (p.type === 'MemberExpression') { const t = target(p); return t.set(src) + '; '; }
  if (p.type === 'ArrayPattern') return p.elements.map((e, i) => { if (!e) return ''; if (e.type === 'RestElement') return destructAssign(e.argument, `__call(${src}, "slice", ${i})`); const v = tmp(); return `local ${v} = __get(${src}, ${i}); ` + destructAssign(e, v); }).join('');
  if (p.type === 'ObjectPattern') { const used = [];
    return p.properties.map(q => { if (q.type === 'RestElement') return destructAssign(q.argument, `__objrest(${src}, {${used.join(', ')}})`);
      const k = keyOf(q); used.push(k); const v = tmp(); return `local ${v} = __get(${src}, ${k}); ` + destructAssign(q.value, v); }).join(''); }
  if (p.type === 'AssignmentPattern') { const v = tmp(); return `local ${v} = ${src}; if ${v} == nil then ${v} = ${expr(p.right)} end ` + destructAssign(p.left, v); }
  fail(p, 'destructure ' + p.type);
}

/* ---------- functions ---------- */
function fn(n) {
  const outer = scope; scope = new Scope(outer, true);
  const params = [], pre = [];
  let rest = null;
  const pnames = []; n.params.forEach(p => patternNames(p, pnames));
  const body = n.body.type === 'BlockStatement' ? n.body.body : null;
  const decls = body ? blockDecls(body, true).filter(x => !pnames.includes(x)) : [];
  // parameters are always locals; the function's own declarations may go in a table
  for (const nm of pnames) scope.names.set(nm, luaName(nm));
  n.params.forEach((p, i) => {
    if (p.type === 'Identifier') params.push(luaName(p.name));
    else if (p.type === 'RestElement') { params.push('...'); rest = p.argument; }
    else { const v = '__p' + i; params.push(v); pre.push(p.type === 'AssignmentPattern' && p.left.type === 'Identifier' ? `if ${v} == nil then ${v} = ${expr(p.right)} end local ${luaName(p.left.name)} = ${v};` : destructLocal(p, v)); }
  });
  if (rest) pre.push(`local ${luaName(rest.name)} = __pack(...);`);
  let out = `function(${params.join(', ')}) ${pre.join(' ')} `;
  const declLine = declare(scope, decls);
  out += declLine + '\n';
  if (body) out += hoistFns(body) + stmts(body);
  else out += `do return ${expr(n.body)} end`;
  out += '\nend';
  scope = outer;
  return out;
}
// destructuring a parameter into fresh locals (names already in scope)
function destructLocal(p, src) {
  const names = patternNames(p, []);
  return `local ${names.map(luaName).join(', ')}; ` + destructAssign(p, src);
}
function hoistFns(list) { return list.filter(s => s.type === 'FunctionDeclaration').map(s => `${ref(s.id.name, s)} = ${fn(s)}\n`).join(''); }

/* ---------- statements ---------- */
let loopDepth = []; // stack of { cont: bool } for loops being compiled; continue becomes a break out of an inner repeat
function stmts(list) { return list.map(stmt).join('\n'); }
function block(list) { // a new block scope
  const outer = scope; scope = new Scope(outer, false);
  const d = declare(scope, blockDecls(list, false));
  const s = (d ? d + '\n' : '') + hoistFns(list) + stmts(list);
  scope = outer; return s;
}
const asBlock = n => n.type === 'BlockStatement' ? block(n.body) : block([n]);
function stmtExpr(e) {
  switch (e.type) {
    case 'AssignmentExpression':
      if (e.right.type === 'AssignmentExpression' && e.operator === '=') { // a = b = c
        const v = tmp(); let s = `do ${assign(e.right, v)}; `; s += `${assign({ ...e, right: { type: 'Identifier', name: '__RAW__' + v } }, null)} end`; return s; }
      if (e.operator === '=' && e.right.type === 'ConditionalExpression' && !luaTruthy(e.right.consequent)) {
        const v = tmp(); return `do local ${v}; if ${cond(e.right.test)} then ${v} = ${expr(e.right.consequent)} else ${v} = ${expr(e.right.alternate)} end ${assign({ ...e, right: { type: 'Identifier', name: '__RAW__' + v } }, null)} end`; }
      return `do ${assign(e, null)} end`;
    case 'UpdateExpression': { const t = target(e.argument); return `do ${t.set(`__num(${t.get}) ${e.operator === '++' ? '+' : '-'} 1`)} end`; }
    case 'CallExpression': case 'NewExpression': { const s = expr(e); return /^\(function/.test(s) || e.type === 'NewExpression' ? `local _ = ${s}` : s; }
    case 'LogicalExpression':
      if (e.operator === '&&') return `if ${cond(e.left)} then ${stmtExpr(e.right)} end`;
      if (e.operator === '||') return `if not ${cond(e.left)} then ${stmtExpr(e.right)} end`;
      break;
    case 'ConditionalExpression': return `if ${cond(e.test)} then ${stmtExpr(e.consequent)} else ${stmtExpr(e.alternate)} end`;
    case 'SequenceExpression': return e.expressions.map(stmtExpr).join(' ');
    case 'UnaryExpression': if (e.operator === 'delete') return stmtDelete(e.argument); break;
  }
  return `local _ = ${expr(e)}`;
}
function stmtDelete(a) {
  if (a.type !== 'MemberExpression') fail(a, 'delete');
  return `rawset(${expr(a.object)}, ${a.computed ? expr(a.property) : str(a.property.name)}, nil)`;
}
function retStmt(arg) {
  if (!arg) return 'do return end';
  if (arg.type === 'ConditionalExpression') return `if ${cond(arg.test)} then ${retStmt(arg.consequent)} else ${retStmt(arg.alternate)} end`;
  return `do return ${one(expr(arg))} end`;
}
function varDecl(s) {
  return s.declarations.map(d => {
    if (!d.init) return d.id.type === 'Identifier' ? `${ref(d.id.name, d)} = nil` : '';
    if (d.id.type === 'Identifier') {
      const r = ref(d.id.name, d);
      if (d.init.type === 'ConditionalExpression' && !luaTruthy(d.init.consequent)) return `if ${cond(d.init.test)} then ${r} = ${expr(d.init.consequent)} else ${r} = ${expr(d.init.alternate)} end`;
      return `${r} = ${expr(d.init)}`;
    }
    const v = tmp(); return `do local ${v} = ${expr(d.init)}; ${destructAssign(d.id, v)} end`;
  }).join('\n');
}
// a loop body with continue support: repeat ... until true, with a flag for real breaks
function loopBody(bodyNode, extraDecl) {
  const ctx = { cont: false, brk: tmp() }; loopDepth.push(ctx);
  const outer = scope; scope = new Scope(outer, false);
  const list = bodyNode.type === 'BlockStatement' ? bodyNode.body : [bodyNode];
  const pre = extraDecl ? extraDecl() : '';
  const d = declare(scope, blockDecls(list, false));
  const inner = (d ? d + '\n' : '') + hoistFns(list) + stmts(list);
  scope = outer; loopDepth.pop();
  if (!ctx.cont) return { pre, body: inner, after: '' , ctx };
  return { pre: `local ${ctx.brk} = false\n` + pre, body: `repeat\n${inner}\nuntil true`, after: `if ${ctx.brk} then break end`, ctx };
}
function stmt(s) {
  switch (s.type) {
    case 'EmptyStatement': return '';
    case 'ExpressionStatement': return stmtExpr(s.expression);
    case 'VariableDeclaration': return varDecl(s);
    case 'FunctionDeclaration': return ''; // hoisted
    case 'ReturnStatement': return retStmt(s.argument);
    case 'IfStatement': {
      let out = `if ${cond(s.test)} then\n${asBlock(s.consequent)}\n`;
      let alt = s.alternate;
      while (alt && alt.type === 'IfStatement') { out += `elseif ${cond(alt.test)} then\n${asBlock(alt.consequent)}\n`; alt = alt.alternate; }
      if (alt) out += `else\n${asBlock(alt)}\n`;
      return out + 'end';
    }
    case 'BlockStatement': return `do\n${block(s.body)}\nend`;
    case 'WhileStatement': {
      const b = loopBody(s.body);
      return `do ${b.pre ? b.pre : ''}\nwhile ${cond(s.test)} do\n${b.body}\n${b.after}\nend end`;
    }
    case 'ForStatement': {
      const outer = scope; scope = new Scope(outer, false);
      let init = '';
      if (s.init && s.init.type === 'VariableDeclaration') { const names = []; s.init.declarations.forEach(d => patternNames(d.id, names)); init = declare(scope, names) + '\n' + varDecl(s.init); }
      else if (s.init) init = stmtExpr(s.init);
      const test = s.test ? cond(s.test) : 'true';
      const b = loopBody(s.body);
      const upd = s.update ? stmtExpr(s.update) : '';
      const out = `do\n${init}\n${b.pre}\nwhile ${test} do\n${b.body}\n${b.after}\n${upd}\nend\nend`;
      scope = outer; return out;
    }
    case 'ForOfStatement': case 'ForInStatement': {
      const outer = scope; scope = new Scope(outer, false);
      const left = s.left.type === 'VariableDeclaration' ? s.left.declarations[0].id : s.left;
      const names = s.left.type === 'VariableDeclaration' ? patternNames(left, []) : [];
      const v = tmp();
      const it = s.type === 'ForOfStatement' ? `for _, ${v} in __forof(${expr(s.right)}) do` : `for ${v} in __forin(${expr(s.right)}) do`;
      const b = loopBody(s.body, () => {
        if (s.left.type === 'VariableDeclaration') { const d = declare(scope, names); return d + '\n' + destructAssign(left, v); }
        return destructAssign(left, v);
      });
      const out = `${it}\n${b.pre}\n${b.body}\n${b.after}\nend`;
      scope = outer; return out;
    }
    case 'BreakStatement': {
      if (s.label) fail(s, 'label');
      const ctx = loopDepth[loopDepth.length - 1];
      if (ctx && ctx.cont) return `do ${ctx.brk} = true; break end`;
      return 'do break end';
    }
    case 'ContinueStatement': {
      if (s.label) fail(s, 'label');
      const ctx = loopDepth[loopDepth.length - 1]; if (!ctx) fail(s, 'continue outside a loop');
      ctx.cont = true; return 'do break end';
    }
    case 'TryStatement': {
      // the bodies must not return, break or continue (checked)
      const bad = n => { if (!n || typeof n !== 'object') return false; if (Array.isArray(n)) return n.some(bad); if (/Function/.test(n.type)) return false;
        if (['ReturnStatement', 'BreakStatement', 'ContinueStatement'].includes(n.type)) return true; return Object.keys(n).some(k => k !== 'loc' && bad(n[k])); };
      if (bad(s.block) || (s.handler && bad(s.handler.body))) fail(s, 'return/break inside try');
      const ok = tmp(), err = tmp();
      let out = `do local ${ok}, ${err} = pcall(function()\n${block(s.block.body)}\nend)\n`;
      if (s.handler) { const outer = scope; scope = new Scope(outer, false); let pre = '';
        if (s.handler.param) { scope.names.set(s.handler.param.name, luaName(s.handler.param.name)); pre = `local ${luaName(s.handler.param.name)} = ${err}\n`; }
        out += `if not ${ok} then\n${pre}${block(s.handler.body.body)}\nend\n`; scope = outer; }
      if (s.finalizer) out += block(s.finalizer.body) + '\n';
      if (!s.handler) out += `if not ${ok} then error(${err}, 0) end\n`;
      return out + 'end';
    }
    case 'ThrowStatement': return `error(${expr(s.argument)}, 0)`;
  }
  fail(s, 'statement ' + s.type);
}

/* ---------- program ---------- */
function compile(src) {
  const ast = acorn.parse(src, { ecmaVersion: 2022, locations: true, sourceType: 'script' });
  scope = new Scope(null, true);
  const d = declare(scope, blockDecls(ast.body, true));
  let out = d + '\n' + hoistFns(ast.body) + stmts(ast.body);
  // `__RAW__x` stands for an already-computed local named x
  out = out.replace(/__RAW__(__v\d+)/g, '$1');
  return out;
}
// identifiers named __RAW__ are placeholders; let them resolve
const origRef = ref;
ref = function (name, node) { if (name.startsWith('__RAW__')) return name.slice(7); return origRef(name, node); };

if (require.main === module) {
  const [, , inp, outp, ...extra] = process.argv;
  const lua = compile(fs.readFileSync(inp, 'utf8')) + '\n' + extra.join('\n');
  fs.writeFileSync(outp, lua);
  console.log(`${outp}: ${lua.length} bytes`);
}
module.exports = { compile };
