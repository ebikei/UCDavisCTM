x=c('tidyverse', 'foreign')
lapply(x,require,character.only=T)
options(scipen=999)

SchoolLocation = read.dbf('C:\\Users\\kebisu\\Documents\\Research\\UCDavisEnvJust\\Data\\GIS\\pubschls.dbf', as.is = TRUE) %>%
	filter(DOCType != 'State Special Schools') %>%
	select(CDSCode, School, Street, City, State, Zip, DOCType, SOCType, Latitude, Longitude) %>%
	filter(!is.na(Latitude))

SchoolName = read.csv('C:\\Users\\kebisu\\Documents\\Research\\UCDavisEnvJust\\Data\\PhysicalTest\\Entities2006.txt', stringsAsFactors=FALSE) %>%
	mutate(SchoolID = paste0(str_sub(paste0('0', cds_code), -14, -1), str_sub(paste0('00', CharterNum), -3, -1))) %>%
	distinct(SchoolID, .keep_all = TRUE) %>%
	select(-cds_code, -CharterNum, -Scode, -Dcode, -Ccode)

exam.2006 = read.csv('C:\\Users\\kebisu\\Documents\\Research\\UCDavisEnvJust\\Data\\PhysicalTest\\PhysFit2006.txt', stringsAsFactors=FALSE) %>%
	mutate(Type = paste0(SubGrp, RptType, line_num), SchoolID = paste0(str_sub(paste0('0', cds_code), -14, -1), str_sub(paste0('00', charternum), -3, -1)))  %>%
	mutate_each_(funs(as.numeric), c("Gr05_Stu","Gr5PctIn","Gr5PctNotIn","Gr07_Stu","Gr7PctIn","Gr7PctNotIn","Gr09_Stu","Gr9PctIn","Gr9PctNotIn")) 

df.2006 = exam.2006 %>%
	filter(Level == 1, Type %in% c('011', '012', '013', '014', '015', '016')) %>%
	select(Type, SchoolID, Gr05_Stu, Gr5PctIn, Gr5PctNotIn, Gr07_Stu, Gr7PctIn, Gr7PctNotIn, Gr09_Stu, Gr9PctIn, Gr9PctNotIn) %>%
	inner_join(SchoolName, by = 'SchoolID') %>%
	mutate(CDSCode = substr(SchoolID, 1, 14)) %>%
	inner_join(SchoolLocation, by = 'CDSCode') %>%
	filter(!is.na(Latitude))

test= df.2006 %>% filter(Gr07_Stu > 10)


df = data.frame()
for (iii in 2001:2008){
temp = read.csv(paste0('C:\\Users\\kebisu\\Documents\\Research\\UCDavisEnvJust\\Data\\PhysicalTest\\PhysFit', iii, '.txt'), stringsAsFactors=FALSE) %>%
	mutate(Type = paste0(SubGrp, RptType, line_num), SchoolID = paste0(str_sub(paste0('0', cds_code), -14, -1), str_sub(paste0('00', charternum), -3, -1)))  %>%
	mutate_each_(funs(as.numeric), c("Gr05_Stu","Gr5PctIn","Gr5PctNotIn","Gr07_Stu","Gr7PctIn","Gr7PctNotIn","Gr09_Stu","Gr9PctIn","Gr9PctNotIn")) 
df = rbind(df, temp)
rm(temp)
}


test2 = filter(temp, Level ==1, SubGrp == 0, RptType ==1, line_num ==1)

test2[duplicated(test2$cds_code),]

#https://www.cde.ca.gov/ta/tg/pf/pftresearch.asp