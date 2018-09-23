SchoolLocation = read_delim("F:\\Research\\UCD_EJ\\Data\\PhysicalTest\\pubschls.txt", "\t", escape_double = FALSE, trim_ws = TRUE) %>%
	data.frame() %>%
	mutate(CharterNum = ifelse( !is.na(CharterNum), CharterNum, '0000')) %>%
	mutate(SchoolID = paste0(str_sub(paste0('0', CDSCode), -14, -1), str_sub(paste0('000', CharterNum), -4, -1))) %>%
	select(cds_code = CDSCode, SchoolID, Street, City, State, Zip, DOCType, SOCType,  Latitude, Longitude) 
