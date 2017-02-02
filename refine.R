require(tidyr)
# read file
data <- read.csv("refine_original.csv",na.strings="Not Available",stringsAsFactors = FALSE)
#convert to lower case
data$company<-tolower(data$company)
#split product code and number into separate columns removing original
data<-data %>% separate(col="Product.code...number",into=c('product_code','product_number'),sep = "-",remove=TRUE)
#clean up misspelled company names by looking for starting character and replacing with correct spelling
data$company<-ifelse(startsWith(data$company,"p"),"philips",ifelse(startsWith(data$company,"u"),"unilever",ifelse(startsWith(data$company,"v"),"van houten","akzo")))
#create new product_category column and populate based on product_code
data$product_category<-ifelse(data$product_code=="p","Smartphone",ifelse(data$product_code=="v","TV",ifelse(data$product_code=="x","Laptop","Tablet")))
#create full_address column by concatenating separate address columns
data$full_address<-paste(data$address,data$city,data$country,sep = ",")
#tidy data by creating binary values for each company
data$company_philips<-ifelse(data$company=="philips",1,0)
data$company_akzo<-ifelse(data$company=="akzo",1,0)
data$company_unilever<-ifelse(data$company=="unilever",1,0)
data$company_van_houten<-ifelse(data$company=="van houten",1,0)
#tidy data by creating binary values for each product 
data$product_smartphone<-ifelse(data$product_code=="p",1,0)
data$product_tv<-ifelse(data$product_code=="v",1,0)
data$product_laptop<-ifelse(data$product_code=="x",1,0)
data$product_tablet<-ifelse(data$product_code=="q",1,0)
write.csv(data,file="refine_clean.csv",row.names = FALSE)

