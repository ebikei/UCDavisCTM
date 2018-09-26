x=c('tidyverse', 'foreign', 'readr', 'ggmap')
lapply(x,require,character.only=T)
options(scipen=999)

SchoolLocation = read_delim("Research/UCDavisEnvJust/Data/PhysicalTest/SchoolLocation.txt", "\t", escape_double = FALSE, trim_ws = TRUE) %>%
	data.frame() %>%
	mutate(CharterNum = ifelse( !is.na(CharterNum), CharterNum, '0000')) %>%
	mutate(SchoolID = paste0(str_sub(paste0('0', CDSCode), -14, -1), str_sub(paste0('000', CharterNum), -4, -1))) %>%
	select(cds_code = CDSCode, SchoolID, Street, City, State, Zip, DOCType, SOCType,  Latitude, Longitude) 

outcomelist = c('011', '012', '013', '014', '015', '016', '021', '022', '023', '024', '025', '026', '027', '028', '431', '435', '437', '911', '912', '913', '914', '915', '916',
	'921', '922', '923', '924', '925', '926', '927', '928', '1011', '1012', '1013', '1014', '1015', '1016', '1021', '1022', '1023', '1024', '1025', '1026', '1027', '1028', 
	'1111', '1112', '1113', '1114', '1115', '1116', '1121', '1122', '1123', '1124', '1125', '1126', '1127', '1128')

df = data.frame()
for (iii in 2001:2002){
temp.school = read.csv(paste0('C:\\Users\\kebisu\\Documents\\Research\\UCDavisEnvJust\\Data\\PhysicalTest\\Entities', iii, '.txt'), stringsAsFactors=FALSE)  %>%
	mutate(cds_code = str_sub(paste0('0', cds_code), -14, -1)) %>%
	select(cds_code, County, District, School)

temp = read.csv(paste0('C:\\Users\\kebisu\\Documents\\Research\\UCDavisEnvJust\\Data\\PhysicalTest\\PhysFit', iii, '.txt'), stringsAsFactors=FALSE) %>%
	mutate(Type = paste0(SubGrp, RptType, line_num), cds_code = str_sub(paste0('0', cds_code), -14, -1)) %>%
	filter(Level == 1, Type %in% outcomelist) %>%
	inner_join(temp.school, by = 'cds_code') %>%
	mutate(year = iii, SchoolID = paste0(cds_code, '0000')) %>%
	select(cds_code, SchoolID, year, Type, Gr05_Stu, Gr5PctIn, Gr5PctNotIn, Gr07_Stu, Gr7PctIn, Gr7PctNotIn, Gr09_Stu, Gr9PctIn, Gr9PctNotIn)
df = rbind(df, temp)
rm(temp, temp.school)
}

for (iii in 2003:2005){
temp.school = read.csv(paste0('C:\\Users\\kebisu\\Documents\\Research\\UCDavisEnvJust\\Data\\PhysicalTest\\Entities', iii, '.txt'), stringsAsFactors=FALSE)  %>%
	mutate(cds_code = str_sub(paste0('0', cds_code), -14, -1)) %>%
	mutate(SchoolID = paste0(str_sub(paste0('0', cds_code), -14, -1), str_sub(paste0('000', CharterNum), -4, -1))) %>%
	select(cds_code, SchoolID, County, District, School)

temp = read.csv(paste0('C:\\Users\\kebisu\\Documents\\Research\\UCDavisEnvJust\\Data\\PhysicalTest\\PhysFit', iii, '.txt'), stringsAsFactors=FALSE) %>%
	mutate(Type = paste0(SubGrp, RptType, line_num), cds_code = str_sub(paste0('0', cds_code), -14, -1)) %>%
	mutate(SchoolID = paste0(str_sub(paste0('0', cds_code), -14, -1), str_sub(paste0('000', charternum), -4, -1))) %>%
	filter(Level == 1, Type %in% outcomelist) %>%
	select(-cds_code) %>%
	inner_join(temp.school, by = 'SchoolID') %>%
	mutate(year = iii) %>%
	select(cds_code, SchoolID, year, Type, Gr05_Stu, Gr5PctIn, Gr5PctNotIn, Gr07_Stu, Gr7PctIn, Gr7PctNotIn, Gr09_Stu, Gr9PctIn, Gr9PctNotIn)

df = rbind(df, temp)
rm(temp, temp.school)
}

