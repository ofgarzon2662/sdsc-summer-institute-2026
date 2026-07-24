# Facilitator guide

This guide supports the final 20 minutes of the session. The presenter has
already completed the 60-minute talk and 10-minute Q&A.

## Learning objective

Participants should leave knowing how notebook code becomes an importable
module, how a test captures a scientific assumption, and why a fresh command
line process is more predictable than notebook state.

## Before the session

From `tutorial/skydiver`, run:

```bash
python -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
python -m pip install -e ".[dev]"
nbdev-export
pytest -q
python -m skydiver.cli --mass 80 --drag 0.26
```

On Windows, activate with `.\.venv\Scripts\Activate.ps1`.

Expected result: all tests pass and the CLI reports approximately `54.94 m/s`
and `14.82 s`.

## Suggested pacing

| Time | Facilitation cue |
| --- | --- |
| 0-3 min | Help participants enter or activate the prepared environment. |
| 3-8 min | Point out `default_exp`, `export`, and the explicit gravity parameter. |
| 8-12 min | Run `nbdev-export`; compare the notebook with `physics.py`. |
| 12-16 min | Run tests; ask which scientific assumption each test protects. |
| 16-20 min | Run the CLI and connect it to automation, containers, and HPC jobs. |

## Recovery paths

- **Installation is slow:** use the prepared environment.
- **Jupyter will not open:** read the notebook on GitHub and continue at export.
- **nbdev is unavailable:** the generated `skydiver/physics.py` is committed;
  continue directly to `pytest`.
- **A participant changes gravity and forgets to restore it:** set the default
  to `9.81`, rerun `nbdev-export`, and rerun the tests.
- **Time is short:** demonstrate export once, then have everyone run the tests
  and CLI.

## Discussion prompt

Ask: "What assumption in your own research code deserves a test before you run
it for hours on an HPC system?"
