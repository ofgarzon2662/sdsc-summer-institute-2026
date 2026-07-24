#!/bin/bash
#SBATCH --job-name=skydiver
#SBATCH --output=skydiver.%j.%N.out
#SBATCH --partition=hotel-gpu
#SBATCH --qos=hotel-gpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --gpus=1
#SBATCH --mem=4G
#SBATCH --account=CHANGE_ME
#SBATCH --time=00:10:00

set -euo pipefail

module purge
module load gpu
module load slurm
module load singularity

CONTAINER="${CONTAINER:-skydiver.sif}"

# The tutorial command is a CPU-only smoke test. Replace it with your
# model's GPU entry point when adapting this template.
singularity exec --nv "$CONTAINER" python -m skydiver.cli --mass 80 --drag 0.26
