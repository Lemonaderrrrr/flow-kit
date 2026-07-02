# Claude Workflow Kit — `flow`

A small, reusable **workflow system** for [Claude Code](https://code.claude.com).
Six work workflows plus a closed-loop delivery engine, each crossed with two
thinking modes — so you *absorb* knowledge and *ship* output deliberately instead
of ad hoc. It's all just files in a repo, so it works in the **CLI** and **on the web**.

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
/plugin marketplace add Lemonaderrrrr/claude-workflow-kit
/plugin install flow@claude-workflow-kit
```

Then invoke any workflow, e.g. `/flow:learn transformers`, or just say
*"I want to learn X"* / *"draft me an email"* / *"which of these two should I pick?"* —
the skills trigger on natural language too.

### Using it with OpenAI Codex CLI

The plugin/marketplace mechanism is Claude-Code-specific, but the skills use the
same `SKILL.md` format Codex understands. One-click install into Codex:

```
curl -fsSL https://raw.githubusercontent.com/Lemonaderrrrr/claude-workflow-kit/main/codex/install.sh | bash
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
  plugin.json        # plugin manifest (name: flow, v1.4.0)
skills/
  learn/ write/ research/ build/ plan/ analyze/ loop/   # one SKILL.md each
CONVENTIONS.md       # the global-conventions block to paste into CLAUDE.md
README.md
LICENSE
```

## License

MIT — see [LICENSE](./LICENSE).
