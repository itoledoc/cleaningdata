Repository Description
======================

The cleaningdata repository consist af a single script `run_analysis.R`, a cookbook in Rmd (`cookbook.Rmd`) and Word (`cookbook.doc`) format, and this README text file.

The `run_analysis.R` script contains the code to read the HAR database, merge the training and
test data sets, extract the relevant measurements (features), rename them with human readable
strings, and save the tidy data set in a file called *clean_set.csv*. Additionally, it groups the data
by subject id and activity, and calculates the mean and starndar deviation of all the variables. This final
summary is saved as a tidy dataset in csv format, *clean_set.csv*

To execute the script the user should be in the root level of the data directory with the HAR database files.
