# Session 5.1: Best Practices for Scientific Computing

**SDSC Summer Institute 2026**

**Thursday, August 6, 2026, 8:30-10:00 AM Pacific**

**Presented by Fernando Garzon**

## Session summary

Research often begins in a Jupyter notebook, where ideas are easy to explore but
execution order, hidden state, local files, and one-off environments can make a
successful result difficult to reproduce. This session follows one notebook as
it matures into a tested Python package, an automated build, a container, and a
workflow that can run predictably on SDSC computing systems.

The session uses a 60/10/20 format:

- **60-minute talk:** notebook failure modes, packaging with nbdev, testing,
  GitHub Actions, containers, and HPC execution.
- **10-minute Q&A:** questions about applying the workflow to research code.
- **20-minute guided tutorial:** export a small skydiving model from a notebook,
  run its tests, and execute it as a command-line program.

By the end, attendees should understand that reproducibility is not only moving
a notebook to another machine. It is making the code's inputs, execution order,
dependencies, tests, and deployment path explicit.

## Start here

1. Read the [20-minute tutorial](tutorial/README.md).
2. Read the [slide-by-slide script](SLIDE_SCRIPT.md) without needing PowerPoint.
3. Open the [reference-edition PowerPoint](<slides/Architecting Reproducible Science - Summer Institute 2026 - Reference Edition.pptx>) or [PDF](<slides/Architecting Reproducible Science - Summer Institute 2026 - Reference Edition.pdf>).
4. Review the longer [talk write-up](TALK_NOTES.md).
5. Open the tutorial project in [`tutorial/skydiver`](tutorial/skydiver).
6. Use [`tutorial/FACILITATOR.md`](tutorial/FACILITATOR.md) when helping a group.
7. Browse the exact [`SummerInstitute-2025` snapshot](summer-institute-2025-snapshot).
8. Use [`mnist_ae`](mnist_ae) as the larger packaged-model backup example.

## Repository guide

| Path | Purpose |
| --- | --- |
| `SLIDE_SCRIPT.md` | Slide-by-slide visible content, takeaway, and narrative purpose. |
| `TALK_NOTES.md` | Reviewable write-up of the presentation's main argument and examples. |
| `tutorial/README.md` | Attendee instructions for the 20-minute exercise. |
| `tutorial/FACILITATOR.md` | Preflight checks, timing, expected results, and recovery steps. |
| `tutorial/skydiver/nbs/` | The small exploratory notebook used during the exercise. |
| `tutorial/skydiver/skydiver/` | Python package exported from the notebook, plus a CLI. |
| `tutorial/skydiver/tests/` | Fast tests for scientific assumptions and package behavior. |
| `summer-institute-2025-snapshot/` | Exact snapshot of the external 2025 tutorial repository requested during review. |
| `summer-institute-2025-snapshot/SOURCE.md` | Commit provenance and contents of that external-repository snapshot. |
| `mnist_ae/` | Snapshot of the larger packaged MNIST backup demonstration. |
| `mnist_ae/SOURCE.md` | Snapshot provenance and documented exclusions. |
| `resources/` | Container and SDSC HPC examples referenced during the talk. |
| `slides/` | Final PowerPoint and PDF presentation files. |

## What is intentionally not included

Local virtual environments, `.env` files, notebook checkpoints, build outputs,
and raw downloaded MNIST files are excluded. The tutorial does not require a
GPU, Docker, Apptainer, or access to an SDSC system.

## Further study

The tutorial demonstrates one short path through the workflow. The MNIST
snapshot shows the larger version: notebooks, an exported package, unit tests,
packaging metadata, release automation, and model-training code.
