


#### modelling 
TEMPT <- my_data_clean_aug %>% 
  mutate(new_score_2  = expression_level/(mut_mhcrank_el+self_similarity))

my_data_clean_aug %>% 
  ggplot(aes( x = priority_score )) + 
  geom_line(stat = "count") + 
  facet_grid(.~response) 

TEMPT  %>% 
  ggplot(aes( x = new_score, y = self_similarity )) + 
  geom_point()+
  facet_grid(.~response) +
  scale_x_log10() +  
  scale_y_log10() + 
  geom_smooth(method='lm')

library(tidyverse)  # for data manipulation
library(dlstats)    # for package download stats
library(pkgsearch)
library(ROCR)

yes_df <- TEMPT %>% filter(response=="yes")
no_df <- TEMPT %>% filter(response=="no") %>% sample_n(50)

df <- rbind(yes_df,no_df )

TEMPT_without_dup <- subset(TEMPT, TEMPT$cell_line=="CT26")


TEMPT$label <-  ifelse(TEMPT$response=="yes", 1,0)
pred <- prediction(df$priority_score, df$label)
perf <- performance(pred,"tpr","fpr")
plot(perf,colorize=TRUE)


