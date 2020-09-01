library(rvest)
library(knitr)
library(tidyverse)
install.packages("DT")
library(DT)

page <- read_html("http://www.imdb.com/chart/top")

page %>% html_nodes("p") %>%
  html_text()

titles <- page %>%
  html_nodes(".titleColumn") %>%
  html_text()

years <- page %>%
  html_nodes(".secondaryInfo") %>%
  html_text() %>%
  str_replace("\\(", "") %>% # remove (
  str_replace("\\)", "") %>% # remove )
  as.numeric()

scores <- page %>%
  html_nodes("#main strong") %>%
  html_text() %>%
  as.numeric()

imdb_top_250 <- tibble(
  title = titles, 
  year = years, 
  score = scores
)
imdb_top_250 %>% datatable(options(list(dom = "p", pageLength = 8)), height = 400)
