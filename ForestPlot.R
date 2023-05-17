library(forestplot)

#2006
dataset <- 
  structure(list(
    OR= c(NA, NA, 1.81,	2.22, 1.45, 1.17, NA, NA, 1.05, NA, NA, 1.46, 1.16, NA, NA, 
          1.27, 1.09, 0.96, 0.65, 1.04, NA, NA, 2.58, 1.29, 1.19, 1.11, NA, NA, 
          1.30,	1.13,	1.12,	0.90, NA, NA, 1.05, NA, NA, 1.27, NA, NA, 1.07, NA, NA, 1.23, NA, NA, 1.13, NA,1.27), 
    
    lower = c(NA, NA, 1.50,	1.86, 1.22, 0.97, NA, NA, 0.95, NA, NA, 0.81, 0.65, NA, NA, 
              0.99, 0.87, 0.78, 0.50, 0.83, NA, NA, 1.21, 0.98, 0.87, 0.86, NA, NA, 
              1.01,	0.89,	0.89,	0.71, NA, NA, 0.82, NA, NA, 0.76, NA, NA, 0.96, NA, NA, 1.08, NA, NA, 0.98, NA,1.26),
    
    upper = c(NA, NA, 2.18,	2.65, 1.73, 1.42, NA, NA, 1.16, NA, NA, 2.62, 2.06, NA, NA, 
              1.63, 1.36, 1.19, 0.85, 1.28, NA, NA, 5.51, 1.69, 1.63, 1.44, NA, NA, 
              1.65,	1.44,	1.41,	1.14, NA, NA, 1.35, NA, NA, 2.13, NA, NA, 1.20, NA, NA, 1.40, NA, NA, 1.30, NA, 1.28)),
    
    .Names = c("OR", "lower", "upper"), 
    
    row.names = c(NA, -35L), 
    
    class = "data.frame" )

mean(dataset$OR, na.rm = T)

tabletext<-cbind(
  
  c( "Covariates", 
     "Age of child (in months)",
     "0-11",  "12-23", "24-35","36-47","48-59 (Ref.)", 
     "Child's sex", 
     "Male","Female (Ref.)",
     "Place of residence",
     "Urban","Rural", "Tribal (Ref.)",
     "Division", 
     "Barishal", "Chattogram","Dhaka","Khulna","Rajshahi","Sylhet (Ref.)",
     "Mother's Education",
     "Non-standard curriculum","Primary incomplete", "Primary complete", "Secondary incomplete", "Secondary complete or higher (Ref.)",
     "Wealth Index",
     "Poorest","Second","Middle","Fourth", "Richest (Ref.)",
     "Religion",
     "Islam","Others (Ref.)",
     "Ethnicity",
     "Bengali","Other (Ref.)",
     "Toilet facilities shared",
     "Yes","No (Ref.)",
     "Toilet facility type",
     "Non-improved","Improved (Ref.)",
     "Salt Iodization",
     "No","Yes (Ref.)",
     "                    Pooled AOR")
)
library(dplyr)

x <- grid.grabExpr(print(forestplot(tabletext, 
           graph.pos = 2,
           dataset,new_page = T,
           is.summary=c(TRUE,TRUE,rep(FALSE,5),
                        TRUE,rep(FALSE,2),
                        TRUE,rep(FALSE,3),
                        TRUE,rep(FALSE,6),
                        TRUE,rep(FALSE,5),
                        TRUE,rep(FALSE,5),
                        TRUE,rep(FALSE,2),
                        TRUE,rep(FALSE,2),
                        TRUE,rep(FALSE,2),
                        TRUE,rep(FALSE,2),
                        TRUE,rep(FALSE,2),
                        FALSE),
           clip=c(0.5,6), 
           xlog=FALSE, 
           boxsize = 0.20,
           col=fpColors(box="black",line="black"),
           xticks=c(seq(0.5,6,0.5)),
           ci.vertices=TRUE,
           title = "MICS 2006",
           xlab = "Adjusted Odds Ratio (AOR)" 
)))
x


library(forestplot)

