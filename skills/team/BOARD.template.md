# BOARD — <project name>

> Single source of truth for `/flow:team`. **Only the Planner edits this file.**
> Engineers and the Reviewer read it; they never write it.

## Project config (Planner fills at intake)
- goal: <one line>
- deliverable: <what "shipped" means>
- frontend_owns: `frontend/ app/ components/ src/ui/ src/pages/ public/ styles/`
- backend_owns: `backend/ server/ src/api/ src/services/ db/ migrations/`
- shared (read-only, Planner-gated): `src/shared/ packages/types/ openapi.* *.proto`
- commands:
  - fe_test: `<e.g. pnpm test>` · fe_lint: `<...>` · fe_build: `<...>`
  - be_test: `<e.g. pytest -q>` · be_lint: `<...>` · be_migrate: `<...>`
  - full_check: `<the whole suite you run before ship>`
- rework_cap: 3

## Columns
`Backlog → Todo → Doing → Review → Done`  · special: `Blocked`

---

## Backlog
<!-- tickets not yet ready to schedule -->

## Todo
<!-- deps met, waiting for dispatch -->

### T-001 · [SHARED] <contract-first ticket, e.g. define Order type + /orders schema>
- status: Todo
- owner: —
- layer: shared
- touches: src/shared/order.ts, openapi.yaml
- depends_on: —
- acceptance:
  - Order type has {id, items[], total, status}
  - /orders request/response documented in openapi.yaml
- review:
- rework_count: 0

## Doing
<!-- in flight; each ticket has exactly one owner and no touches-collision with peers -->

## Review
<!-- engineer finished; awaiting Reviewer verdict -->

## Done
<!-- Reviewer PASS only -->

## Blocked
<!-- exceeded rework cap, unresolved conflict, or needs the human -->

---

## Log (Planner appends; audit trail / resume point)
- <ts> created board, decomposed into N tickets
- <ts> T-001 Todo→Doing (engineer-backend)
- <ts> T-001 Doing→Review · Review→Done (reviewer PASS)
- <ts> T-004 REWORK #1 — findings: <short>
