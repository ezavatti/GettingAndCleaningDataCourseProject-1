# Getting and Cleaning Data Course Project

This project contains one R script([run_analysis.R](https://github.com/vinceyap88/GettingAndCleaningDataCourseProject/blob/master/run_analysis.R)) which will generate the average of each mesarements on the mean and standard  deviation per activity and per subject of the Human Activity Recognition Using Smartphones Data Set. The original input dataset can be obtained from [Cousera](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description of the input dataset is available at the [UCI](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

## R Packages Dependency

Additional R package `reshape2` is required to install before run the script. 

```{r}
install.package("reshape2")
```

## Execution of R Script

After the execution of [run_analysis.R](https://github.com/vinceyap88/GettingAndCleaningDataCourseProject/blob/master/run_analysis.R), the output dataset will be generated at [tidy_dataset.txt](https://github.com/vinceyap88/GettingAndCleaningDataCourseProject/blob/master/tidy_dataset.txt)

The description of the generated dataset can be found in [CookBook.md](https://github.com/vinceyap88/GettingAndCleaningDataCourseProject/blob/master/CodeBook.md)
