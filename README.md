#READ ME
###Getting And Cleaning Data
This repo contains the files for the Coursera course project on getting and cleaning data.
It offers a script for cleaning and making 'tidy' the data collected from the accelerometers from the Samsung Galaxy S smartphone.
For a full explanation of tidy data please see http://vita.had.co.nz/papers/tidy-data.pdf

####Contents
* README.mkd - this file
* run_analysis.R - script for cleaning and making the data tidy.
* CodeBook.md - codebook explaining all variables and units in the resulting datafile. Formatted as a table to be viewed in a markdown editor/Github.

####Original dataset
The following dataset was used:
Human Activity Recognition Using Smartphones Dataset Version 1.0.
The data for the project is downloaded and extracted from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The run_analysis.R script goes in the directory in which the 'getdata_projectfiles_UCI HAR Dataset.zip' file was extracted.
It should contain a folder called 'UCI HAR Dataset', which includes 4 .txt files and two subfolders called 'test' and 'train'.

####Result
The output of the script can be read in to R using the following code:
```sh
$ file_path <- https://s3.amazonaws.com/coursera-uploads/user-56e52e178e2396d80d76db5d/973497/asst-3/60e6f980a16b11e4a086eb6039ebc13c.txt
$ data <- read.table(file_path, header = TRUE)
```

####Explanation of the run_analysis.R script
The script reads in the data from the different files of the original dataset.
It combines the test and training data from the X files and links it to the subjects (subject_test.txt and subject_train.txt)and the activity data Y.
Only the measurements on the mean and standard deviations are used (angle and meanFreq measurements are interpreted as different measurements from the mean and
standard deviation and therefore not included).

The activity_labels and features, used for giving the data meaningful variable names, have been cleaned by:
- ordering the levels of the activity labels
- correcting a duplication of "Body" in feature names ("BodyBody")
- replacing characters invalid for naming variables
- changing activity labels into lowercase

The subsequent combined data set has been made tidy (long form):

- each row contains one measurement on the signal pattern
- each column contains one variable, notifying characteristics of the signal pattern

##NB:

* Different transformations, filters and calculations have been applied to the raw signals. Rather than treating the outcome of each of the different manipulations as a separate variable, the information contained within each feature variable has been isolated and treated as a variation of the signal pattern measurement. This has the advantage of easier subsequent analysis. If needed, they can be easily concatenated into one variable.
* Considering each signal pattern is measured on mean and standard deviation, they are considered to be separate variables rather than variations on the signal pattern. Consequently, they have been put in different columns, signifying different measurements on the signal pattern.

####License:
>Use of this dataset in publications must be acknowledged by referencing the following publication [1] 
>[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
>This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.
>Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.


