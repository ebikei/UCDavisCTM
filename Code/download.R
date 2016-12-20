x<-c("dplyr","ggplot2","data.table","XML",'stringr','zoo')
#x<-c("dtplyr","ggplot2","XML",'stringr')
lapply(x, require, character.only=T)

drive=c("K:\\Research\\CA_EnvJustice")
setwd(drive)

url='http://webwolf.engr.ucdavis.edu/data/soa/monthly_avg/'
linkurl=getHTMLLinks(url) %>%
	str_split_fixed(.,".cs",2) %>%
	data.frame()

linkurl2=filter(linkurl,X2=='v') %>%
	select(X1)

linkurl2$X1=as.character(linkurl2$X1)
linkurl2$datatype=str_sub(linkurl2$X1,-20,-15)
linkurl2$poltype=substr(linkurl2$X1,1,5)

#################
### PM_Ba Cal24km
#################
PM25url_24km=filter(linkurl2,poltype=='PM_Ba',datatype=='ca24km')
output=data.frame()

for (i in 1:dim(PM25url_24km)[1]){
DL_url=paste("http://webwolf.engr.ucdavis.edu/data/soa/monthly_avg/",PM25url_24km$X1[i],".csv",sep='')
temp=read.csv(DL_url)
temp2=mutate(temp,YearMonth=paste('15',str_sub(DL_url,-9,-5),sep=''),
		scale='cal24km',
		date=as.Date(YearMonth,format="%d%y%b")) %>%
      select(-YearMonth)
output=rbind(temp2,output)
rm(temp)
rm(temp2)
}
PM1025_Cal24km=output
save(PM1025_Cal24km,file='Data\\PM1025_Cal24km.RData')
rm(output)


#################
### PM0.1 Cal24km
#################
PM25url_24km=filter(linkurl2,poltype=='PM0.1',datatype=='ca24km')
output=data.frame()

for (i in 1:dim(PM25url_24km)[1]){
DL_url=paste("http://webwolf.engr.ucdavis.edu/data/soa/monthly_avg/",PM25url_24km$X1[i],".csv",sep='')
temp=read.csv(DL_url)
temp2=mutate(temp,YearMonth=paste('15',str_sub(DL_url,-9,-5),sep=''),
		scale='cal24km',
		date=as.Date(YearMonth,format="%d%y%b")) %>%
      select(-YearMonth)
output=rbind(temp2,output)
rm(temp)
rm(temp2)
}
PM01_Cal24km=output
save(PM01_Cal24km,file='Data\\PM01_Cal24km.RData')
rm(output)


#################
### PM_Ba scb4km
#################

PM25url_4km_scb=filter(linkurl2,poltype=='PM_Ba',datatype=='scb4km')
output=data.frame()

for (i in 1:dim(PM25url_4km_scb)[1]){
DL_url=paste("http://webwolf.engr.ucdavis.edu/data/soa/monthly_avg/",PM25url_4km_scb$X1[i],".csv",sep='')
temp=read.csv(DL_url)
temp2=mutate(temp,YearMonth=paste('15',str_sub(DL_url,-9,-5),sep=''),
		scale='scb4km',
		date=as.Date(YearMonth,format="%d%y%b")) %>%
      select(-YearMonth)
output=rbind(temp2,output)
rm(temp)
rm(temp2)
}
PM1025_scb4km=output
save(PM1025_scb4km,file='Data\\PM1025_scb4km.RData')
rm(output)

#################
### PM_0.1 scb4km
#################

PM25url_4km_scb=filter(linkurl2,poltype=='PM0.1',datatype=='scb4km')
output=data.frame()

for (i in 1:dim(PM25url_4km_scb)[1]){
DL_url=paste("http://webwolf.engr.ucdavis.edu/data/soa/monthly_avg/",PM25url_4km_scb$X1[i],".csv",sep='')
temp=read.csv(DL_url)
temp2=mutate(temp,YearMonth=paste('15',str_sub(DL_url,-9,-5),sep=''),
		scale='scb4km',
		date=as.Date(YearMonth,format="%d%y%b")) %>%
      select(-YearMonth)
output=rbind(temp2,output)
rm(temp)
rm(temp2)
}
PM01_scb4km=output
save(PM01_scb4km,file='Data\\PM01_scb4km.RData')
rm(output)


#################
### PM_Ba sjv4km
#################

PM25url_4km_sjv=filter(linkurl2,poltype=='PM_Ba',datatype=='sjv4km')
output=data.frame()

for (i in 1:dim(PM25url_4km_sjv)[1]){
DL_url=paste("http://webwolf.engr.ucdavis.edu/data/soa/monthly_avg/",PM25url_4km_sjv$X1[i],".csv",sep='')
temp=read.csv(DL_url)
temp2=mutate(temp,YearMonth=paste('15',str_sub(DL_url,-9,-5),sep=''),
		scale='sjv4km',
		date=as.Date(YearMonth,format="%d%y%b")) %>%
      select(-YearMonth)
output=rbind(temp2,output)
rm(temp)
rm(temp2)
}
PM1025_sjv4km=output
save(PM1025_sjv4km,file='Data\\PM1025_sjv4km.RData')
rm(output)



#################
### PM_0.1 sjv4km
#################

PM25url_4km_sjv=filter(linkurl2,poltype=='PM0.1',datatype=='sjv4km')
output=data.frame()

for (i in 1:dim(PM25url_4km_sjv)[1]){
DL_url=paste("http://webwolf.engr.ucdavis.edu/data/soa/monthly_avg/",PM25url_4km_sjv$X1[i],".csv",sep='')
temp=read.csv(DL_url)
temp2=mutate(temp,YearMonth=paste('15',str_sub(DL_url,-9,-5),sep=''),
		scale='sjv4km',
		date=as.Date(YearMonth,format="%d%y%b")) %>%
      select(-YearMonth)
output=rbind(temp2,output)
rm(temp)
rm(temp2)
}
PM01_sjv4km=output
save(PM01_sjv4km,file='Data\\PM01_sjv4km.RData')
rm(output)

rm(list=ls())
