#=
Julia Ecology Example.

This is inspired from Timothée Poisot's (abandoned, only partially initiated) julia-ecology-lesson, itself a fork from the Software Carpentry 
equivalient that uses Python and has been converted to a Slurm script. It can, of course, be run in an interactive mode to show the 
functions.

https://github.com/tpoisot/julia-ecology-lesson

The example uses the Portal Teaching data, a subset of the data from Ernst *et al.* "Long-term monitoring and experimental manipulation of a 
Chihuahuan Desert ecosystem near Portal, Arizona, USA. 

http://www.esapubs.org/archive/ecol/E090/118/default.htm

We are studying the species and weight of animals caught in plots in our study area. 

The dataset is stored as a `.csv` file: each row holds information for a single animal, and the columns represent:

| Column            | Description                   |
|:------------------|:------------------------------|
| `record_id`       | Unique id for the observation |
| `month`           | month of observation          |
| `day`             | day of observation            |
| `year`            | year of observation           |
| `plot_id`         | ID of a particular plot       |
| `species_id`      | 2-letter code                 |
| `sex`             | sex of animal ("M", "F")      |
| `hindfoot_length` | length of the hindfoot in mm  |
| `weight`          | weight of the animal in grams |

=#

## Change your directory, otherwise it will download, read, and write to $HOME! e.g.,
cd("$(homedir())/Julia/ecology")

## download function requires a URL and a name of the file to write to.

download("https://ndownloader.figshare.com/files/2292172", "surveys.csv")

# One of the best options for working with tabular data in Julia is to use the DataFrames.jl package. It provides data structures, and 
# integrates nicely with other tools like Gadfly for plotting, and SQLite packages.
# Add the package if it hasn't already been installed.

Pkg.add("DataFrames")
using DataFrames

# Read the dataframe. A handy command!
# Adding the semi-colon at the end of readtable() function prevents the output from being displayed to standard output.
# Remove this if running the example in interactive mode.

surveys_df = readtable("surveys.csv");

# Determine the type, names of titles
# Display the species field, determineunique species
# See the following "cheat sheet" for Dataframes
# https://jcharistech.wordpress.com/julia-dataframes-cheat-sheets/

typeof(surveys_df)
names(surveys_df)
surveys_df[:,:species_id]
species=unique(surveys_df,:species_id)

# Write out the table 
writetable("species.csv", species)
