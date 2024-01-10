library(tidyverse)
library(lubridate)
library(readxl)

setwd('C:/github/PlasticTrade/data')

pma<-read_excel('investasi.xlsx',sheet='PMA') |>
  pivot_longer(!c(tahun,kind),names_to="industri",values_to="values")

pmdn<-read_excel('investasi.xlsx',sheet='PMDN') |>
  pivot_longer(!c(tahun,kind),names_to="industri",values_to="values")

pma |> filter(kind=="project") |>
  filter(industri==c("(39-2020) Aktivitas Remediasi dan Pengelolaan Limbah dan Sampah Lainnya",
"(38-2020) Pengumpulan, Treatment dan Pembuangan Limbah dan Sampah serta Aktivitas Pemulihan Material"
)) |> 
  ggplot(aes(x=tahun,y=values,color=industri))+geom_point()+theme(legend.position = "none")


pmdn |> filter(kind=="project") |>
  filter(industri== "(38-2020) Pengumpulan, Treatment dan Pembuangan Limbah dan Sampah serta Aktivitas Pemulihan Material") |> 
  ggplot(aes(x=tahun,y=values,color=industri))+geom_point()+theme(legend.position = "none")