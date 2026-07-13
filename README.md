# flow-kit — `flow`

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-plugin-8A2BE2)](https://code.claude.com)
[![Codex CLI](https://img.shields.io/badge/OpenAI%20Codex-compatible-111111)](./codex)
[![Stars](https://img.shields.io/github/stars/Lemonaderrrrr/flow-kit?style=social)](https://github.com/Lemonaderrrrr/flow-kit/stargazers)

**Stop Claude from winging it.** `flow-kit` routes every task through two thinking
modes — 🧠 *Philosopher* (absorb) and ⚙️ *Engineer* (ship) — *before* work starts,
then runs it through one of **8 purpose-built workflow skills** — including a parallel
dev-team orchestrator (Planner + Frontend/Backend engineers + Reviewer).

Works in **Claude Code** and **OpenAI Codex CLI** — it's all just files in a repo,
so it also works on the web.

## The matrix

| Workflow | Invoke | Default mode | Output |
|---|---|---|---|
| **Learn** — absorb a topic / paper | `/flow:learn` | 🧠 Philosopher | `outputs/notes/` |
| **Write** — ideas → deliverable text (academic / regular) | `/flow:write` | 🧠 Philosopher | `outputs/drafts/` |
| **Research** — evidence-backed report | `/flow:research` | ⚙️ Engineer | `outputs/research/` |
| **Build** — idea → working project | `/flow:build` | ⚙️ Engineer | `outputs/build/` |
| **Plan** — goal → executable plan | `/flow:plan` | ⚙️ Engineer | `outputs/plans/` |
| **Analyze** — data / options → decision (decision / data) | `/flow:analyze` | ⚙️ Engineer | `outputs/analysis/` |
| 🔁 **Loop** — closed-loop delivery engine (orchestrates the others) | `/flow:loop` | ⚙️ Engineer | `outputs/loop/` |
| 👥 **Team** — parallel dev team (Planner + FE/BE engineers + Reviewer) | `/flow:team` | ⚙️ Engineer | `BOARD.md` in repo |

### Parallel dev team (`/flow:team`)

Run a project the way a small company does. **Planner** (you as tech-lead) decomposes the
spec into a task board and dispatches **Frontend** and **Backend** engineers *in parallel*
by directory ownership; a **Reviewer** hard-gates every ticket (nothing is Done without a
PASS; failures loop back with located findings). Separation of duties keeps parallel work
from colliding: only the Planner writes the board, only the owning engineer writes its
code, and the Reviewer only inspects. Shared contracts are frozen — changing one is an
interface change the Planner arbitrates. See [`skills/team/HANDBOOK.md`](./skills/team/HANDBOOK.md)
for the full contract and [`agents/`](./agents) for the role configs.

> `/flow:team` is **Claude-Code-only** — it orchestrates plugin subagents. The other 7
> skills also run in Codex (below).

### Two thinking modes

Orthogonal lenses you can apply to *any* workflow:

- 🧠 **Philosopher** — absorb-oriented. First principles, slow, ends in a forced
  output (a note / Feynman explanation) so understanding is verifiable.
- ⚙️ **Engineer** — ship-oriented. Time-boxed, convergent, ends in a deliverable
  plus a "how to apply" list.

Each workflow has a sensible default mode (see the table), and one word from you
switches it — e.g. *"learn transformers, engineer mode"*.

## Install

In Claude Code:

```
/plugin marketplace add Lemonaderrrrr/flow-kit
/plugin install flow@flow-kit
```

Then invoke any workflow, e.g. `/flow:learn transformers`, or just say
*"I want to learn X"* / *"draft me an email"* / *"which of these two should I pick?"* —
the skills trigger on natural language too.

### Using it with OpenAI Codex CLI

The plugin/marketplace mechanism is Claude-Code-specific, but the skills use the
same `SKILL.md` format Codex understands. One-click install into Codex:

```
curl -fsSL https://raw.githubusercontent.com/Lemonaderrrrr/flow-kit/main/codex/install.sh | bash
```

This drops the 7 skills into `~/.agents/skills/flow-*/` and adds the global
conventions to `~/.codex/AGENTS.md` (idempotent, safe to re-run). In Codex, run
`/skills` to pick one, or mention e.g. `$flow-learn`. See [`codex/`](./codex).

## One more step (recommended)

The skills work on their own, but the system is best with three **global
conventions** — mode routing, live-search, and output locations — that a plugin
can't inject for you. Copy the block in [`CONVENTIONS.md`](./CONVENTIONS.md) into
your project `CLAUDE.md`, or `~/.claude/CLAUDE.md` to apply it everywhere.

In short, the conventions make Claude:
- **route before acting** — pick workflow + mode and confirm in one line, every turn;
- **pull facts from the web live**, using training knowledge only for reasoning;
- **write outputs to predictable folders** and *offer* (never force) to promote the
  reusable ones.

## Customize

Every skill is a plain `SKILL.md` under [`skills/`](./skills). Fork and edit:

- change default modes, steps, or output paths;
- add an "anchor" to your own focus area, so Learn / Build connect new material to
  what you actually care about;
- translate the prompts to your language.

## Layout

```
.claude-plugin/
  marketplace.json   # marketplace entry
  plugin.json        # plugin manifest (name: flow, v1.5.0)
skills/
  learn/ write/ research/ build/ plan/ analyze/ loop/   # one SKILL.md each
  team/              # /flow:team — Planner manual + HANDBOOK + BOARD template
agents/              # dev-team subagents: engineer-frontend, engineer-backend, reviewer
CONVENTIONS.md       # the global-conventions block to paste into CLAUDE.md
codex/               # one-click Codex installer for the 7 portable skills
README.md
LICENSE
```

## License

MIT — see [LICENSE](./LICENSE).
