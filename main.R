# This is the master file for tying together all the helper functions
library(modules) ## mandatory install

# expose the modules here
packages.Self <- modules::use("libs.R")
graphics.Self <- modules::use("graphics.R")
munging.Self <- modules::use("mungin.R")
network.Self <- modules::use("network.R")


# load libraries
pkg$getPackages()

# get data from network
movie_summary <- network$getDataFile("https://sixtusdakurah.com/projects/box-office/movie_summary.csv")
movie_ratings <- network$getDataFile("https://sixtusdakurah.com/projects/box-office/movie_ratings.csv")
weekend_boxoffice <- network$getDataFile("https://sixtusdakurah.com/projects/box-office/weekend_boxoffice.csv")

## take the total weekend boxoffice over several years
all_time_revenue <- weekend_boxoffice %>% group_by(movie_odid) %>% summarize( all_time_revenue = sum(total_revenue_at))

## take the most recent
current_revenue <- data.frame("movie_odid", "display_name", "chart_type", "chart_date", "ranked", "rank", "previous_rank", "revenue", "revenue_estimated", "tickets", "theaters", "total_revenue", "total_tickets", "days_in_release")
names(current_revenue) <- c("movie_odid", "display_name", "chart_type", "chart_date", "ranked", "rank", "previous_rank", "revenue", "revenue_estimated", "tickets", "theaters", "total_revenue", "total_tickets", "days_in_release")
ids <- unique(weekend_boxoffice$movie_odid)

for (i in 1:length(ids)) {
  aa = weekend_boxoffice[weekend_boxoffice$movie_odid==ids[i], ]
  row_ = aa[which.max( aa$chart_date), ] 
  current_revenue <- rbind(current_revenue, row_)
}


View(current_revenue)

## merge movie summary and ratings
dat1 <- merge(movie_summary, movie_ratings, by = "movie_odid")
dat1$month <- as.character(month(as.POSIXlt(dat1$release_date, format="%Y-%m-%d")))

## merge dat1 to all time revenue
dat2 <- merge(dat1, all_time_revenue, by = "movie_odid")

## merge dat2 to all time revenue
dat3 <- merge(dat2, current_revenue, by = "movie_odid")

## RATING

## Take a look at Rating and weekend revenue
p1 <- ggplot(dat1, aes(x=reorder(rating, opening_weekend_revenue, FUN = mean), y=opening_weekend_revenue)) + geom_boxplot() + xlab("Rating") +
  ylab("Opening Weekend Revenue")

## Take a look at the distribution of number of movies in that category
rating_count <- as.data.frame(table(dat1$rating))
p2 <- ggplot(dat1, aes(rating)) + geom_bar() + xlab("Rating") +
  ylab("Opening Weekend Revenue") +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))

## Are certain *rated movies released in certain months
p3 <- ggplot(dat1, aes(x=reorder(rating, opening_weekend_revenue, FUN = mean), y=opening_weekend_revenue, fill=month)) + geom_boxplot(outlier.shape = NA) + xlab("Rating") +
  ylab("Opening Weekend Revenue")


## PRODUCTION METHOD

p4 <- ggplot(dat1, aes(x= reorder(creative_type, opening_weekend_revenue, FUN = mean), y=opening_weekend_revenue)) + geom_boxplot(outlier.shape = NA) + xlab("Creative Type") +
  ylab("Opening Weekend Revenue")  +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))
# run a summary lm model
summary(lm(dat$opening_weekend_revenue~dat1$creative_type))


p5 <- ggplot(dat1, aes(x= reorder(production_method, opening_weekend_revenue, FUN = mean), y=opening_weekend_revenue)) + geom_boxplot(outlier.shape = NA) + xlab("Production Method") +
  ylab("Opening Weekend Revenue")  +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))
# run a summary lm model
summary(lm(dat$opening_weekend_revenue~dat1$production_method))


### SAVE PLOTS
jpeg("results/figs/p1.jpg")
p1
dev.off()

jpeg("results/figs/p2.jpg")
p2
dev.off()


jpeg("results/figs/p3.jpg")
p3
dev.off()


jpeg("results/figs/p4.jpg")
p4
dev.off()

jpeg("results/figs/p5.jpg")
p5
dev.off()


### 2019 movies, seven minutes to discuss that. Scoring: MSE
### Movies with OWR greater than the median of movies in 2019 - build a model without the 2019 data.



View(dat1)
