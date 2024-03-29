library(jsonlite)
library(RCurl)
library(dplyr)
#queue=420 솔로랭크
#리그탭에서 summunerid가져오기 (그랜드마스터)
apikey <- "RGAPI-7431b287-a6fe-41ce-94bd-f41909a5ce64"
RoitURL_league <- "https://kr.api.riotgames.com/lol/league/v4/challengerleagues/by-queue/RANKED_SOLO_5x5"
url_legue <-paste0(RoitURL_league, paste0("?&api_key=", apikey))
aa_league<-getURL(url_legue)
head(aa_league)
class(aa_league)
ch.str=as.character(aa_league)
d_league=fromJSON(ch.str)
class(d_league)
df_league=data.frame(d_league)
class(df_league)
#df2=as.matrix(df)
#entries.summonerId를 통해 accountID 추출
i=1
aa_sum <- NULL
j<-nrow(df_league)
for(i in 1:j){ 
  a_lea<-df_league$entries.summonerId[i]
  RoitURL_sum <- paste0("https://kr.api.riotgames.com/lol/summoner/v4/summoners/",a_lea)#,뒷부분은 entries.summonerId
  url_sum <-paste0(RoitURL_sum, paste0("?&api_key=", apikey))
  a_sum<-fromJSON(getURL(url_sum))
  df_sum<-data.frame(a_sum)
  aa_sum<-rbind(aa_sum,df_sum)
}


head(aa_sum)
class(aa_sum)
ch.str=as.character(aa_sum)
df_sum=data.frame(ch.str)
write.csv(aa_sum,"gm_summunerid to account id.csv")
a1<-read.csv("gm_summunerid to account id.csv")

b1<-(a1$accountId)
View(b1)
b1[1]

#accountId통해 gameId 추출

i<-1
j<-nrow(df_league)
aa_acc<-NULL
for(i in i:j){ 
  acc_id<-b1[i]
  RoitURL_acc <- paste0("https://kr.api.riotgames.com/lol/match/v4/matchlists/by-account/",acc_id)#,accountId
  url_acc <-paste0(RoitURL_acc, paste0("?queue=420&season=13&api_key=", apikey))
  a_acc<-fromJSON(getURL(url_acc))
  df_acc<-data.frame(a_acc)
  aa_acc<-bind_rows(aa_acc,df_acc)
}

head(aa_acc)
class(aa_acc)
write.csv(aa_acc,"44_1.csv")
c1<-read.csv("44_1.csv")
d1<-c1$matches.gameId
head(d1)
nrow(c1)
d1<-unique(d1)
i<-1
j<-length(d1)
aa_mat<-NULL
p<-1
for(p in c(1:10)){
  ababab<-try(
for(i in i:j){ 
  mat_id<-d1[i]
  RoitURL_mat <- paste0("https://kr.api.riotgames.com/lol/match/v4/matches/",mat_id)#,matches.gameId
  url_mat <-paste0(RoitURL_mat, paste0("?api_key=", apikey))
  j_mat<-fromJSON(getURL(url_mat))
  un_mat<-unlist(j_mat)
  m_mat<-as.matrix(un_mat)
  df_mat<-as.data.frame(m_mat)
  df_mat<-t(df_mat)
  aa_mat<-merge(df_mat,aa_mat,all=TRUE)
  aa_mat[is.na(aa_mat)]<-0##결측치 처리

}
,silent = T
  )
  # game1<-unique(game1)
  if(class(ababab)=="try-error"){
    Sys.sleep(120)
  }
}
write.csv(aa_mat,"77_1.csv")

e1<-read.csv("77_1.csv")
e1<-unique(e1)
nrow(e1)
aa_mat<-e1


################매치탭에 있는 리스트들을 데이터프레임형식으로 바꾸기######
cc<-getURL("https://kr.api.riotgames.com/lol/match/v4/matches/4837300534?api_key=RGAPI-21e8313b-30a8-44d6-9e34-918e57c9a09e")
head(cc)
cc1<-fromJSON(cc)
class(cc1)
cc2<-unlist(cc1)
class(cc2)
head(cc2)
cc3<-as.matrix(cc2)
head(cc3)
cc4<-as.data.frame(cc3)
head(cc4)
cc5<-t(cc4)
head(cc5)
write.csv(a4,"77.csv")

e1