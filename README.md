## This File explains the project and associated data files for the course
## project for the Coursera class "Getting and Cleaning Data"
 
#Data Set Information:

 The experiments have been carried out with a group of 30 volunteers within an
 age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a  smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

 The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 


The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. 
These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. T
hen they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise.
 Similarly, the acceleration signal was then separated into body and gravity acceleration signals 
(denoted by "Body" or "Gravity" in the name) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals . 
Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (Where "Mag" is in the variable name). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals (indicated by "Frequency Domain"" in the variable name)

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

- The measures captured in this data set are only mean and standard deviation.  The measure "meanfreq" was present but was not kept.  
This measure is a weighted average of the frequency components and it ws not kept because our instructions were to only keep the means and standard deviation of each feature

The program run-analysis.R reads this data in, merges test and training, keeps
only mean and standard deviation values, renames fields , and creates a tidy data set, tidy_data_set.txt


##Notes: 
======
- Features are normalized and bounded within [-1,1].

