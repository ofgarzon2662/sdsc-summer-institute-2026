# Deployment reference

The 2026 tutorial deployment path is:

```text
student-owned GitHub repository -> tests and wheel -> PyPI -> Expanse virtual environment -> SLURM job
```

Start with [PyPI and Expanse workflow](expanse-pypi-workflow.md). It explains
unique package names, versions, `.env` and token safety, TestPyPI versus PyPI,
and the CPU-only Expanse job used for skydiver.

| File | Purpose |
| --- | --- |
| `expanse-pypi-workflow.md` | Current tutorial deployment guide. |
| `github-actions-test.yml` | Test-and-build template from the older nested course layout; adapt it as described in `tutorial/README.md`. |
| `expanse-gpu.slurm` | Historical GPU/container reference. Not used in the skydiver tutorial. |
| `tscc-gpu.slurm` | Historical TSCC reference. Not used in this session. |
| `Dockerfile` | Historical container reference. Not used in this session. |
| `container-workflow.md` | Historical note explaining why containers are outside the 2026 tutorial. |

Expanse details, partitions, module names, and allocation policies can change.
Use the [Expanse User Guide](https://www.sdsc.edu/systems/expanse/user_guide.html)
as the operational source of truth.
