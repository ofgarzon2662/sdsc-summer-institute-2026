# Twenty-minute tutorial: from notebook to tested package

In this exercise you will turn a small skydiving calculation into reusable,
tested Python code. The complete project is already present so that you can
finish even if an export command or notebook interface is unavailable.

You do not need a GPU, Docker, Apptainer, or an SDSC account.

## Goal

At the end of 20 minutes you will have:

1. Identified reusable scientific logic in a notebook.
2. Exported that logic into a Python package with nbdev.
3. Run tests that protect a scientific assumption.
4. Called the result from the command line without notebook state.

## 0-3 minutes: prepare the environment

From this directory:

```bash
cd skydiver
python -m venv .venv
```

Activate the environment:

```bash
# macOS, Linux, TSCC, or Expanse
source .venv/bin/activate

# Windows PowerShell
.\.venv\Scripts\Activate.ps1
```

Install the project and tutorial tools:

```bash
python -m pip install --upgrade pip
python -m pip install -e ".[dev]"
```

If the instructor provided a prepared environment, activate it and skip the
installation.

## 3-8 minutes: inspect the notebook

Open `nbs/00_skydiver.ipynb` in Jupyter or VS Code. Notice:

- `#| default_exp physics` selects the package module.
- `#| export` marks definitions that belong in the package.
- The notebook still supports exploration and plotting.
- Gravity is a named parameter with the Earth default `9.81`, not hidden in a
  later cell.

The 2025 notebook described Earth gravity in its text but accidentally used
`g = 20` in code. That is exactly the kind of mismatch a test should expose.

## 8-12 minutes: export the package

Run:

```bash
nbdev-export
```

Then inspect `skydiver/physics.py`. nbdev generated it from the exported notebook
cells. The generated file is committed so that the tutorial remains usable even
when nbdev is unavailable. Older nbdev releases used the command name
`nbdev_export`; this project uses the current hyphenated CLI.

## 12-16 minutes: run the tests

```bash
pytest -q
```

The tests verify:

- the terminal velocity for an 80 kg skydiver under Earth gravity;
- the simulated velocity approaches the expected terminal velocity;
- invalid physical parameters fail clearly.

Change the default gravity in the notebook from `9.81` to `20`, export again,
and rerun the tests. One should fail. Restore `9.81`, export again, and continue.

## 16-20 minutes: run without notebook state

```bash
python -m skydiver.cli --mass 80 --drag 0.26
```

Expected output is approximately:

```text
Terminal velocity: 54.94 m/s downward
Time to reach 99% of terminal velocity: 14.82 s
```

This command starts a fresh Python process. It does not depend on which notebook
cells happened to run earlier.

## What changed?

The notebook remains the place to explain and explore the model. The package
now owns reusable calculations, the tests protect scientific assumptions, and
the CLI provides a predictable entry point for automation, containers, or HPC
jobs.

## Continue after the session

- Add a test for a different mass or drag coefficient.
- Build a wheel with `python -m build`.
- Add the test command to GitHub Actions.
- Place the CLI in a container and call it from an HPC job script.

The larger [`../mnist_ae`](../mnist_ae) snapshot shows those ideas in a
machine-learning project.
