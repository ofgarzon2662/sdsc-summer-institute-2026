# Slide Script: Architecting Reproducible Science

This document specifies what should be visible on each slide and the main point
the presenter should make. It is intentionally useful on its own: readers can
follow the argument without hearing the live presentation.

The presentation keeps the original talk outline:

1. the reproducibility horror;
2. notebooks and packages;
3. notebook to package;
4. tests and GitHub Actions;
5. MLOps, containers, and HPC;
6. final remarks, questions, and tutorial.

## Slide 1: Architecting Reproducible Science: A Practical Path Beyond the Notebook

**Visible subtitle**

> A practical path beyond the notebook

Software engineering practices for reliable HPC workflows<br>
Fernando Garzon, SDSC Summer Institute 2026

**Purpose**

Set the promise: this is not a talk against notebooks. It is about making a
successful notebook trustworthy enough to share, test, automate, and run on a
computing system.

## Slide 2: The model worked. The workflow failed.

**Visible content**

- The model had strong back-tests and ran correctly on her laptop.
- The demonstration depended on cells executed in a particular order.
- A skipped optimization cell caused the notebook to exhaust memory.
- The scientific result did not suddenly become wrong; its execution was not
  reproducible.

**Visible takeaway**

> Hidden state turns a successful experiment into a fragile demonstration.

**Purpose**

Introduce the Milena video and ask the audience to diagnose the failure. The
full video transcript remains in the presenter notes.

## Slide 3: Notebook state hides dependencies

**Visible content**

| Hidden dependency | What another person experiences |
| --- | --- |
| Cell execution order | "Run all" produces a different result |
| Variables left in memory | A clean kernel raises an error |
| Local paths and data | The code works only on the author's laptop |
| Undeclared library versions | Results change after reinstalling |
| Expensive work during import | Tests and tools become slow or fail |

**Visible takeaway**

> If the workflow depends on memory or execution history, it is not yet a
> repeatable program.

## Slide 4: Four different workflow guarantees

**Visible content**

Terminology varies by field. In this talk:

- **Repeatable:** the same inputs and environment produce the same result again.
- **Reproducible:** another person can rebuild the environment and repeat the
  documented workflow.
- **Portable:** the same entry point runs on another machine or platform.
- **Scalable:** the algorithm and resource plan use larger systems effectively.

**Visible takeaway**

Packaging and containers improve repeatability and portability. They do not
automatically make an algorithm scalable.

## Slide 5: Notebooks and packages do different jobs

**Visible content**

**Use a notebook to**

- explore data and hypotheses;
- combine equations, code, and visualizations;
- document the reasoning behind an experiment.

**Use a package to**

- expose stable, importable functions;
- declare inputs, dependencies, and versions;
- support tests, automation, and multiple entry points.

**Visible takeaway**

> The durable workflow is notebook plus package, not notebook versus package.

## Slide 6: Move reusable code out of notebook state

**Visible content**

- Convert key calculations into functions with explicit arguments.
- Pass paths and configuration instead of reading machine-specific globals.
- Keep data downloads, training, and plotting behind callable entry points.
- Return values instead of relying on variables left in a notebook kernel.
- Guard expensive scripts with `if __name__ == "__main__":`.

**Visible takeaway**

The notebook remains the narrative interface; the package becomes the reusable
implementation.

## Slide 7: The skydiver model has a testable contract

**Visible content**

For a falling body with quadratic drag:

```text
terminal_velocity(mass, drag, gravity=9.81) -> meters/second
velocity_at_time(time, mass, drag)          -> meters/second
```

Contract:

- mass, drag, and gravity must be positive;
- velocity starts at zero and approaches a finite terminal value;
- increasing mass raises terminal velocity;
- increasing drag lowers terminal velocity.

**Visible takeaway**

Scientific assumptions become software behavior that can be checked.

## Slide 8: nbdev exports selected notebook cells

**Visible content**

```python
#| default_exp physics

#| export
def terminal_velocity(mass_kg, drag_coefficient, gravity=9.81):
    ...
```

```bash
nbdev-export
```

- The notebook remains the source for exported scientific functions.
- `#| export` identifies reusable cells.
- Generated modules should be committed and checked for unexpected changes.

**Visible takeaway**

Export rules replace "remember which cells matter" with a repeatable command.

## Slide 9: Every package artifact has a home

**Visible content**

