library("dplyr")
library("jsonlite")
library("ggplot2")
library("plotly")

# edit for file location
setwd("~/Documents/Projects/EHDEN_UKBiobank/compare_DQD_26Apr21/compare_DQD_results")

# List all differences
# ... BETWEEN OLD
file_old <- "../dqd_results_20210316.json"
result_old <- jsonlite::fromJSON(file_old)

check_results_old <- result_old$CheckResults %>%
  select(checkId, CHECK_NAME,
         CDM_TABLE_NAME, CDM_FIELD_NAME,
         THRESHOLD_VALUE, PCT_VIOLATED_ROWS,
         FAILED)

# ... AND NEW
file_new <- "../dqd_results_20210425.json"
result_new <- jsonlite::fromJSON(file_new)

check_results_new <- result_new$CheckResults %>%
  select(checkId, CHECK_NAME,
         CDM_TABLE_NAME, CDM_FIELD_NAME,
         THRESHOLD_VALUE, PCT_VIOLATED_ROWS,
         FAILED)

# ... only keep the different
combined_results <- tibble(check_results_old) %>%
  mutate(
    new_PCT_VIOLATED_ROWS = check_results_new$PCT_VIOLATED_ROWS
  ) %>%
  filter(PCT_VIOLATED_ROWS != new_PCT_VIOLATED_ROWS)


# Save as csv
write.csv(combined_results, file="different_checks.csv")


# Plot them - interactive
p <- combined_results %>%
  mutate(       # Otherwise legend names are overwritten by ggplotly
    fails = ifelse(FAILED==0, "Pass", "Fail")
  ) %>%
  ggplot(aes(x=PCT_VIOLATED_ROWS*100, y=new_PCT_VIOLATED_ROWS*100,
             colour=fails)) +
  geom_point() +
  geom_abline(colour="gray", linetype = "dashed")+
  scale_colour_manual(labels = c("Pass", "Fail"),
                      values = c("darkolivegreen3", "brown1"))+
  labs(x="Previous % of row fails", y="Current % of row fails") +
  theme_minimal()

ggplotly(p) %>%
     style(hovertemplate =paste(
      '<i>Check ID:</i>', combined_results$checkId,
      '<br><i>Check name:</i>', combined_results$CHECK_NAME,
      '<br><i>Table:</i>', combined_results$CDM_TABLE_NAME,
      '<br><i>Field:</i>', combined_results$CDM_FIELD_NAME,
      '<br><b><i>old %:</i> %{x:.2f}</b>',
      '<br><b><i>new %:</i> %{y:.2f}</b>')) %>%
    layout(legend=list(title=list(text=''))) # change legend title here or ggplot
