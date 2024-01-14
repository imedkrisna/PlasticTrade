library(tidyverse)
library(lubridate)
library(readxl)
library(patchwork)
library(scales)
options(scipen = 999)

setwd('C:/github/PlasticTrade/data')

pma<-read_excel('investasi.xlsx',sheet='PMA') |>
  pivot_longer(!c(tahun,kind),names_to="industri",values_to="values")

pmdn<-read_excel('investasi.xlsx',sheet='PMDN') |>
  pivot_longer(!c(tahun,kind),names_to="industri",values_to="values")

pmdn$tahun<-as.numeric(pmdn$tahun)
pma$tahun<-as.numeric(pma$tahun)

a<-pma |> filter(tahun>2010) |> filter(kind=="project") |>
  filter(industri=="(38-2020) Pengumpulan, Treatment dan Pembuangan Limbah dan Sampah serta Aktivitas Pemulihan Material") |>
  ggplot(aes(x=tahun,y=values))+geom_bar(stat="identity")+theme_classic()+
  scale_x_continuous(breaks = seq(min(pma$tahun), max(pma$tahun), by = 3))+
  scale_y_continuous(labels = comma)+
  labs(title="(a) FDI, no. of project",x="",y="")+
  theme(legend.position = "none",
        text = element_text(size = 10))
  

b<-pma |> filter(tahun>2010) |> filter(kind=="us1000") |>
  filter(industri== "(38-2020) Pengumpulan, Treatment dan Pembuangan Limbah dan Sampah serta Aktivitas Pemulihan Material") |> 
  ggplot(aes(x=tahun,y=values))+geom_bar(stat="identity")+theme_classic()+
  scale_x_continuous(breaks = seq(min(pma$tahun), max(pma$tahun), by = 3))+
  scale_y_continuous(labels = comma)+
  labs(title="(b) FDI, 1000 USD",x="",y="")+
  theme(legend.position = "none",
        text = element_text(size = 10))
  

c<-pmdn |> filter(tahun>2010) |> filter(kind=="project") |>
  filter(industri=="(38-2020) Pengumpulan, Treatment dan Pembuangan Limbah dan Sampah serta Aktivitas Pemulihan Material") |>
  ggplot(aes(x=tahun,y=values))+geom_bar(stat="identity")+theme_classic()+
  scale_x_continuous(breaks = seq(min(pmdn$tahun), max(pmdn$tahun), by = 3))+
  scale_y_continuous(labels = comma)+
  labs(title="(c) DDI, no. of project",x="",y="")+
  theme(legend.position = "none",
        text = element_text(size = 10))
  

d<-pmdn |> filter(tahun>2010) |> filter(kind=="us1000") |>
  filter(industri== "(38-2020) Pengumpulan, Treatment dan Pembuangan Limbah dan Sampah serta Aktivitas Pemulihan Material") |> 
  ggplot(aes(x=tahun,y=values))+geom_bar(stat="identity")+theme_classic()+
  scale_x_continuous(breaks = seq(min(pmdn$tahun), max(pmdn$tahun), by = 3))+
  scale_y_continuous(labels = comma)+
  labs(title="(d) DDI, 1000 USD",x="",y="")+
  theme(legend.position = "none",
        text = element_text(size = 10))
  
a+b+c+d
ggsave('../fig/investasi.png')

read_csv("icio/impor.csv") |>
  ggplot(aes(x=year,y=pctr))+geom_bar(stat="identity")+theme_classic()+
  scale_y_continuous(labels = comma)+
  labs(title="",x="",y="1000 USD")
ggsave('../fig/impor.png')