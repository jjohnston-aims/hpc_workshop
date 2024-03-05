#!/bin/bash

# To give your job a name, replace "MyJob" with an appropriate name
#SBATCH --job-name=2019GDAL-test.slurm

# Run on four CPUs
#SBATCH --ntasks=4

# set your minimum acceptable walltime=days-hours:minutes:seconds
#SBATCH -t 0:15:00

# Specify your email address to be notified of progress.
# SBATCH --mail-user=youremailaddress@unimelb.edu.au
# SBATCH --mail-type=ALL

# Load the environment variables
module purge
# module load gcc?! 
# module load mpich/ge/gcc/64/3.3.2-192-cm9.1
module load gdal/3.4.2
 
# The commands to actually run the job

## List file types and output 
ogrinfo --formats > filetypes.txt

## Basic information of dataset
ogrinfo mydata.geojson > datasetinfo.txt

## Output polygon features
## mydata.geojson from Nancy Organ
ogrinfo -so mydata.geojson mydata > polygon.txt

## Save list of formats
ogr2ogr --formats > formats.txt

## Convert from GEOJSON to SHAPE
ogr2ogr -f "ESRI Shapefile" mydata.shp mydata.geojson
  
