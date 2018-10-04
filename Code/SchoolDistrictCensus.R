x<-c('tidyverse','reshape2','tidycensus', 'tmap', 'tmaptools', 'sf')
lapply(x, require, character.only=T)
census_api_key()

temp1 = get_acs("school district (elementary)", table = "B22003", year = 2010,  output = "tidy") %>%
	mutate(FoodStamp = case_when(substr(variable, 8, 10) == '001' ~ 'Total', 
			substr(variable, 8, 10) %in% c('002', '003', '004') ~ 'Yes',
			substr(variable, 8, 10) %in%  c('005', '006', '007') ~ 'No'),
		PovertyLevel = case_when(substr(variable, 8, 10) == '001' ~ 'Total', 
			substr(variable, 8, 10) %in% c('003', '006') ~ 'Yes',
			substr(variable, 8, 10) %in%  c('004', '007') ~ 'No')
	) %>%
	filter(substr(GEOID, 1, 2) == '06') 
	
temp2 = temp1 %>% 
	filter(FoodStamp %in% c('Yes', 'No'), is.na(PovertyLevel)) %>%	
	select(-moe, -PovertyLevel, -variable) %>%	
	spread(FoodStamp, estimate) %>%
	mutate(Total = Yes + No, FS_Rate = Yes*100/Total) %>%
	arrange(-FS_Rate) %>%
	select(-c(No, Yes, Total))

temp3 = temp1 %>% 	
	filter(PovertyLevel %in% c('Yes', 'No')) %>%
	group_by(GEOID, PovertyLevel ) %>%
	summarize(estimate = sum(estimate)) %>%
	ungroup() %>%
	spread(PovertyLevel, estimate) %>%
	mutate(Total = Yes + No, Poverty_Rate = Yes*100/Total) %>%
	arrange(-Poverty_Rate) %>%
	select(-c(No, Yes, Total))

df = inner_join(temp2, temp3, by = 'GEOID')

ggplot(df, aes(FS_Rate, Poverty_Rate)) +
	geom_point()
