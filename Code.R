### Importando bibliotecas
library(tidyverse)
library(tidyquant)
library(ggplot2)

### Importando dados
sapr <- tidyquant::tq_get('SAPR4.SA', get = 'stock.prices', from = '2020-01-01', to = Sys.Date()) ## dados referente a sanepar

### Criando gráfico de preços históricos
sapr %>%
  ggplot(aes(x=date, y=adjusted))+
  geom_line()+
  labs(
    x='Data',
    y='SAPR3',
    title='SANEPAR',
    subtitle = 'Preços ajustados - 2020-01-01 - Hoje'
  )

### Criando séries de retornos
sapr_pct <- sapr %>%
  arrange(date) %>%
  mutate(ret = (adjusted - lag(adjusted)) / lag(adjusted)) %>% ## criando a difença entre os dias
  drop_na(ret) %>% ## excluindo os valores nulos
  select(symbol, date, ret)

### Plotando gráfico dos retornos
sapr_pct %>%
  ggplot(aes(x=ret*100))+
  geom_histogram(bins = 80)+
  labs(
    x=NULL,
    y=NULL)

  