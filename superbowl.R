library(rvest)
library(stringr)
library(tidyr)

url <- "http://www.espn.com/nfl/superbowl/history/winners"
pagina <- read_html(url)

tabela <- html_nodes(pagina, 'table')
class(tabela)

#convertendo objecto em tipo daraframe
tab <- html_table(tabela)[[1]]

class(tab)
head(tab)


# Removendo as duas primeiras linhas que são informação de título e referencia
tab
tab <- tab[-(1:2),]
tab <- tab[-c(1),]
head(tab)
names(tab) <- c("number", "date","site", "resultado")
head(tab)