#2012
dataset <- 
  structure(list(
    OR= c(NA, NA, 4.35,	5.24, 1.59, 2.11, NA, NA, 1.37, NA, NA, 1.61, NA, NA, 3.46, NA, NA, 1.29, NA, NA,
          0.67, 1.01, 1.01, 0.93, 0.90, 1.42, NA, NA, 1.57, 1.46, NA, NA, 0.60, NA, NA, 1.13, NA, NA, 
          1.28, 1.37, NA, 1.72), 
    
    lower = c(NA, NA, 2.10,	2.51, 0.71, 0.92, NA, NA, 0.69, NA, NA, 0.92, NA, NA, 0.40, NA, NA, 0.75, NA, NA,
              0.27, 0.47, 0.46, 0.41, 0.36, 0.63, NA, NA, 0.69, 0.77, NA, NA, 0.36, NA, NA, 0.72, NA, NA, 
              0.53, 0.83, NA,1.71),
    
    upper = c(NA, NA, 9.01,	10.95, 3.59, 4.82, NA, NA, 2.73, NA, NA, 2.84, NA, NA, 29.65, NA, NA, 2.23, NA, NA,
              1.63, 2.20, 2.16, 2.13, 2.22, 3.17, NA, NA, 3.57, 2.74, NA, NA, 0.99, NA, NA, 1.77, NA, NA, 
              3.08, 2.27, NA,1.73)),
    
    .Names = c("OR", "lower", "upper"), 
    
    row.names = c(NA, -35L), 
    
    class = "data.frame" )
mean(dataset$OR, na.rm = T)
tabletext<-cbind(
  
  c( "Covariates", 
     "Age of child (in months)",
     "0-11",  "12-23", "24-35","36-47","48-59 (Ref.)", 
     "Inadequate Supervision", 
     "Yes","No (Ref.)",
     "Wasted", 
     "Yes","No (Ref.)",
     "Overweight", 
     "No","Yes (Ref.)",
     "Place of residence",
     "Rural","Urban (Ref.)",
     "Division", 
     "Barishal", "Chattogram","Dhaka","Khulna","Rajshahi","Rangpur","Sylhet (Ref.)",
     "Mother's Age at the Survey Time",
     "15-19","20-34", "35+ (Ref.)",
     "Toilet facilities shared",
     "Yes","No (Ref.)",
     "Household size",
     "5/5+","<5 (Ref.)",
     "Source of water",
     "Direct from source","Covered container","Uncovered container (Ref.)",
     "                         Pooled AOR")
)
library(dplyr)

y <- grid.grabExpr(print(forestplot(tabletext, 
             graph.pos = 2,
             dataset,new_page = T,
             is.summary=c(TRUE,TRUE,rep(FALSE,5),
                          TRUE,rep(FALSE,2),
                          TRUE,rep(FALSE,2),
                          TRUE,rep(FALSE,2),
                          TRUE,rep(FALSE,2),
                          TRUE,rep(FALSE,7),
                          TRUE,rep(FALSE,3),
                          TRUE,rep(FALSE,2),
                          TRUE,rep(FALSE,2),
                          TRUE,rep(FALSE,3),
                          FALSE),
             clip=c(5,30), 
             xlog=FALSE, 
             boxsize = 0.20,
             col=fpColors(box="black",line="black"),
             xticks=c(seq(0,30,5)),
             ci.vertices=TRUE,
             title = "MICS 2012",
             xlab = "Adjusted Odds Ratio" 
  )))
y


