#Project 1
#Due: 2/11/2016
###################################################################


###################################################################
#Load in File
#Note: Please save file as csv before loading into R
#Change to your directory, but remember to import as a data frame object
raw_response <- as.data.frame(read.table("D:/Documents/Survey+Response.csv", header=TRUE, fill = TRUE, sep=","))

#create variable to get total number of survey respondents 
total_students <- nrow(raw_response)

#create a new dataframe which extracts necessary data from raw responses
agg_response <- raw_response[,c(1,2,12,13)]


###################################################################
#create new Program variables which creates 6 distinct groups of programs since responses had overlapping
#programs
#Creates the following groups: 1. IDSE Masters, Ms in ds, Data Science, and MSDS as IDSE Masters
#                                2. Data Science Certification
#                                3. QMSS, QMSS (masters)
#                                4. All PhDs were grouped together
#                                5. Statistics (masters)
#                                6. Applied Math,Other masters


agg_response$Program <- NA

for (i in 1:total_students){
  if(raw_response$Program[i] == "IDSE (master)" || raw_response$Program[i] == "Ms in ds" || raw_response$Program[i] == "Data Science" || raw_response$Program[i] == "MSDS")
  {
    agg_response$Program[i] <-  "IDSE (master)"
  } 
  
  else if (raw_response$Program[i] == "QMSS" || raw_response$Program[i] == "QMSS (master)")
  {
    agg_response$Program[i] <- "QMSS (master)"
  } 
  
  else if(raw_response$Program[i] == "Applied Math")
  {
    agg_response$Program[i] <- "Other masters"
  }
  
  else if(raw_response$Program[i] == "PhD Biomedical Informatics" || raw_response$Program[i] == "Ph.D.")
  {
    agg_response$Program[i] <- "Ph.D."
  }
  
  else
  {
    agg_response$Program[i] <- as.character(raw_response$Program[i])
  }
}

#Sample code to get bargraph distribution of programs
#counts <- table(agg_response$Program)
#barplot(counts)



###################################################################
#Parse the Experience with tools column of raw respones to individually tally program experience by each option on the survey
#Each column corresponds to the programming software and responses are binary, 1 = experience, 0 = no experience


agg_response$Matlab <- NA
agg_response$R <- NA
agg_response$Github <- NA
agg_response$Excel <- NA
agg_response$SQL <- NA
agg_response$SPSS <- NA
agg_response$ggplot2 <- NA
agg_response$shell <- NA
agg_response$C <- NA
agg_response$Python <- NA
agg_response$Stata <- NA
agg_response$Latex <- NA
agg_response$lattice <- NA
agg_response$grep <- NA
agg_response$Sweave <- NA
agg_response$XML <- NA
agg_response$Web <- NA
agg_response$Dropbox <- NA
agg_response$GoogleDrive <- NA


