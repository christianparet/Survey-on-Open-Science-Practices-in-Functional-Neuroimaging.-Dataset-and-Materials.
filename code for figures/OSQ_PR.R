#################################################################
# Open Science Projekt
#################################################################



#################################################################
# Working directory
#################################################################

# Getting and setting working directory

getwd()

setwd(getwd())


#################################################################
# Loading packages (installs if necessary)
#################################################################


if (!require("pacman")) install.packages("pacman")
pacman::p_load(ggplot2, 
               RColorBrewer, 
               colorspace, 
               scales, 
               likert, 
               ggthemes, 
               dplyr, 
               data.table, 
               tidyr, 
               psych)

#---------------------------------------------------------------
  ######## Preregistration ########

#############################################################
#PR01 "What preregistration formats, if any, have you used?" #
#############################################################

# Create subset for current question
PR01 <- subset(OSQ_daten, select = c(79:83,85))

# Create new data frame where TRUE/FALSE are changed to 0/1
Cols2 <-  which(sapply(PR01, is.logical))
setDT(PR01)

for(j in Cols2){
  set(PR01, i=NULL, j=j, value= as.numeric(PR01[[j]]))
}

# Change format of data set, so that each row pertains to one answer option (rows are now columns, columns are rows)
PR01<- as.data.frame(t(PR01))

# Add new column that counts how many people responded with TRUE for each row
PR01$NumberofPeople <- rowSums (subset(PR01, select = c(1:283)))

# Add new column in which each row is assigned its answer option 
Preregform <- c("Registered report in a scientific journal",
                "Preregistration with Open Science Framework (OSF)",
                "Preregistration with ClinicalTrials.gov",
                "Preregistration with AsPredicted",
                "Other preregistration platform",
                "I have never preregistered a study")

PR01$Preregform <- Preregform

# Add factor levels to previous new variable, so that we can order the levels manually. 
PR01$Preregform <- factor(PR01$Preregform,                                       
                          levels = c(
                            "Preregistration with Open Science Framework (OSF)",
                            "Preregistration with ClinicalTrials.gov",
                            "Registered report in a scientific journal",
                            "Preregistration with AsPredicted",
                            "Other preregistration platform",
                            "I have never preregistered a study"))

# Order factors in decreasing order     
PR01$Preregform <- factor(PR01$Preregform, levels = PR01$Preregform [order(PR01$Preregform, decreasing = TRUE)])

# Calculate proportion and add percent labels as new variable in dataframe
PR01_prop <- (PR01$NumberofPeople)/283
PR01_perc <- as.data.frame(round(PR01_prop * 100, digits = 1)) # save as data frame
PR01$perc_labels <- paste(PR01_perc$`round(PR01_prop * 100, digits = 1)`, "%", sep = " ", collapse = NULL)


# Plot as bar graph 
PR01plot<-ggplot(PR01, aes(x= Preregform , y=NumberofPeople, fill=Preregform)) +  # specify ggplot object
  geom_bar(stat = "identity", width = 0.8)+                                       # 
  coord_flip(ylim = c(0,148)) +                                                   # flip x and y axis to create horizontal bars
  ggtitle("What preregistration formats, if any, have you used?")+                # specify title 
  theme(plot.title = element_text(size=10, hjust = 0.5),                          # specify title font size and position
        axis.text=element_text(size=8),                                           # specify axis text font size                                     
        axis.title=element_text(size=8),                                          # specify axis title font size
        aspect.ratio = 1)+                                                        # 
  geom_text(aes(y = 140, label = perc_labels), color = "black", size = 3)+        # add percent labels 
  ylab("Number of Responses")+                                                    # specify y-axis title 
  xlab("")+                                                                       # specify x-axis title 
  scale_fill_brewer(palette = "BrBG") +                                           # specify palette for bar color 
  theme(legend.position="none")+                                                  #
  theme(         
    panel.border = element_blank(),                                               # Remove panel border
    panel.grid.major = element_blank(),                                           # Remove panel grid lines
    panel.grid.minor = element_blank(),                                             
    panel.background = element_blank(),                                           # Remove panel background 
    axis.line = element_line(colour = "grey"))+                                   # Add axis line
  scale_y_continuous(breaks=waiver())+                                            # specify breaks for y axis
  scale_x_discrete(labels = wrap_format(18))                                      # specify wrap for text on x axis                          

# Print plot
PR01plot

# Save plot 
ggsave(file="PR01.svg", plot=PR01plot)

####################################################################################
#PR03 "How likely are you to preregister your next study in an online repository?" #
####################################################################################

# Create subset for current question
PR03<- subset(OSQ_daten, select = c(86))

PR03<- PR03%>%
  rename("How likely are you to preregister your next study in an online repository?" = PR03)

