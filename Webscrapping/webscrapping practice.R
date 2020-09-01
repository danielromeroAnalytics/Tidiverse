install.packages("xml2")
install.packages("stringr")
install.packages("robotstxt")
library(rvest)
library(xml2)
library(stringr)
library(robotstxt)

url<-"https://www.amazon.in/Test-Exclusive-237/dp/B071Z97T2C/ref=pd_vtp_107_6/258-9239741-1508102?_encoding=UTF8&pd_rd_i=B071Z97T2C&pd_rd_r=c9f842dc-80b8-42dd-8299-d5a8b6d03d08&pd_rd_w=RHcYt&pd_rd_wg=IVCbz&pf_rd_p=139d47d7-738e-46e1-a26e-36c93232f032&pf_rd_r=TQNJE84RCZ82QS4H0BYS&psc=1&refRID=TQNJE84RCZ82QS4H0BYS"

paths_allowed(paths=c(url))

#leer el contenido html de la pagina
webpage=read_html(url)

#Extraer el titulo o nombre del producto
title <- webpage %>% html_nodes("h1#title") %>% html_text()
head(title)
title=str_replace_all(title,"[\r\n]","")
#str_trim() es otra opcion
head(title)

price=webpage %>% html_nodes("span#priceblock_ourprice") %>% html_text()
price <- str_replace_all(price, "[\u20b9]" , "")

# print price value
head(price)


# Extraer la valoración del producto
rate = webpage %>% html_nodes("span#acrPopover") %>% html_text()
head(rate)
rate <- str_replace_all(rate, "[\r\n]" , "")
rate <- str_trim(rate)
rate = rate[1]

# Guardar los datos en un data frame
product_name = data.frame(Titulo = title, Precio = price, Valoracion = rate)
View(product_name)


library(selectr)
library(tidyverse)

url2<-"https://www.imdb.com/chart/top/?ref_=nv_mv_250"
paths_allowed(paths=url2)

imdb <- read_html(url2)

#scrape 1: Titulo
titulo <- imdb %>% html_nodes("td.titleColumn a") %>% html_text()
titulo

year <- imdb %>% html_nodes("span.secondaryInfo") %>% html_text() %>% str_sub(start=2,end=5) %>% 
      as.numeric()
year
