# Sour Empire for Tabletop Simulator

The lemonade-stand board game, playable in Tabletop Simulator with 2 or 3 players. The rules engine is the browser game's own engine, compiled to Lua, so the table plays exactly the same game.

## Loading it (Windows)

1. Download [`SourEmpire.json`](SourEmpire.json) (open it, then use the download button).
2. Put it in `C:\Users\<you>\Documents\My Games\Tabletop Simulator\Saves\`.
3. Start Tabletop Simulator, choose **Create**, then **Singleplayer** to try it alone or **Multiplayer** to host.
4. In the top menu: **Games → Save & Load → Sour Empire**.
5. The setup panel appears. Pick two or three players, what sits in each seat, and how much the table enforces. Then press **Set up the table**.

Players sit in **Red**, **Blue** and **Green**. Your ingredient and influence cards go to your hand, hidden from the others.

## Three ways to play

| Mode | Who keeps the rules | What the table does |
|---|---|---|
| **Full rules** | the engine | You act from the panel at the bottom of the screen, and place loyalty by clicking a market. Pieces move themselves. Bots can take any seat. |
| **Arithmetic only** | the players | You move every piece yourself. Buttons at the top right work out payday income, the loyalty each company gets for the map, and what a token costs in each market. |
| **None, just log** | the players | You move every piece yourself, and nothing is checked. |

Every mode writes a record. In full rules, it is the same record the browser game copies: every action, what it changed, and a snapshot of the table each round. In the other two modes, it is every pick-up, drop and draw, plus a snapshot of the table whenever you press **Note the table as it stands**, move the round marker, or run payday.

**Getting the record out:** press **Write the record to the Notebook** (top right; it also writes itself at the start of each round and when a game ends). Then open **Notebook** in the top menu, choose the *Sour Empire record* tab, select all and copy. A long record is split into tabs (*1 of 2*, *2 of 2*); copy them in order.

The *Anyone may act for human seats* option lets one person play every human seat, for testing alone.

## Bots

Bots need full rules. *Champion* bots are the three best genomes from the tuner (capital token tuning t3); the others are the hand-written styles: generalist, manufacturer, producer, distributor.

## What is in the repository

- `SourEmpire.json`: the save file. This is all you need to play.
- `img/v1/`: the card sheets and boards, drawn from the engine's data. Tabletop Simulator loads them from this repository, so it must stay public.
- `src/`: how it is built.
  - `engine.js`: the engine, as used in the browser.
  - `js2lua/`: the compiler from the engine's JavaScript to Lua, and the Lua runtime that keeps JavaScript's rules (arrays start at 0, `0` and `""` are false, sorting is stable).
  - `lua/table.lua`: the table: setup, pieces, the action panel, bots, the three modes, the record.
  - `art/`: the card and board printers.
  - `build.js`: puts it all together into `Global.lua` and `SourEmpire.json`.
  - `diff/`: plays seeded games in the JavaScript and the Lua engine side by side and compares the whole game state after every action.
  - `test/`: runs the table script against a stand-in for Tabletop Simulator's API.

## How it was checked

- **The engine.** 57 seeded bot games ran in both the JavaScript and the Lua engine and matched after every action, with the record on and off. They covered 2 and 3 players, every hand-written bot style and the evolved champions. The copied record matches the browser's line for line, except that keys whose value is null are left out.
- **The table script.** It ran against a stand-in for Tabletop Simulator's API: full-rules games from setup to a winner, with a scripted human clicking panel and market buttons against every kind of bot. There were no script errors and every panel was valid XML. A game saved and reloaded mid-way came back identical. The arithmetic and log-only modes wrote records that parse.
- **Not yet checked inside Tabletop Simulator itself.** Expect to adjust piece positions, button sizes and board scale after the first load.
