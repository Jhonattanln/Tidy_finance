### Importando bibliotecas
library(tidyverse)
library(tidyquant)
library(ggplot2)
library(ggthemes)

### Importando dados
sapr <- tidyquant::tq_get('SAPR4.SA', get = 'stock.prices', from = '2020-01-01', to = Sys.Date()) ## dados referente a sanepar

### Criando gráfico de preços históricos
sapr %>%
  ggplot(aes(x=date, y=adjusted))+
  geom_line(size=0.8)+
  labs(
    x='Data',
    y=NULL,
    title='SANEPAR',
    subtitle = 'Preços ajustados - 2020-01-01 - Hoje'
  )+
  theme_hc()+
  scale_colour_hc()

### Criando séries de retornos
sapr_pct <- sapr %>%
  arrange(date) %>%
  mutate(ret = (adjusted - lag(adjusted)) / lag(adjusted)) %>% ## criando a difença entre os dias
  drop_na(ret) %>% ## excluindo os valores nulos
  select(symbol, date, ret)

### Plotando gráfico dos retornos
sapr_pct %>%
  ggplot(aes(x=ret*100))+
  geom_histogram(bins = 90, colour='black')+
  labs(
    x=NULL,
    y=NULL)+
  theme_hc()+
  scale_colour_hc()

### Estatisticas
sapr_pct %>%
  group_by(year = year(date)) %>%
  mutate(ret = ret*100) %>%
  summarize(across(
    ret,
    list(
      Média = mean,
      Desvio_padrão = sd,
      Mínima = min,
      Máxima = max
      ),
    .names = '{.fn}'
    ))
  