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
dfsbowl <- tab[-(1:2),]
#tab <- tab[-c(1),]
head(dfsbowl)
names(dfsbowl) <- c("number", "date","site", "result")
head(dfsbowl)


#Converter primeira coluna de romanos, para numeros inteiros
dfsbowl$number <- 1:54
#Converter data 
dfsbowl$date <- as.Date(dfsbowl$date, "%B. %d,%Y")
head(dfsbowl)


#Separar coluna 4 em 2, vencedor e perdedor
dfsbowl <- separate(dfsbowl, result, c('winner', 'loser'), sep = ',')
head(dfsbowl)

# Regular expression/ encontrar padrao de digitos
pattern <- "\\d+$"
#cirar coluna com pontos de winner score
dfsbowl$winnerScore <- as.numeric(str_extract(dfsbowl$winner, pattern))
dfsbowl$loserScore <- as.numeric(str_extract(dfsbowl$loser, pattern))

# subistituir os digitos por vazio
dfsbowl$winner <- gsub(pattern,"", dfsbowl$winner)
dfsbowl$loser <- gsub(pattern,"", dfsbowl$loser)
#df <- dfsbowl[-8]
head(df)

#Gravr o resultado no arquivo csv
write.csv(df, 'superbowl.csv', row.names = F)
dir()
