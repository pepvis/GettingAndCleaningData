require(dplyr)
require(tidyr)
require(stringr)

##read in data
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
features_df <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", quote="\"", stringsAsFactors = FALSE)
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", quote="\"", stringsAsFactors = FALSE)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", quote="\"", stringsAsFactors = FALSE)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", quote="\"", stringsAsFactors = FALSE)
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", quote="\"", stringsAsFactors = FALSE)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", quote="\"", stringsAsFactors = FALSE)

##combining the different data sets

#cleaning up activity_labels and making sure the levels are in order of the id
activity_labels <- activity_labels %>%
    rename(id = V1, activity = V2) %>%
    mutate(activity = factor(activity, levels = activity[1:6]),
           activity = tolower(activity))

#identify the variables for measurements on the mean and standard deviation
#(including only measurements on the mean and std proper, thereby exluding angle and meanFreq).
features_df <- features_df %>%
    mutate(include_me = str_detect(V2, fixed("mean()"))| str_detect(V2, fixed("std()")))

#cleaning: removing characters not allowed as variable names and fixing mistakes
features_df$V2 = gsub("BodyBody", "Body", features_df$V2)
features_df$V2 = gsub("\\(|\\)|\\,|\\-", "_", features_df$V2)

#combining x data, only the required variables
x_complete <- rbind(X_test, X_train)
names(x_complete) <- features_df[,2]
x_complete <- x_complete[,features_df$include_me]

#combining y data, while storing the source
y_test <- mutate(y_test, datasource = "test")
y_train <- mutate(y_train, datasource = "train")
y_complete <- rbind(y_test, y_train) %>%
    rename(activity_id = V1)

#combining subject data
subject_complete <- rbind(subject_test, subject_train) %>%
    rename(subject = V1)

#combining all data together
my_data <- cbind(subject_complete, y_complete) %>%
    cbind(x_complete) %>%
    left_join(activity_labels, by = c("activity_id" = "id")) %>%
    select(-activity_id, subject, activity, datasource:fBodyGyroJerkMag_std__)

##making the data tidy

#long/narrow form
my_data <- my_data  %>%
    mutate(row = 1:nrow(my_data)) %>%
    gather(messyvar, signal, -(subject:datasource), -row)

#treating features as variations of measurement on the signal - each variable in one column
my_data <- my_data  %>%
    mutate(domain = substring(messyvar, 1, 1),
           domain = ifelse(domain == "t", "time", "frequency"),
           sensor = ifelse(str_detect(messyvar, fixed("Gyro")) == TRUE, "gyroscope", "accelerometer"),
           jerk = str_detect(messyvar, fixed("Jerk")),
           gravity = str_detect(messyvar, fixed("Gravity")),
           acceleration_signal = ifelse(gravity == TRUE, "gravity",
                                        ifelse(jerk == TRUE, "jerk_of_the_body", "body")),
           measurement = ifelse(str_detect(messyvar, fixed("mean")) == TRUE, "signal_mean", "signal_std"),
           euclidean_vector = ifelse(str_sub(messyvar, -1) == "_",
                                     "magnitude", str_sub(messyvar, -1))) %>%
        select (-jerk, -gravity, -messyvar)

#considering each signal pattern is measured on mean and standard deviation, they are considered to be
#separate variables rather than variations on the signal pattern and need to be go into two seperate columns

my_data <- my_data %>%
    spread(measurement, signal) %>%
    arrange(row)

#creates a second, independent tidy data set with the average of each variable for each activity and
#each subject. Excluding 'row' and 'source' variables as they exist for reference purposes only.
signal_summary <- my_data %>%
    group_by(subject, activity, domain, sensor, acceleration_signal, euclidean_vector) %>%
    summarize(average_of_signal_means = mean(signal_mean), average_of_standard_deviation = mean(signal_std))


write.table(signal_summary, file = "signal_summary.txt", row.name=FALSE)