outcomelist2 = c('011', '012', '013', '014', '015', '016', '021', '022', '023', '024', '025', '026', '027', '028', '4316', '4317', '4318', '2011', '2012', '2013', '2014', '2015', '2016',
	'2021', '2022', '2023', '2024', '2025', '2026', '2027', '2028', '2111', '2112', '2113', '2114', '2115', '2116', '2121', '2122', '2123', '2124', '2125', '2126', '2127', '2128', 
	'2211', '2212', '2213', '2214', '2215', '2216', '2221', '2222', '2223', '2224', '2225', '2226', '2227', '2228')

for (iii in 2006:2008){
temp.school = read.csv(paste0('C:\\Users\\kebisu\\Documents\\Research\\UCDavisEnvJust\\Data\\PhysicalTest\\Entities', iii, '.txt'), stringsAsFactors=FALSE)  %>%
	mutate(cds_code = str_sub(paste0('0', cds_code), -14, -1)) %>%
	mutate(SchoolID = paste0(str_sub(paste0('0', cds_code), -14, -1), str_sub(paste0('000', CharterNum), -4, -1))) %>%
	select(cds_code, SchoolID, County, District, School)

temp = read.csv(paste0('C:\\Users\\kebisu\\Documents\\Research\\UCDavisEnvJust\\Data\\PhysicalTest\\PhysFit', iii, '.txt'), stringsAsFactors=FALSE) %>%
	mutate(Type = paste0(SubGrp, RptType, line_num), cds_code = str_sub(paste0('0', cds_code), -14, -1)) %>%
	mutate(SchoolID = paste0(str_sub(paste0('0', cds_code), -14, -1), str_sub(paste0('000', charternum), -4, -1))) %>%
	filter(Level == 1, Type %in% outcomelist2) %>%
	select(-cds_code) %>%
	inner_join(temp.school, by = 'SchoolID') %>%
	mutate(year = iii) %>%
	select(cds_code, SchoolID, year, Type, Gr05_Stu, Gr5PctIn, Gr5PctNotIn, Gr07_Stu, Gr7PctIn, Gr7PctNotIn, Gr09_Stu, Gr9PctIn, Gr9PctNotIn)

df = rbind(df, temp)
rm(temp, temp.school)
}

### Merge School Info and Grid Info
load('C:\\Users\\kebisu\\Documents\\Research\\UCDavisEnvJust\\Data\\PhysicalTest\\SchoolLocation.RData') #SchoolList
GridInfo = read.dbf('K:\\Research\\UCDavisEnvJust\\Data\\PhysicalTest\\SchoolLocation.dbf') %>%
	filter(!is.na(GridID)) %>%
	mutate(CountyName = tolower(County)) %>%
	select(SchoolID, CountyName, GridID)
GridInfo$SchoolID = as.character(GridInfo$SchoolID)
TypeInfo = read.csv('K:\\Research\\UCDavisEnvJust\\Data\\PhysicalTest\\TypeDescription.csv') %>%
	mutate(Type = str_sub(paste0('00', Type), -4, -1))

df2 = SchoolList %>%
	select(-cds_code) %>%
	inner_join(df, by = 'SchoolID') %>%
	mutate(Type = str_sub(paste0('00', Type), -4, -1)) %>%
	inner_join(GridInfo, by = 'SchoolID') %>%
	select(-County) %>%
	inner_join(TypeInfo, by = 'Type') %>%
	select(SchoolID, CountyName, GridID, Race, Outcome, Type, everything())