#2019
dataset <- 
  structure(list(
    OR= c(NA, NA, 3.32,	3.36, 2.26, 1.52, NA, NA, 1.04, NA, NA, 1.18, NA, NA, 1.44, NA, NA, 0.93, NA, NA,
          0.89, NA, NA, 1.43, NA, NA, 2.51, 1.33, 0.91, 1.05, 1.22, 0.93, 0.59, NA, NA, 
          1.21, 1.08, 1.09, NA, NA, 1.14, 1.32, 0.95, 1.03, NA, NA, 1.39, NA, NA, 1.20, NA, NA, 
          0.59, NA, NA, 1.23, NA, NA, 1.49, NA, NA, 1.15, NA, NA, 0.99, NA, NA, 0.91, NA,1.33), 
    
    lower = c(NA, NA, 2.63,	2.67, 1.76, 1.18, NA, NA, 0.92, NA, NA, 0.94, NA, NA, 1.20, NA, NA, 0.77, NA, NA,
              0.72, NA, NA, 0.86, NA, NA, 1.74, 0.94, 0.64, 0.72, 0.84, 0.64, 0.40, NA, NA, 
              0.91, 0.86, 0.88, NA, NA, 0.90, 1.04, 0.75, 0.81, NA, NA, 1.02, NA, NA, 0.92, NA, NA, 
              0.34, NA, NA, 1.07, NA, NA, 1.08, NA, NA, 0.99, NA, NA, 0.87, NA, NA, 0.79, NA,1.32),
    
    upper = c(NA, NA, 4.19,	4.22, 2.89, 1.95, NA, NA, 1.19, NA, NA, 1.48, NA, NA, 1.73, NA, NA, 1.10, NA, NA,
              1.10, NA, NA, 2.38, NA, NA, 3.63, 1.90, 1.30, 1.53, 1.79, 1.35, 0.88, NA, NA, 
              1.61, 1.36, 1.34, NA, NA, 1.44, 1.66, 1.20, 1.32, NA, NA, 1.88, NA, NA, 1.55, NA, NA, 1.01, NA, NA, 
              1.42, NA, NA, 2.05, NA, NA, 1.34, NA, NA, 1.14, NA, NA, 1.04, NA,1.34)),
    
    .Names = c("OR", "lower", "upper"), 
    
    row.names = c(NA, -35L), 
    
    class = "data.frame" )
mean(dataset$OR, na.rm = T)
tabletext<-cbind(
  
  c( "Covariates", 
     "Age of child (in months)",
     "0-11",  "12-23", "24-35","36-47","48-59 (Ref.)", 
     "Child's sex", 
     "Male","Female (Ref.)",
     "Inadequate Supervision", 
     "Yes","No (Ref.)",
     "Underweight", 
     "Yes","No (Ref.)",
     "Stunned", 
     "Yes","No (Ref.)",
     "Wasted", 
     "Yes","No (Ref.)",
     "Overweight", 
     "No","Yes (Ref.)",
     "Division", 
     "Barishal", "Chattogram","Dhaka","Khulna","Mymensingh", "Rajshahi","Rangpur","Sylhet (Ref.)",
     "Mother's Education",
     "Primary incomplete","Primary complete", "Secondary incomplete", "Secondary complete or higher (Ref.)",
     "Wealth Index",
     "Poorest","Second","Middle","Fourth", "Richest (Ref.)",
     "Religion",
     "Islam","Others (Ref.)",
     "Household Head Sex",
     "Male","Female (Ref.)",
     "Ethnicity",
     "Bengali","Other (Ref.)",
     "Toilet facilities shared",
     "Yes","No (Ref.)",
     "Toilet facility type",
     "Non-improved","Improved (Ref.)",
     "Salt Iodization",
     "No","Yes (Ref.)",
     "Mass Media",
     "No","Yes (Ref.)",
     "Household size",
     "5/5+","<5 (Ref.)",
     "                    Pooled AOR")
)
library(dplyr)

z <- grid.grabExpr(print(forestplot(tabletext, 
             graph.pos = 2,
             dataset,new_page = T,
             is.summary=c(TRUE,TRUE,rep(FALSE,5),
                          TRUE,rep(FALSE,2),
                          TRUE,rep(FALSE,2),
                          TRUE,rep(FALSE,2),
                          TRUE,rep(FALSE,2),
                          TRUE,rep(FALSE,2),
                          TRUE,rep(FALSE,2),
                          TRUE,rep(FALSE,8),
                          TRUE,rep(FALSE,4),
                          TRUE,rep(FALSE,5),
                          TRUE,rep(FALSE,2),
                          TRUE,rep(FALSE,2),
                          TRUE,rep(FALSE,2),
                          TRUE,rep(FALSE,2),
                          TRUE,rep(FALSE,2),
                          TRUE,rep(FALSE,2),
                          TRUE,rep(FALSE,2),
                          TRUE,rep(FALSE,2),
                          FALSE),
             clip=c(0.5,5), 
             xlog=FALSE, 
             boxsize = 0.20,
             col=fpColors(box="black",line="black"),
             xticks=c(seq(0,5,0.5)),
             ci.vertices=TRUE,
             title = "MICS 2019",
             xlab = "Adjusted Odds Ratio (AOR)" 
  )))

z


library(gridExtra)
tiff("AOR.tiff", units="in", width=24, height=12, res=300)
grid.arrange(x, y, z, ncol=3)
dev.off()
