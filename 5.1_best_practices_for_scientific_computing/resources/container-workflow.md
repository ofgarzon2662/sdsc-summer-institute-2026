# Package to container to HPC

Run these commands from the session directory.

## Build and test the wheel

```bash
cd tutorial/skydiver
python -m pip install -e ".[dev]"
nbdev-export
pytest -q
python -m build --wheel
cd ../..
```

## Build an OCI image locally

```bash
docker build -f resources/Dockerfile -t skydiver:0.1 .
docker run --rm skydiver:0.1 --mass 80 --drag 0.26
```

The image has one declared entry point and does not depend on notebook state.

## Convert or publish

If Apptainer is installed on the machine that runs Docker:

```bash
apptainer build skydiver.sif docker-daemon://skydiver:0.1
```

For an HPC system, publishing the OCI image to a registry is usually more
portable. On the cluster:

```bash
module spider singularity
module load singularitypro  # use the module shown on your system
singularity pull skydiver.sif docker://REGISTRY/USER/skydiver:0.1
singularity exec skydiver.sif python -m skydiver.cli --mass 80 --drag 0.26
```

Use `--nv` when the containerized application requires an allocated NVIDIA GPU:

```bash
singularity exec --nv model.sif python -m your_package.train
```

Do not build production images on an HPC login node. Build locally or in CI,
publish to a registry, and pull the immutable image onto the cluster.