for(i in 1:total_students){
  
  expr <- as.character(raw_response$Experiences.with.tools[i])
  
  if(grepl("Matlab",expr)){
    agg_response$Matlab[i] <- 1
  }else{
    agg_response$Matlab[i] <- 0
  }
  
  if(grepl("R",expr) || grepl("RStudio",expr)){
    agg_response$R[i] <- 1
  }else{
    agg_response$R[i] <- 0
  }
  
  if(grepl("Github",expr)){
    agg_response$Github[i] <- 1
  }else{
    agg_response$Github[i] <- 0
  }
  
  if(grepl("Excel",expr)){
    agg_response$Excel[i] <- 1
  }else{
    agg_response$Excel[i] <- 0
  }
  
  if(grepl("SQL",expr)){
    agg_response$SQL[i] <- 1
  }else{
    agg_response$SQL[i] <- 0
  }
  
  if(grepl("SPSS",expr)){
    agg_response$SPSS[i] <- 1
  }else{
    agg_response$SPSS[i] <- 0
  }
  
  if(grepl("ggplot2",expr)){
    agg_response$ggplot2[i] <- 1
  }else{
    agg_response$ggplot2[i] <- 0
  }
  
  if(grepl("shell",expr)){
    agg_response$shell[i] <- 1
  }else{
    agg_response$shell[i] <- 0
  }
  
  if(grepl("C/C+",expr)){
    agg_response$C[i] <- 1
  }else{
    agg_response$C[i] <- 0
  }
  
  if(grepl("Python",expr)){
    agg_response$Python[i] <- 1
  }else{
    agg_response$Python[i] <- 0
  }
  
  if(grepl("Stata",expr)){
    agg_response$Stata[i] <- 1
  }else{
    agg_response$Stata[i] <- 0
  }
  
  if(grepl("LaTeX",expr)){
    agg_response$Latex[i] <- 1
  }else{
    agg_response$Latex[i] <- 0
  }
  
  if(grepl("lattice",expr)){
    agg_response$lattice[i] <- 1
  }else{
    agg_response$lattice[i] <- 0
  }
  
  if(grepl("grep",expr)){
    agg_response$grep[i] <- 1
  }else{
    agg_response$grep[i] <- 0
  }
  
  if(grepl("Sweave",expr)){
    agg_response$Sweave[i] <- 1
  }else{
    agg_response$Sweave[i] <- 0
  }
  
  if(grepl("XML",expr)){
    agg_response$XML[i] <- 1
  }else{
    agg_response$XML[i] <- 0
  }
  
  if(grepl("Web",expr)){
    agg_response$Web[i] <- 1
  }else{
    agg_response$Web[i] <- 0
  }
  
  if(grepl("dropbox",expr)){
    agg_response$Dropbox[i] <- 1
  }else{
    agg_response$Dropbox[i] <- 0
  }
  
  if(grepl("google",expr)){
    agg_response$GoogleDrive[i] <- 1
  }else{
    agg_response$GoogleDrive[i] <- 0
  }
  
}

###################################################################
#Converted level of experience for programming software into numerical form to help with future assessment of data
#None = 0, A little = 1, Confident = 2, Expert = 3

agg_response$R_DataManipulationModelingExperience <- NA

for (i in 1:total_students){
  if(raw_response[i,4] == "None")
  {
    agg_response$R_DataManipulationModelingExperience[i] <-  0
  } 
  
  else if (raw_response[i,4] == "A little")
  {
    agg_response$R_DataManipulationModelingExperience[i] <-  1
  } 
  
  else if(raw_response[i,4] == "Confident")
  {
    agg_response$R_DataManipulationModelingExperience[i] <-  2
  }
  
  else
  {
    agg_response$R_DataManipulationModelingExperience[i] <-  3
  }
}



agg_response$R_GraphicsExperience <- NA

for (i in 1:total_students){
  if(raw_response[i,14] == "None")
  {
    agg_response$R_GraphicsExperience[i] <-  0
  } 
  
  else if (raw_response[i,14] == "A little")
  {
    agg_response$R_GraphicsExperience[i] <-  1
  } 
  
  else if(raw_response[i,14] == "Confident")
  {
    agg_response$R_GraphicsExperience[i] <-  2
  }
  
  else
  {
    agg_response$R_GraphicsExperience[i] <-  3
  }
}



agg_response$R_AdvDataAnalysisExperience <- NA

for (i in 1:total_students){
  if(raw_response[i,15] == "None")
  {
    agg_response$R_AdvDataAnalysisExperience[i] <-  0
  } 
  
  else if (raw_response[i,15] == "A little")
  {
    agg_response$R_AdvDataAnalysisExperience[i] <-  1
  } 
  
  else if(raw_response[i,15] == "Confident")
  {
    agg_response$R_AdvDataAnalysisExperience[i] <-  2
  }
  
  else
  {
    agg_response$R_AdvDataAnalysisExperience[i] <-  3
  }
}


agg_response$R_ReproducibleDocExperience <- NA