df2$Gr05_Stu[df2$Gr05_Stu %in% c('*', '0', '999999') ] <-NA
df2$Gr05_Stu = as.numeric(df2$Gr05_Stu)
df2$Gr5PctIn[df2$Gr5PctIn %in% c('*') ] <-NA
df2$Gr5PctIn = as.numeric(df2$Gr5PctIn)
df2$Gr5PctIn[is.na(df2$Gr05_Stu)|df2$Gr05_Stu==0] <-NA
df2$Gr5PctNotIn[df2$Gr5PctNotIn %in% c('*', ' ') ] <-NA
df2$Gr5PctNotIn = as.numeric(df2$Gr5PctIn)
df2$Gr5PctNotIn[is.na(df2$Gr05_Stu)|df2$Gr05_Stu==0] <-NA

df2$Gr07_Stu[df2$Gr07_Stu %in% c('*', '0', '999999') ] <-NA
df2$Gr07_Stu = as.numeric(df2$Gr07_Stu)
df2$Gr7PctIn[df2$Gr7PctIn %in% c('*') ] <-NA
df2$Gr7PctIn = as.numeric(df2$Gr7PctIn)
df2$Gr7PctIn[is.na(df2$Gr07_Stu)|df2$Gr07_Stu==0] <-NA
df2$Gr7PctNotIn[df2$Gr7PctNotIn %in% c('*', ' ') ] <-NA
df2$Gr7PctNotIn = as.numeric(df2$Gr7PctIn)
df2$Gr7PctNotIn[is.na(df2$Gr07_Stu)|df2$Gr07_Stu==0] <-NA

df2$Gr09_Stu[df2$Gr09_Stu %in% c('*', '0', '999999', '999') ] <-NA
df2$Gr09_Stu = as.numeric(df2$Gr09_Stu)
df2$Gr9PctIn[df2$Gr9PctIn %in% c('*') ] <-NA
df2$Gr9PctIn = as.numeric(df2$Gr9PctIn)
df2$Gr9PctIn[is.na(df2$Gr09_Stu)|df2$Gr09_Stu==0] <-NA
df2$Gr9PctNotIn[df2$Gr9PctNotIn %in% c('*', ' ') ] <-NA
df2$Gr9PctNotIn = as.numeric(df2$Gr9PctIn)
df2$Gr9PctNotIn[is.na(df2$Gr09_Stu)|df2$Gr09_Stu==0] <-NA

#tt = mutate(df2, pcsum = Gr5PctNotIn + Gr5PctIn) %>% filter(pcsum ==100)
#summary(tt$pcsum)

df3 = df2 %>% 
	filter(Race =='All', Type == '0011', Gr05_Stu>40) %>%
	group_by(CountyName) %>%
	summarize(PE = median(Gr5PctIn), SE = sd(Gr5PctIn), Q1 = quantile(Gr5PctIn, probs = 0.25), Q3 = quantile(Gr5PctIn, probs = 0.75), )%>%
	data.frame() %>%
	arrange(PE)
df3 %>% filter(!is.na(SE)) %>%
 	ggplot(aes(reorder(x = CountyName, PE), y = PE)) +
	geom_errorbar(aes(ymin = Q1,ymax = Q3), size =1 , width=0.2, position = position_dodge(width = 0.50))+
	geom_point(aes(),cex = 3.25,position = position_dodge(width = 0.50))+
	ylim(0, 100)+
	ylab('% Qualified Objective Criteria')+
	xlab('County Name')+
	ggtitle("Aerobic Capacity: 5th Grade")+
	coord_flip()+
	theme_bw()+
	theme(plot.title = element_text(hjust = 0.5))

write.csv(df2, file = 'C:\\Users\\kebisu\\Documents\\Research\\UCDavisEnvJust\\Data\\PhysicalTest\\PhysicalTest.csv')

#https://www.cde.ca.gov/ta/tg/pf/pftresearch.asp
#https://www.cde.ca.gov/ds/si/ds/pubschls.asp
