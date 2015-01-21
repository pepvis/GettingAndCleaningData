|VAR ID|VARIABLE|UNIT ID|UNIT|COMMENT
|:---:|:---:|:---:|:---:|:---:|:---:|
|1|subject| |range 1:30|An identifier of the subject who carried out the experiment
|2|activity| | |Activities performed by each subject of the experiment
| | |1|walking| 
| | |2|walking_upstairs| 
| | |3|walking_downstairs| 
| | |4|sitting| 
| | |5|standing| 
| | |6|laying| 
|3|domain| | |Variable signifying time domain or frequency  domain signals. The Fast Fourier Transform (FFT) was used to obtain frequency domain signals.
| | |1|time| 
| | |2|frequency| 
|4|sensor| | |Whether the signal pattern is obtained using embedded accelerometer or embedded gyroscope
| | |1|accelerometer| 
| | |2|gyroscope| 
|5|acceleration_signal| | |The acceleration on body, gravity or jerk of the body on the phone. Obtained by using low pass Butterworth filter with a corner frequency of 0.3 Hz as well as body linear acceleration and angular velocity (to calculate the jerk of the body).
| | |1|body| 
| | |2|gravity| 
| | |3|jerk_of_the_body| 
|6|euclidean_vector| | |Notifying whether the signal is mathematically vectorized  on the  X-axis, Y-Axis, Z-Axis, or calculated as the magnitude. 
| | |1|X| 
| | |2|Y| 
| | |3|Z| 
| | |4|magnitude| 
|7|average_of_signal_means| |units are normalized |average of the signal mean for each subject, activity and signal pattern variation
|8|average_of_standard_deviation| |units are normalized|average of the signal standard deviation for each subject, activity and signal pattern variation
