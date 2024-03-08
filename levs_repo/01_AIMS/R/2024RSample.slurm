# For R need to run on single CPU
#SBATCH --ntasks=1

# set your minimum acceptable walltime=hours:minutes:seconds
#SBATCH -t 0:15:00

# Specify your email address to be notified of progress.
# SBATCH --mail-user=youremailaddress@aims.gov.au
# SBATCH --mail-type=ALL

# Load the environment variables for R
module load R/4.1.3

# The command to actually run the job
R --vanilla < tutorial.R 
