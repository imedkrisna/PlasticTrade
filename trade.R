setwd("C:/github/PlasticTrade")
library(tidyverse)
library(readxl)
library(patchwork)

## arrange final data
eu<-read_excel("data/trade.xlsx",sheet="eu")|>
  select(period,partnerISO,partnerDesc,cmdCode,qty,cifvalue)
eu2<-eu|>group_by(period,cmdCode)|>
  summarise(qty=sum(qty),cifvalue=sum(cifvalue))
eu2$partnerISO<-"EU"
eu2$partnerDesc<-"European Union"

rest<-read_excel("data/trade.xlsx",sheet="rest")|>
  select(period,partnerISO,partnerDesc,cmdCode,qty,cifvalue)
wew<-rbind(rest,eu2)|>
  arrange(period,cmdCode,partnerISO)
wew$period<-as.numeric(wew$period)

## Fig 1. total import

wew|>filter(partnerISO=="W00" & cmdCode!="3915")|>
  ggplot(aes(fill=cmdCode,x=period,y=qty/1000))+
  geom_bar(position="stack",stat="identity")+
  scale_x_continuous(expand = c(0,0))+
  scale_y_continuous(expand = c(0,0),labels = scales::comma)+
  scale_fill_manual(values=c("391510"="red",
                             "391520"="darkgreen",
                             "391530"="purple",
                             "391590"="blue"))+
  labs(x="",
       y="",
       fill="")+
  theme_classic()
ggsave("fig/fig1.png",width=6,height=4)

## Fig 1 but large fotns

wew|>filter(partnerISO=="W00" & cmdCode!="3915")|>
  ggplot(aes(fill=cmdCode,x=period,y=qty/1000))+
  geom_bar(position="stack",stat="identity")+
  scale_x_continuous(expand = c(0,0))+
  scale_y_continuous(expand = c(0,0),labels = scales::comma)+
  scale_fill_manual(values=c("391510"="red",
                             "391520"="darkgreen",
                             "391530"="purple",
                             "391590"="blue"))+
  labs(x="",
       y="",
       fill="")+
  theme_classic()+theme(text=element_text(size=23))
ggsave("fig/fig1a.png",width=6,height=4)

## Fig 2. import by partner

fusa<-wew|>filter(partnerISO=="USA" & cmdCode!="3915")|>
  ggplot(aes(fill=cmdCode,x=period,y=qty/1000))+
  geom_bar(position="stack",stat="identity")+
  scale_x_continuous(expand = c(0,0))+
  scale_y_continuous(expand = c(0,0),labels = scales::comma)+
  scale_fill_manual(values=c("391510"="red",
                             "391520"="darkgreen",
                             "391530"="purple",
                             "391590"="blue"))+
  labs(title="(a) import from USA",
       x="",
       y="",
       fill="")+
  theme_classic()+theme(legend.position = "none")

faus<-wew|>filter(partnerISO=="AUS" & cmdCode!="3915")|>
  ggplot(aes(fill=cmdCode,x=period,y=qty/1000))+
  geom_bar(position="stack",stat="identity")+
  scale_x_continuous(expand = c(0,0))+
  scale_y_continuous(expand = c(0,0),labels = scales::comma)+
  scale_fill_manual(values=c("391510"="red",
                             "391520"="darkgreen",
                             "391530"="purple",
                             "391590"="blue"))+
  labs(title="(b) import from Australia",
       x="",
       y="",
       fill="")+
  theme_classic()+theme(legend.position = "none")
  

feu<-wew|>filter(partnerISO=="EU" & cmdCode!="3915")|>
  ggplot(aes(fill=cmdCode,x=period,y=qty/1000))+
  geom_bar(position="stack",stat="identity")+
  scale_x_continuous(expand = c(0,0))+
  scale_y_continuous(expand = c(0,0),labels = scales::comma)+
  scale_fill_manual(values=c("391510"="red",
                             "391520"="darkgreen",
                             "391530"="purple",
                             "391590"="blue"))+
  labs(title="(c) import from EU",
       x="",
       y="",
       fill="")+
  theme_classic()


fchn<-wew|>filter(partnerISO=="CHN" & cmdCode!="3915")|>
  ggplot(aes(fill=cmdCode,x=period,y=qty/1000))+
  geom_bar(position="stack",stat="identity")+
  scale_x_continuous(expand = c(0,0))+
  scale_y_continuous(expand = c(0,0),labels = scales::comma)+
  scale_fill_manual(values=c("391510"="red",
                             "391520"="darkgreen",
                             "391530"="purple",
                             "391590"="blue"))+
  labs(title="(d) import from China",
       x="",
       y="",
       fill="")+
  theme_classic()+theme(legend.position = "none")

fusa+faus+feu+fchn+plot_layout(guide = "collect") & theme(text=element_text(size=9))
ggsave("fig/fig2.png",width=6,height=4)