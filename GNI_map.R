library(ggplot2)
library(data.table)
library(maps)

gni_ranking <- read.csv("C:\\Users\\Dell\\Documents\\GNI_Rank.csv")
gni_ranking <- data.table(gni_ranking)
colnames(gni_ranking)[which(names(gni_ranking) == "Country")] <- "region"
colnames(gni_ranking)[which(names(gni_ranking) == "Female.Population.with.secondary.education.or.higher....ages.25.or.older.")] <- "Female_Pop_Education"
colnames(gni_ranking)[which(names(gni_ranking) == "Share.of.Seats.for.Women.in.Parliament")] <- "Parliamentary_Seats_Women"
gni_ranking$Value <- as.numeric(as.character(gni_ranking$Value))
gni_ranking$Female_Pop_Education <- as.numeric(as.character(gni_ranking$Female_Pop_Education))
gni_ranking$Parliamentary_Seats_Women <- as.numeric(as.character(gni_ranking$Parliamentary_Seats_Women))
WorldData <- map_data('world')
all_merge_data <-merge(gni_ranking,WorldData,y.by="region")
all_merge_data$region<-factor(all_merge_data$region)
all_merge_data <- all_merge_data[order(all_merge_data$order),]
all_merge_data$Value <- as.numeric(as.character(all_merge_data$Value))

ggplot(all_merge_data, aes(long, lat, group = group))+
  geom_polygon(aes(fill = Value ), color = "white") + 
  theme_bw() +
  scale_fill_viridis_c(option = "C")

ggplot(gni_ranking, aes(x=Value, y= Female_Pop_Education)) +
  geom_jitter(color="blue") +
  geom_smooth() + 
  theme_bw()

gni_ranking_selected <- subset(gni_ranking, region %in% c("China", "India", "USA", "Netherlands", "Qatar"))
ggplot(gni_ranking_selected, aes(x=region, y=Parliamentary_Seats_Women)) +
  geom_bar(aes(fill=Value), position = "dodge", stat = "identity") +
  theme_bw() +
  scale_fill_viridis_c(option = "C")


