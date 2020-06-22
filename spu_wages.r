library(ggplot2)
library(data.table)
library(ggpubr)
wageData <- read.csv("WageData.csv")
wageData <- data.table(wageData)
random_order <- sample(nrow(wageData))
wageData <- wageData[random_order] 
wageData_subset <- wageData[1:200]

ggplot(wageData_subset, aes(x=Department, y=Hourly.Rate)) +
  geom_bar(aes(fill=Job.Title), position = "dodge", stat = "identity", show.legend = FALSE) +
  labs(title="Cluster Bar Chart",
       x = "Department",
       y = "Hourly Rate")
wdSub <- subset(wageData_subset, Department %in% c("Seattle City Light", "Police Department", "Seattle Dept of Transportation"))
ggplot(wdSub, aes(x=Department, y=Hourly.Rate)) +
  geom_bar(aes(fill=Job.Title), position = "dodge", stat = "identity") +
  labs(title="Cluster Bar Chart",
       x = "Department",
       y = "Hourly Rate")


ggballoonplot(wageData_subset, x = "Department", y = "Job.Title", size = "Hourly.Rate",
              fill = "Hourly.Rate", 
              ggtheme = theme_bw()) +
  scale_fill_viridis_c(option = "C")



 
