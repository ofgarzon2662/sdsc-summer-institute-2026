# Architecting Reproducible Science

These notes accompany the current presentation. They preserve the argument
behind the visual slides; they are not a word-for-word script.

## Session shape

- 60 minutes: presentation and short demonstrations
- 10 minutes: audience questions
- 20 minutes: hands-on work, with a facilitator

The hands-on portion uses a student-owned repository and the skydiver package.
It does not use TSCC, Docker, Singularity, or Apptainer. The deployment
extension is PyPI publication followed by installation and a small SLURM job on
Expanse.

## 1. The reproducibility horror

Milena has a strong model in a Jupyter notebook. During a high-stakes
demonstration she runs cells out of order, misses the optimization routine that
controls memory use, and freezes the notebook. Her mathematics did not suddenly
become wrong. The workflow depended on hidden state and an execution history
that existed only in her head.

The central question is:

> Can another person produce the same result from a clean environment without
> reconstructing the author's memory?

## 2. Notebooks and modular packages

Notebooks are excellent laboratories: exploration, plots, and quick iteration
are their strength. The risk is implicit behavior. A package makes reusable
behavior explicit through function arguments, stable import paths, installable
dependencies, tests, and a command-line entry point.

The point is not that notebooks are bad. The point is that research code needs a
clear boundary between exploratory state and reusable software.

## 3. Let us productionize the example

The historical MNIST example illustrates the larger notebook-to-package path.
The hands-on example is deliberately smaller: a skydiving model exported from
nbdev, tested as a package, and run through a CLI.

The transferable engineering ideas are small modules, one responsibility per
function, private implementation helpers where appropriate, no expensive work
at import time, clear documentation, and an explicit `main()` entry point.
AI assistance can accelerate refactoring, but it does not replace a testable
specification or a human review of the scientific assumptions.

## 4. GitHub Actions

The first automation should be tests and a build. GitHub Actions gives a
student-owned repository a clean checkout that repeats the local rule:

```bash
nbdev-export
git diff --exit-code
pytest -q
python -m build
```

The `git diff` check matters for notebook-derived packages: it detects an
exported notebook change that has not been committed as generated Python code.

The Summer Institute repository is a shared teaching artifact, so students copy
the seed project to a new repository rather than fork the full course
repository. Their repository is the place to own Actions, branches, releases,
and experiments.

## 5. Package release and Expanse

The package is built once, given a unique public name and immutable version, and
published to PyPI. Expanse installs that exact version into a virtual environment
and runs the package's same CLI under SLURM.

```text
notebook -> package -> tests -> wheel -> PyPI -> Expanse virtual environment -> SLURM job
```

This is intentionally a Python-package deployment example, not a container
lesson. A PyPI API token is only for local publication; it never belongs in Git,
GitHub Actions logs, or Expanse. For later automated releases, PyPI Trusted
Publishing is preferable to a long-lived stored token.

The skydiver CLI is CPU-only. Expanse is still useful in the example because it
makes the deployment boundary concrete: a clean environment can install an
identified artifact and run it through the scheduler. Real models should request
only the CPU, memory, time, and GPU resources they actually need.

## 6. Takeaways

The model did not need to change. The workflow did.

- Make execution order and inputs explicit.
- Turn scientific assumptions into tests.
- Keep reusable code modular and importable.
- Let CI repeat the clean-room test and build.
- Publish versioned artifacts rather than copying an untracked working folder.
- Keep secrets out of source control and separate publication credentials from
  HPC access.

Continue with the [attendee tutorial](tutorial/README.md) and its
[facilitator guide](tutorial/FACILITATOR.md).
