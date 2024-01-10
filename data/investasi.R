library(tidyverse)
library(lubridate)
library(readxl)
library(patchwork)

setwd('C:/github/PlasticTrade/data')

pma<-read_excel('investasi.xlsx',sheet='PMA') |>
  pivot_longer(!c(tahun,kind),names_to="industri",values_to="values")

pmdn<-read_excel('investasi.xlsx',sheet='PMDN') |>
  pivot_longer(!c(tahun,kind),names_to="industri",values_to="values")

pmdn$tahun<-as.numeric(pmdn$tahun)
pma$tahun<-as.numeric(pma$tahun)

a<-pma |> filter(tahun>2010) |> filter(kind=="project") |>
  filter(industri=="(38-2020) Pengumpulan, Treatment dan Pembuangan Limbah dan Sampah serta Aktivitas Pemulihan Material") |>
  ggplot(aes(x=tahun,y=values,color=industri))+geom_line()+theme(legend.position = "none")

b<-pma |> filter(tahun>2010) |> filter(kind=="us1000") |>
  filter(industri== "(38-2020) Pengumpulan, Treatment dan Pembuangan Limbah dan Sampah serta Aktivitas Pemulihan Material") |> 
  ggplot(aes(x=tahun,y=values,color=industri))+geom_line()+theme(legend.position = "none")

c<-pmdn |> filter(tahun>2010) |> filter(kind=="project") |>
  filter(industri=="(38-2020) Pengumpulan, Treatment dan Pembuangan Limbah dan Sampah serta Aktivitas Pemulihan Material") |>
  ggplot(aes(x=tahun,y=values,color=industri))+geom_line()+theme(legend.position = "none")

d<-pmdn |> filter(tahun>2010) |> filter(kind=="us1000") |>
  filter(industri== "(38-2020) Pengumpulan, Treatment dan Pembuangan Limbah dan Sampah serta Aktivitas Pemulihan Material") |> 
  ggplot(aes(x=tahun,y=values,color=industri))+geom_line()+theme(legend.position = "none")

a+b+c+d