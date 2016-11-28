x<-c("dplyr","ggplot2","data.table")
lapply(x, require, character.only=T)

drive=c("C:\\Users\\ebike\\Downloads")
setwd(drive)



	url=paste("http://aqsdr1.epa.gov/aqsweb/aqstmp/airdata/daily_88101_",test2[i],".zip",sep='')
	download.file(url,'temp2.zip')
	temp=read.csv(unz('temp2.zip',paste("daily_88101_",test2[i],".csv",sep='')),header=TRUE)



temp=read.csv('http://webwolf.engr.ucdavis.edu/data/primary/monthly_avg/scb_eic_00apr_PM0.1.csv',header=TRUE)
temp=read.csv('http://webwolf.engr.ucdavis.edu/data/primary/monthly_avg/scb_eic_00apr_PM2.5.csv',header=TRUE)
temp=read.csv('http://webwolf.engr.ucdavis.edu/data/primary/monthly_avg/scb_eic_00apr_PM0.1.csv',header=TRUE)
temp=read.csv('http://webwolf.engr.ucdavis.edu/data/primary/monthly_avg/sjv_eic_05may_PMC.csv',header=TRUE)
