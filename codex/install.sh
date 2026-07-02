#!/usr/bin/env bash
#
# One-click installer: claude-workflow-kit (`flow`) for OpenAI Codex CLI.
#
#   curl -fsSL https://raw.githubusercontent.com/Lemonaderrrrr/claude-workflow-kit/main/codex/install.sh | bash
#
# Installs the 7 workflow skills into Codex's skill directory and adds the
# global conventions to Codex's AGENTS.md. Safe to re-run (idempotent).
#
set -euo pipefail

REPO="${FLOW_REPO:-Lemonaderrrrr/claude-workflow-kit}"
BRANCH="${FLOW_BRANCH:-main}"
RAW="https://raw.githubusercontent.com/${REPO}/${BRANCH}"

SKILLS_DIR="${HOME}/.agents/skills"
CODEX_HOME="${CODEX_HOME:-${HOME}/.codex}"
AGENTS_MD="${CODEX_HOME}/AGENTS.md"

SKILLS=(learn write research build plan analyze loop)

say()  { printf '%s\n' "$*"; }
warn() { printf '%s\n' "$*" >&2; }

# Download with a few retries (handles flaky networks).
fetch() {
  local url="$1" dest="$2" i
  for i in 1 2 3 4 5; do
    if curl -fsSL --max-time 30 "$url" -o "$dest"; then return 0; fi
    sleep 2
  done
  warn "  ! failed to download: $url"
  return 1
}

command -v curl >/dev/null 2>&1 || { warn "curl is required but not found."; exit 1; }

say "==> Installing 'flow' skills into ${SKILLS_DIR}"
mkdir -p "${SKILLS_DIR}"
ok=0
for s in "${SKILLS[@]}"; do
  dir="${SKILLS_DIR}/flow-${s}"
  mkdir -p "${dir}"
  if fetch "${RAW}/skills/${s}/SKILL.md" "${dir}/SKILL.md"; then
    say "    ✓ flow-${s}"
    ok=$((ok+1))
  fi
done
say "    ${ok}/${#SKILLS[@]} skills installed."

# --- global conventions -> Codex AGENTS.md (idempotent, marker-guarded) --------
START="<!-- >>> claude-workflow-kit (flow) — global conventions >>> -->"
END="<!-- <<< claude-workflow-kit (flow) <<< -->"

say "==> Adding global conventions to ${AGENTS_MD}"
mkdir -p "${CODEX_HOME}"
touch "${AGENTS_MD}"
if grep -qF "${START}" "${AGENTS_MD}" 2>/dev/null; then
  say "    conventions already present — skipping."
else
  {
    printf '\n%s\n' "${START}"
    cat <<'CONV'
## Thinking-mode routing (run before every task)

Each turn, route before acting — don't blindly run an SOP or default to a mode:

0. Scan whether a `flow` skill applies (`$flow-learn` … or none). Every turn.
1. Which workflow? (learn / write / research / build / plan / analyze / loop / none)
2. Which thinking mode? (🧠 Philosopher = absorb-oriented / ⚙️ Engineer = ship-oriented)
3. Confirm in one line: "This looks like [X], I'd use [Y] mode — ok?"
4. Execute only after confirmation. One word can override.

## Live-search principle (facts come from the web, not memory)

Any external fact / data / current state → search the web live. Training knowledge
is for reasoning, organizing, and judgment only — never as the source of fact.
Cite sources; separate fact / inference / opinion.
Exempt: pure logic, math, and organizing my own notes.

## Two thinking modes (orthogonal lenses; apply to any workflow)

- 🧠 Philosopher — absorb/understand; slow, first-principles; ends in a forced
  output (Feynman / note) so understanding is verifiable.
- ⚙️ Engineer — produce/ship; time-boxed, convergent; ends in a deliverable + a
  "how to apply" list.

## Output locations

learn → outputs/notes/ · write → outputs/drafts/ · research → outputs/research/
build → outputs/build/ · plan → outputs/plans/ · analyze → outputs/analysis/
loop → outputs/loop/

Outputs stay in outputs/ by default. Only when an output is directional/reusable do
you *offer* to promote it — never automatic.
CONV
    printf '%s\n' "${END}"
  } >> "${AGENTS_MD}"
  say "    added."
fi

say ""
say "Done. In Codex, run /skills to pick one, or mention e.g. \$flow-learn."
if ! command -v codex >/dev/null 2>&1; then
  say "Note: the 'codex' CLI isn't on PATH yet — install Codex, then the skills are ready."
fi
