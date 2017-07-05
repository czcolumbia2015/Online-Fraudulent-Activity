install.packages("dplyr")
library("dplyr")

Fraud_data = read.csv("/Users/chenzheng/Documents/DS Interview Materials/Fraud/Fraud_Data.csv")
IP_Country = read.csv("/Users/chenzheng/Documents/DS Interview Materials/Fraud/IpAddress_to_Country.csv")
###check the data structure, 
str(Fraud_data)
Fraud_data$class = as.factor(Fraud_data$class)
summary(Fraud_data)
head(Fraud_data)
sort(unique(Fraud_data$age), decreasing = TRUE)
length((unique(Fraud_data$user_id)))==length((Fraud_data$user_id))


#### feature engineering
data_country = rep(NA, nrow(Fraud_data))
for (i in 1: nrow(Fraud_data)){
    tmp = as.character(IP_Country[Fraud_data$ip_address[i] >= IP_Country$lower_bound_ip_address &
                                    Fraud_data$ip_address[i] <= IP_Country$upper_bound_ip_address, "country"])
    if(length(tmp)==1){data_country[i]=tmp}
}

Fraud_data$Country = data_country

Fraud_data$purchase_signup_diff = as.numeric(difftime(as.POSIXct(Fraud_data$purchase_time, tz = "GMT"), 
                                           as.POSIXct(Fraud_data$signup_time, tz = "GMT"), units = "secs"))




Fraud_data = Fraud_data %>% group_by(device_id) %>% mutate(device_count = n())
Fraud_data = Fraud_data %>% group_by(ip_address) %>% mutate (ip_count=n())


Fraud_data$signup_time_wd = format(as.Date(Fraud_data$signup_time), "%A")
Fraud_data$purchase_time_wd = format(as.Date(Fraud_data$purchase_time), "%A")

Fraud_data$signup_time_num = format(as.Date(Fraud_data$signup_time), "%W")
Fraud_data$purchase_time_num = format(as.Date(Fraud_data$purchase_time), "%U")
Fraud_data$Country[is.na(Fraud_data$Country)]="Not Found"
Fraud_data[sapply(Fraud_data, is.character)] = lapply(Fraud_data[sapply(Fraud_data, is.character)], as.factor)
