x=c('tidyverse', 'haven')
lapply(x,require,character.only=T)


load('C:\\Users\\ebike\\OneDrive\\Documents\\Research\\UCD_EJ\\Data\\NewDavisData.RData') #df

df2 = df %>%
	arrange(GridID, YearMonth) %>%
	select(- c(YearMonth, Place, GridX, GridY, PN, PSURF_AREA, filename)) %>%
	group_by(GridID) %>%
	summarise_all(.funs = c(mean="mean")) %>%
	data.frame()

load('C:\\Users\\ebike\\OneDrive\\Documents\\Research\\UCD_EJ\\Data\\OldDavisData.RData') #old.df

old.df2 = old.df %>% 
	data.frame() %>%
	select(GridID, PM10MASS, PM2_5MASS, PM0_1MASS, PM10Tracer6, PM2_5Tracer6, PM0_1Tracer6,
			PM10EC, PM2_5EC, PM0_1EC) %>%
	data.frame()

old.df2$GridID = as.character(old.df2$GridID )

df3 = df2 %>%
	select(GridID, PM10MASS_mean, PM2.5MASS_mean, PM0.1MASS_mean, 
		PM10Tracer6_mean, PM2.5Tracer6_mean, PM0.1Tracer6_mean,
		PM10EC_mean, PM2.5EC_mean, PM0.1EC_mean) %>%
	inner_join(old.df2, by = 'GridID')


cor(df3$PM10MASS, df3$PM10MASS_mean)
cor(df3$PM2_5MASS, df3$PM2.5MASS_mean)
cor(df3$PM0_1MASS, df3$PM0.1MASS_mean)
cor(df3$PM10Tracer6, df3$PM10Tracer6_mean)
cor(df3$PM2_5Tracer6, df3$PM2.5Tracer6_mean)
cor(df3$PM0_1Tracer6, df3$PM0.1Tracer6_mean)
cor(df3$PM10EC, df3$PM10EC_mean)
cor(df3$PM2_5EC, df3$PM2.5EC_mean)
cor(df3$PM0_1EC, df3$PM0.1EC_mean)



ggplot(df3, aes(PM10MASS_mean, PM10MASS)) +
	geom_point()+
	geom_abline(intercept = 0, slope = 1)+
	xlab("New Data") + 
	ylab("Old Data")

ggplot(df3, aes(PM2.5MASS_mean, PM2_5MASS)) +
	geom_point()+
	geom_abline(intercept = 0, slope = 1)+
	xlab("New Data") + 
	ylab("Old Data")	

ggplot(df3, aes(PM0.1MASS_mean, PM0_1MASS)) +
	geom_point()+
	geom_abline(intercept = 0, slope = 1)+
	xlab("New Data") + 
	ylab("Old Data")



# Source
ggplot(df3, aes(PM10EC_mean, PM10EC)) +
	geom_point()+
	geom_abline(intercept = 0, slope = 1)+
	xlab("New Data") + 
	ylab("Old Data")

ggplot(df3, aes(PM2.5EC_mean, PM2_5EC)) +
	geom_point()+
	geom_abline(intercept = 0, slope = 1)+
	xlab("New Data") + 
	ylab("Old Data")	

ggplot(df3, aes(PM0.1EC_mean, PM0_1EC)) +
	geom_point()+
	geom_abline(intercept = 0, slope = 1)+
	xlab("New Data") + 
	ylab("Old Data")					