```text
skydiver/
|-- nbs/00_skydiver.ipynb     # explanation and exported code
|-- skydiver/physics.py        # generated scientific functions
|-- skydiver/cli.py            # command-line entry point
|-- tests/test_physics.py      # scientific and interface checks
|-- pyproject.toml             # dependencies, version, build metadata
`-- README.md                  # how to install and run the project
```

**Visible takeaway**

A new collaborator should be able to find the model, tests, configuration, and
instructions without asking the author.

## Slide 10: Test first in a fresh process

**Visible content**

```bash
python -m venv .venv
python -m pip install -e ".[dev]"
nbdev-export
pytest -q
skydiver --mass 80 --drag 0.26
```

Expected result:

```text
Terminal velocity: 54.94 m/s downward
Time to reach 99% of terminal velocity: 14.82 s
```

**Visible takeaway**

The CLI proves that the calculation no longer depends on the notebook kernel.

## Slide 11: Tests should protect scientific meaning

**Visible content**

- **Known value:** Earth gravity and the example inputs produce the expected
  terminal velocity.
- **Invariant:** terminal velocity is positive and finite.
- **Relationship:** more mass increases the limit; more drag decreases it.
- **Boundary:** zero or negative physical parameters raise a clear error.
- **Interface:** scalar input returns a scalar and array input remains usable.

**Visible takeaway**

Coverage tells us which code ran. Scientific tests tell us which claims still
hold.

## Slide 12: CI repeats the clean-room workflow

**Visible content**

```text
checkout -> install -> export -> test -> build wheel
```

- CI starts from a clean machine rather than the author's current environment.
- Exported code can be checked for uncommitted notebook changes.
- Failed tests stop the release before an expensive or public step.
- The same commands remain available to developers locally.

**Visible takeaway**

GitHub Actions is not magic; it is the documented workflow executed
consistently.

## Slide 13: A wheel is a versioned Python artifact

**Visible content**

```bash
python -m build --wheel
python -m pip install dist/si2026_skydiver-0.1.0-py3-none-any.whl
```

- A wheel contains the package code and installation metadata.
- Version numbers identify exactly which implementation produced a result.
- CI should build the artifact after tests pass.
- Deployment should install the artifact instead of copying loose source files.

**Visible takeaway**

Build once, identify the version, and promote the same artifact.

## Slide 14: Containers record the runtime

**Visible content**

```dockerfile
FROM python:3.12-slim
COPY tutorial/skydiver/ /opt/skydiver/
RUN python -m pip install /opt/skydiver
ENTRYPOINT ["python", "-m", "skydiver.cli"]
```

- The wheel or package records Python code and dependencies.
- The container records the operating-system-level runtime and entry point.
- A container improves portability; tests are still required for correctness.
- Build images locally or in CI, not on a shared HPC login node.

**Visible takeaway**

A container preserves the environment. It does not validate the science.

## Slide 15: One entry point can travel everywhere

**Visible content**

```text
Notebook exploration
        |
Python package -> tests -> wheel -> container
                                      |
                         laptop / CI / TSCC / Expanse
```

- The calculation is not rewritten for each destination.
- Configuration and resource requests change; the application interface does
  not.
- Logs and outputs can be compared across environments.

**Visible takeaway**

Portability comes from a stable entry point plus a recorded environment.

## Slide 16: The scheduler owns HPC resources

**Visible content**

```bash
# Request resources with SLURM
#SBATCH --time=00:10:00
#SBATCH --mem=8G
#SBATCH --gpus=1

singularity exec --nv model.sif python -m your_package.train
```

- Request an account, partition/QOS, time, memory, CPUs, and GPUs explicitly.
- Use `--nv` only for an allocated NVIDIA GPU workload.
- Keep input data and outputs on appropriate project or scratch storage.
- Check the current SDSC user guide and `module spider`; policies and module
  names can change.

**Visible takeaway**

The skydiver tutorial is CPU-only. GPU examples are templates for the larger ML
workflow, not a reason to reserve an accelerator unnecessarily.

## Slide 17: MLOps is a feedback loop

**Visible content**

```text
package -> test -> build -> deploy -> observe -> improve
```

Record parameters, logs, outputs, and performance so observations from one run
can guide the next experiment.

**Visible takeaway**

For research software, MLOps means reducing uncertainty between an experiment
and every later execution.

## Slide 18: The model stayed. The workflow changed.

**Visible content**

- Make execution order explicit.
- Turn scientific assumptions into tests.
- Record dependencies, versions, inputs, and entry points.
- Build one artifact and run it consistently.
- Request HPC resources explicitly and measure before scaling.
- Keep notebooks as valuable interfaces to exploration and explanation.

**Visible takeaway**

> Reproducibility is a workflow, not a copy of the notebook.

## Slide 19: Questions, then the tutorial

**Visible content**

Questions may cover notebooks, packaging, tests, GitHub Actions, containers,
TSCC, or Expanse.

After Q&A:

1. Open `tutorial/README.md`.
2. Export the skydiver package.
3. Run six tests.
4. Execute the CLI from a fresh process.

**Visible closing prompt**

> What scientific assumption in your code deserves a test before you spend
> hours on an HPC system?
