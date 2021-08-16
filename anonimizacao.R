library(readr)
library(dplyr)


db <- read_csv("~/R/Aulas/aulaShiny/normativa.csv")

colunas <- names(db[,3:8])

db_novo <- db

for (i in 1:length(colunas)) {

  unicos <- data.frame(
    original = unique(db[,colunas[i]]),
    novo = 1:nrow(unique(db[,colunas[i]]))
  )

  db_novo <- left_join(db_novo, unicos, by = colunas[i])
}

db_novo$unico <- 1:nrow(db_novo)

nomes_novos <- names(db_novo[,(ncol(db_novo)-length(colunas)): ncol(db_novo)])

db_novo$indicador_anonimizado <- do.call(
  paste0,
  db_novo[,nomes_novos]
)

remove <- c(colunas, nomes_novos)

db_novo <- db_novo[,-which(names(db_novo) %in% remove)]

db_novo
