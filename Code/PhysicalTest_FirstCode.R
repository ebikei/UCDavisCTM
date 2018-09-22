x=c('tidyverse', 'foreign', 'readr')
lapply(x,require,character.only=T)
options(scipen=999)

SchoolLocation = read_delim("Research/UCDavisEnvJust/Data/PhysicalTest/SchoolLocation.txt", "\t", escape_double = FALSE, trim_ws = TRUE) %>%
	data.frame() %>%
	mutate(CharterNum = ifelse( !is.na(CharterNum), CharterNum, '0000')) %>%
	mutate(SchoolID = paste0(str_sub(paste0('0', CDSCode), -14, -1), str_sub(paste0('000', CharterNum), -4, -1))) %>%
	select(cds_code = CDSCode, SchoolID, Street, City, State, Zip, DOCType, SOCType,  Latitude, Longitude) 


df = data.frame()
for (iii in 2001:2002){
temp.school = read.csv(paste0('C:\\Users\\kebisu\\Documents\\Research\\UCDavisEnvJust\\Data\\PhysicalTest\\Entities', iii, '.txt'), stringsAsFactors=FALSE)  %>%
	mutate(cds_code = str_sub(paste0('0', cds_code), -14, -1)) %>%
	select(cds_code, County, District, School)

temp = read.csv(paste0('C:\\Users\\kebisu\\Documents\\Research\\UCDavisEnvJust\\Data\\PhysicalTest\\PhysFit', iii, '.txt'), stringsAsFactors=FALSE) %>%
	mutate(Type = paste0(SubGrp, RptType, line_num), cds_code = str_sub(paste0('0', cds_code), -14, -1)) %>%
	filter(Level == 1, Type %in% c('011', '012', '013', '014', '015', '016')) %>%
	inner_join(temp.school, by = 'cds_code') %>%
	inner_join(SchoolLocation, by = 'cds_code') %>%
	mutate(year = iii, SchoolID = paste0(cds_code, '0000')) %>%
	select(cds_code, SchoolID, year, Type, Gr05_Stu, Gr5PctIn, Gr5PctNotIn, Gr07_Stu, Gr7PctIn, Gr7PctNotIn, Gr09_Stu, Gr9PctIn, Gr9PctNotIn, County, District, School, Street, City, State, Zip, DOCType, SOCType, Latitude, Longitude)

df = rbind(df, temp)
rm(temp, temp.school)
}

for (iii in 2003:2008){
temp.school = read.csv(paste0('C:\\Users\\kebisu\\Documents\\Research\\UCDavisEnvJust\\Data\\PhysicalTest\\Entities', iii, '.txt'), stringsAsFactors=FALSE)  %>%
	mutate(cds_code = str_sub(paste0('0', cds_code), -14, -1)) %>%
	mutate(SchoolID = paste0(str_sub(paste0('0', cds_code), -14, -1), str_sub(paste0('000', CharterNum), -4, -1))) %>%
	select(cds_code, SchoolID, County, District, School)

temp = read.csv(paste0('C:\\Users\\kebisu\\Documents\\Research\\UCDavisEnvJust\\Data\\PhysicalTest\\PhysFit', iii, '.txt'), stringsAsFactors=FALSE) %>%
	mutate(Type = paste0(SubGrp, RptType, line_num), cds_code = str_sub(paste0('0', cds_code), -14, -1)) %>%
	mutate(SchoolID = paste0(str_sub(paste0('0', cds_code), -14, -1), str_sub(paste0('000', charternum), -4, -1))) %>%
	filter(Level == 1, Type %in% c('011', '012', '013', '014', '015', '016')) %>%
	select(-cds_code) %>%
	inner_join(temp.school, by = 'SchoolID') %>%
	select(-cds_code) %>%
	inner_join(SchoolLocation, by = 'SchoolID') %>%
	mutate(year = iii) %>%
	select(cds_code, SchoolID, year, Type, Gr05_Stu, Gr5PctIn, Gr5PctNotIn, Gr07_Stu, Gr7PctIn, Gr7PctNotIn, Gr09_Stu, Gr9PctIn, Gr9PctNotIn, County, District, School, Street, City, State, Zip, DOCType, SOCType, Latitude, Longitude)

df = rbind(df, temp)
rm(temp, temp.school)
}


####### Geocode for schools without lat/long
test = distinct(df, SchoolID, .keep_all = TRUE) %>%
	filter(is.na(Latitude)) %>%
	arrange(SchoolID) 

test2 = mutate(test, place = paste(Street, City, State, sep = ', ')) %>%
	select(place)
try1 = mutate_geocode(test2, place)

set1 = cbind(test, try1) %>%
	mutate(Latitude = lat, Longitude = lon)

new1 = filter(set1, !is.na(Latitude)) %>%
	select(- c(place, lon, lat)) 

test3 = filter(set1, is.na(Latitude)) 
try2 = test3 %>%
	select(place) %>%
	mutate_geocode(place)

new2 = test3 %>%
	select( -c(place, lon, lat)) %>%
	cbind(try2) %>%
	mutate(Latitude = lat, Longitude = lon) %>%
	filter(!is.na(Latitude)) %>%
	select(- c(place, lon, lat)) 

test4 = test3 %>%
	select( -c(place, lon, lat)) %>%
	cbind(try2) %>%
	mutate(Latitude = lat, Longitude = lon) %>%
	filter(is.na(Latitude)) 
try3 = test4 %>%
	select(place) %>%
	mutate_geocode(place)

new3 = test4 %>%
	select( -c(place, lon, lat)) %>%
	cbind(try3) %>%
	mutate(Latitude = lat, Longitude = lon) %>%
	filter(!is.na(Latitude)) %>%
	select(- c(place, lon, lat)) 	

test5 = test4 %>%
	select( -c(place, lon, lat)) %>%
	cbind(try3) %>%
	mutate(Latitude = lat, Longitude = lon) %>%
	filter(is.na(Latitude)) 
try4 = test5 %>%
	select(place) %>%
	mutate_geocode(place)

new4 = test5 %>%
	select( -c(place, lon, lat)) %>%
	cbind(try4) %>%
	mutate(Latitude = lat, Longitude = lon) %>%
	filter(!is.na(Latitude)) %>%
	select(- c(place, lon, lat)) 	

test6 = test5 %>%
	select( -c(place, lon, lat)) %>%
	cbind(try4) %>%
	mutate(Latitude = lat, Longitude = lon) %>%
	filter(is.na(Latitude)) 
try5 = test6 %>%
	select(place) %>%
	mutate_geocode(place)

new5 = test6 %>%
	select( -c(place, lon, lat)) %>%
	cbind(try5) %>%
	mutate(Latitude = lat, Longitude = lon) %>%
	filter(!is.na(Latitude)) %>%
	select(- c(place, lon, lat)) 	

#https://www.cde.ca.gov/ta/tg/pf/pftresearch.asp
#https://www.cde.ca.gov/ds/si/ds/pubschls.asp
