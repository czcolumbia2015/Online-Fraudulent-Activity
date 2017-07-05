# Online-Fraudulent-Activity

The goal of this project is to build a machine learning model that 
1).predicts the probability that the first transaction of a new user is fraudulent.
2).use ROC metric to check how cost of positives vs negatives would impact the model. 
3).use classification tree to see what kinds of users are more likely to be classified as at risk.

Fraud data has information about each user first transaction, including columns 

user_id
signup_time
purchase_time
purchase_value
device_id
source
browser
sex
age
ip_address
class: this is what i am trying to predict
lower_bound_ip_address
upper_bound_ip_address
country
