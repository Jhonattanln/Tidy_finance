### Importando bibliotecas
library(tidyverse)
library(tidyquant)
library(ggplot2)

sapr <- tidyquant::tq_get('SAPR3.SA', get = 'stock.prices', from = '2020-01-01', to = Sys.Date())

sapr %>%
  ggplot(aes(x=date, y=adjusted))+
  geom_line()+
  labs(
    x='Data',
    y='SAPR3',
    title='SANEPAR',
    subtitle = 'Preços ajustados - 2020-01-01 - '
  )