# Add vector with answer options
likelihoodchoices  = c("Extremely Unlikely", 
                       "Unlikely", 
                       "Neither likely nor Unlikely", 
                       "Likely",
                       "Extremely Likely")
# Replace levels 1:5 with answer options
for(i in 1:ncol(PR03)) {
  PR03[,i] = factor(PR03[,i], levels=1:5, labels=likelihoodchoices, ordered=TRUE)
}

# Plot likert plot
plotPR03 <- plot(likert(PR03), wrap=25,legend = "", legend.position = "bottom" )


# Print plot
plotPR03

# Save plot
ggsave(file="PR03.svg", plot=plotPR03)


##PR07 "These statements relate to possible barriers for and fears of preregistration."

# Create subset for current question
PR07 <- subset(OSQ_daten, select = c(87:96))

# Add vector with answer options
agreementchoices  = c("\"Strongly Disagree\"", 
                      "\"Disagree\"", 
                      "\"Somewhat disagree\"", 
                      "\"Neither agree nor disagree\"",
                      "\"Somewhat agree\"",
                      "\"Agree\"",
                      "\"Strongly agree\"")

# Replace levels 1:7 with answer options
for(i in 1:ncol(PR07)) {
  PR07[,i] = factor(PR07[,i], levels=1:7, labels=agreementchoices, ordered=TRUE)
}

# Rename Variables into Answer Options
PR07 <- rename(PR07, c(
  "It is necessary to register studies with an explorative research question" =  PR07_01, 
  "The analyses I do are too complex to preregister"= PR07_02,
  "Preparing a preregistration is too time consuming for me"= PR07_03, 
  "I have never learned to preregister a project" = PR07_04,
  "There is no sufficient reward for preregistration" = PR07_05,
  "I have never thought about pregestering a project"= PR07_06,
  "I know too little about suitable preregistration platforms" = PR07_07,
  "I am afraid that my preregistered hypotheses may turn out false" = PR07_08,
  "I am afraid that my preregistered methods may turn out suboptimal or inadequate" = PR07_09, 
  "My boss does not support preregistration" = PR07_10))

# Plot likert plot
plotPR07 <- plot(likert(PR07), wrap=25,legend = "", legend.position = "bottom" ) +
  ggtitle("Possible barriers for and fears of preregistration") +
  theme(plot.title = element_text(hjust = 0.5))+
  theme(plot.title = element_text(size=10, hjust = 0.5),
        axis.text=element_text(size=8),
        axis.title=element_text(size=8))

# Print plot
plotPR07

# Save plot
ggsave(file="PR07.svg", plot=plotPR07)


#################################################################
# SessionInfo()
#################################################################
# 
# R version 4.0.5 (2021-03-31)
# Platform: x86_64-w64-mingw32/x64 (64-bit)
# Running under: Windows Server x64 (build 17763)
# 
# Matrix products: default
# 
# locale:
#   [1] LC_COLLATE=German_Germany.1252  LC_CTYPE=German_Germany.1252    LC_MONETARY=German_Germany.1252 LC_NUMERIC=C                   
# [5] LC_TIME=German_Germany.1252    
# 
# attached base packages:
#   [1] stats     graphics  grDevices utils     datasets  methods   base     
# 
# other attached packages:
#   [1] psych_2.1.3        tidyr_1.1.3        data.table_1.14.0  dplyr_1.0.5        ggthemes_4.2.4     likert_1.3.5       xtable_1.8-4       scales_1.1.1      
# [9] colorspace_2.0-1   RColorBrewer_1.1-2 ggplot2_3.3.3      pacman_0.5.1      
# 
# loaded via a namespace (and not attached):
#   [1] Rcpp_1.0.6        pillar_1.6.0      compiler_4.0.5    plyr_1.8.6        tools_4.0.5       digest_0.6.27     nlme_3.1-152      lattice_0.20-41  
# [9] lifecycle_1.0.0   tibble_3.1.1      gtable_0.3.0      pkgconfig_2.0.3   rlang_0.4.11      DBI_1.1.1         parallel_4.0.5    gridExtra_2.3    
# [17] withr_2.4.2       stringr_1.4.0     systemfonts_1.0.1 generics_0.1.0    vctrs_0.3.8       grid_4.0.5        tidyselect_1.1.1  svglite_2.0.0    
# [25] glue_1.4.2        R6_2.5.0          fansi_0.4.2       farver_2.1.0      purrr_0.3.4       reshape2_1.4.4    magrittr_2.0.1    ellipsis_0.3.2   
# [33] assertthat_0.2.1  mnormt_2.0.2      labeling_0.4.2    utf8_1.2.1        stringi_1.5.3     munsell_0.5.0     tmvnsim_1.0-2     crayon_1.4.1  
# 
