using System; using System.IO; using MoonSharp.Interpreter;
class R { static void Main(string[] a) {
  var s = new Script(CoreModules.Preset_Complete);
  s.Options.DebugPrint = x => Console.WriteLine(x);
  try { foreach (var f in a) s.DoString(File.ReadAllText(f), null, Path.GetFileName(f)); }
  catch (InterpreterException e) { Console.WriteLine("LUA ERROR: " + e.DecoratedMessage); Environment.Exit(1); }
} }
