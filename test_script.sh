#!/bin/bash
#
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --time=0-02:00:00
#SBATCH --mem=16GB
#SBATCH --job-name=canvas_single_cell_imaging
#SBATCH --mail-type=ALL
#SBATCH --mail-user=pa2439@nyu.edu
#SBATCH --output=slurm_out/slurm_%j.out
#SBATCH --gres=gpu:2
#SBATCH --account=pr_263_general

module purge
module load anaconda3/2020.07;
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK;
source /share/apps/anaconda3/2020.07/etc/profile.d/conda.sh;
conda activate ../conda_env;
export PATH=../conda_env/bin:$PATH;

python src/canvas/run_inference.py --ckpt_num 20 --config_root canvas_examples/Sorin_2023/configs --data_root canvas_examples/Sorin_2023/data
