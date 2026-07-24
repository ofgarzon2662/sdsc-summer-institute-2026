# Deployment and HPC reference

These files support the presentation but are not part of the 20-minute
hands-on exercise.

| File | Purpose |
| --- | --- |
| `Dockerfile` | Build the tutorial package into a small OCI container. |
| `container-workflow.md` | Move from a Python package to Docker and then Singularity/Apptainer. |
| `github-actions-test.yml` | Example test-and-build workflow for a standalone repository. |
| `expanse-gpu.slurm` | One-GPU Expanse job template. |
| `tscc-gpu.slurm` | One-GPU TSCC Hotel job template. |

The SLURM files are templates. Replace `CHANGE_ME` with an allocation you are
authorized to use, check the current partitions with `sinfo`, and inspect
available container modules with `module spider singularity` or
`module spider apptainer`.

## Current SDSC references

These templates were checked in July 2026 against:

- [Expanse User Guide](https://www.sdsc.edu/systems/expanse/user_guide.html)
- [TSCC User Guide](https://www.sdsc.edu/systems/tscc/user_guide.html)
- [SDSC Python and Singularity training](https://hpc-training.sdsc.edu/hpc-training-docs/sdsc-summer-institute-2025/6.1_python_for_HPC/python_singularity/)

Expanse requires a valid project account and supports `gpu` and `gpu-shared`
partitions. TSCC requires both a partition and QOS; the Hotel GPU example uses
`hotel-gpu`. Scheduler policies and module names can change, so the user guides
remain the source of truth.