for (i in 1:total_students){
  if(raw_response[i,16] == "None")
  {
    agg_response$R_ReproducibleDocExperience[i] <-  0
  } 
  
  else if (raw_response[i,16] == "A little")
  {
    agg_response$R_ReproducibleDocExperience[i] <-  1
  } 
  
  else if(raw_response[i,16] == "Confident")
  {
    agg_response$R_ReproducibleDocExperience[i] <-  2
  }
  
  else
  {
    agg_response$R_ReproducibleDocExperience[i] <-  3
  }
}


agg_response$MatlabExperience <- NA

for (i in 1:total_students){
  if(raw_response[i,17] == "None")
  {
    agg_response$MatlabExperience[i] <-  0
  } 
  
  else if (raw_response[i,17] == "A little")
  {
    agg_response$MatlabExperience[i] <-  1
  } 
  
  else if(raw_response[i,17] == "Confident")
  {
    agg_response$MatlabExperience[i] <-  2
  }
  
  else
  {
    agg_response$MatlabExperience[i] <-  3
  }
}

agg_response$GithubExperience <- NA

for (i in 1:total_students){
  if(raw_response[i,18] == "None")
  {
    agg_response$GithubExperience[i] <-  0
  } 
  
  else if (raw_response[i,18] == "A little")
  {
    agg_response$GithubExperience[i] <-  1
  } 
  
  else if(raw_response[i,18] == "Confident")
  {
    agg_response$GithubExperience[i] <-  2
  }
  
  else
  {
    agg_response$GithubExperience[i] <-  3
  }
}

#Check for numbers with Excel file
colSums(agg_response[,c(5:23)])


#Renamed columns to help with future data manipulation
colnames(agg_response)[1] <- "WaitingList"
colnames(agg_response)[3] <- "Gender"
colnames(agg_response)[4] <- "TextEditor"


#Created new variable to assess exposure to different software programs by summing binary responses to experience questions
agg_response$SumExperience <- agg_response$Matlab + agg_response$R + agg_response$Github + agg_response$Excel +
  agg_response$SQL + agg_response$SPSS + agg_response$ggplot2 + agg_response$shell + agg_response$C + 
  agg_response$Python + agg_response$Stata + agg_response$Latex + agg_response$lattice + agg_response$grep +
  agg_response$Sweave + agg_response$XML + agg_response$Web + agg_response$Dropbox + agg_response$GoogleDrive

#Created new variable specific to assessing programming experience in R by summing binary responses to experience questions
agg_response$RProgramExperience <- agg_response$R_DataManipulationModelingExperience + agg_response$R_GraphicsExperience + 
  agg_response$R_AdvDataAnalysisExperience + agg_response$R_ReproducibleDocExperience


# calculate the mean of R exp
R_mean <- mean(agg_response$RProgramExperience)

# R exp distribution analysis
rdist_all <- ggplot(agg_response, aes(x=RProgramExperience)) + geom_line(stat="density", size=1, colour="blue")
rdist_all + ggtitle("Density of R_Experience") + theme(plot.title = element_text(lineheight=1, face="bold", size=20))
rdist_prog <- ggplot(agg_response, aes(x=RProgramExperience, col=Program)) + geom_line(stat="density", size=1)
rdist_prog + facet_wrap( ~ Program) + ggtitle("Trellis of Density of R_Experience by Program") + theme(plot.title = element_text(lineheight=1, face="bold", size=20))
rdist_gndr <- ggplot(agg_response, aes(x=RProgramExperience, col=Gender)) + geom_line(stat="density", size=1)
rdist_gndr + facet_wrap( ~ Gender) + ggtitle("Trellis of Density of R_Experience by Gender") + theme(plot.title = element_text(lineheight=1, face="bold", size=20))
rdist_prog_overlay <- ggplot(agg_response, aes(x=RProgramExperience, col=Program)) + geom_line(stat="density", size=1)
rdist_prog_overlay + geom_vline(xintercept=R_mean, size=1, linetype="dashed") + annotate("text", x=6, y=0.28, label="Class Mean", family="serif",
fontface="bold", colour="black", size=7) + ggtitle("Density of R_Experience by Program") + theme(plot.title = element_text(lineheight=1, face="bold", size=20))
