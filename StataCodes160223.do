******************************************************************************** 
*2006
********************************************************************************

clear
*directory
cd "E:\Diarrhea\Bangladesh MICS 2006 SPSS Datasets"

******************************************************************************** 
*DATA MERGE 
********************************************************************************

use "wm" , clear
sort HH1 HH2 LN
save "wm" , replace

use "hh" , clear
sort HH1 HH2
save "hh" , replace

use "hl" , clear
sort HH1 HH2 LN
save "hl" , replace

use "ch" , clear
sort HH1 HH2 LN
save "ch" , replace

merge using wm.dta
keep if _merge == 3
save "ch" , replace
drop _merge

merge m:1 HH1 HH2 using hh.dta
keep if _merge == 3
save "ch" , replace
drop _merge

rename LN HL1
save "ch" , replace

use "hl" , clear
sort HH1 HH2 LN
save "hl" , replace

use "ch" , clear
sort HH1 HH2 HL1
save "ch" , replace

merge m:1 HH1 HH2 HL1 using hl.dta
keep if _merge == 3
save "ch" , replace
drop _merge

********************************************************************************
*WEIGHT, STRATA, CLUSTER VARIABLE FOR THE APPENDED DATA
********************************************************************************
gen wgt=chweight
svyset [pw=wgt],psu(HH1) strata(Stratum)

********************************************************************************
*Checking information with report
********************************************************************************

svy: tab CA1
gen had_diarrhea = .
replace had_diarrhea = 1 if CA1==1
replace had_diarrhea = 0 if CA1==2  
replace had_diarrhea  = . if CA1==8
replace had_diarrhea  = . if CA1==9
label define diar   1 "Yes" 0 "No"  
label value had_diarrhea  diar
svy: tab had_diarrhea, count cellwidth(15) format(%15.2g)
svy: tab had_diarrhea, format(%15.4g)

*Age.
svy: tab cage_11 had_diarrhea, count cellwidth(15) format(%15.4g) row

*child sex.
svy: tab HL4 had_diarrhea, count cellwidth(15) format(%15.4g) row

*Residence.
svy: tab HH6
gen area1=HH6
recode area1 1=1
recode area1 2/4=2
recode area1 5=3
label define area1  1 "Rural" 2 "Urban" 3 "Tribal"
label values area area1
svy: tab area had_diarrhea, count cellwidth(15) format(%15.4g) row

*Division.
svy: tab HH7 had_diarrhea, count cellwidth(15) format(%15.4g) row

*Education.
svy: tab melevel
recode melevel 1=2
recode melevel 9=.
svy: tab melevel had_diarrhea, count cellwidth(15) format(%15.4g) row

*Mother Age.
svy: tab wage
gen WA=wage
recode WA 1=1
recode WA 2/4=2
recode WA 5/7=3
label define WA 1 "15-19" 2 "20-34" 3 "35+"
svy: tab WA had_diarrhea, count cellwidth(15) format(%15.4g) row

*Weakth Status.
svy: tab wlthind5
recode wlthind5 0=.
svy: tab wlthind5 had_diarrhea, count cellwidth(15) format(%15.4g) row

*Religion.
svy: tab HC1A
gen Religion1=HC1A
recode Religion1 1=1
recode Religion1 2/7=2
recode Religion1 9=.
label define Religion1 1 "Islam" 2 "Others"
label values Religion Religion1
svy: tab Religion had_diarrhea, count cellwidth(15) format(%15.4g) row

*household sex.
svy: tab hhsex had_diarrhea, count cellwidth(15) format(%15.4g) row

*Ethnicity.
svy: tab HC1C
gen ethnicity2=HC1C
recode ethnicity2 1=0
recode ethnicity2 9=.
recode ethnicity2 2/7=1
label define ethnicity2  1 "Yes" 2 "No"
svy: tab ethnicity2 had_diarrhea, count cellwidth(15) format(%15.4g) row

*Toilet facility shared.
svy: tab WS8
gen TS1=WS8
recode TS1 9=.
label define TS1 1 "Yes" 2 "No"
label values TS TS1
svy: tab TS had_diarrhea, count cellwidth(15) format(%15.4g) row

*Type of toilet facility.
svy: tab WS7
gen TF1=WS7
recode TF1 11/23=1
recode TF1 31/96=2
recode TF1 99=.
recode TF1 9=.
label define TF1 1 "improved" 2 "unimproved"
label values TF TF1
svy: tab TF had_diarrhea, count cellwidth(15) format(%15.4g) row


*Salt Iodization.
svy: tab SI1
gen SI=SI1
recode SI 1=0
recode SI 2=0
recode SI 3=0
recode SI 4=1
recode SI 6=0
recode SI 9=.
recode SI 7=.
label define SI 0 "No" 1 "Yes"
svy: tab SI had_diarrhea, count cellwidth(15) format(%15.4g) row


*household members.
svy: tab HH11
gen HHM=HH11
recode HHM 2/4=0
recode HHM 5/34=1
label define HHM 0 "No" 1 "Yes"
svy: tab HHM had_diarrhea, count cellwidth(15) format(%15.4g) row

*Source water type (100ml).
svy: tab WS1
gen swt1=WS1
recode swt 11/14=1
recode swt 21=1
recode swt 31/32=1
recode swt 41/51=1
recode swt 61/72=2
recode swt 81=2
recode swt 91/92=1
recode swt 96=2
recode swt 99=.
label define swt  1 "Improved" 2 "Unimproved" 
label values swt swt1
svy: tab swt had_diarrhea, count 
svy: tab swt had_diarrhea, count cellwidth(15) format(%15.4g) row


*Water treatment.
svy: tab WS5
gen wt1=WS5
recode wt1 8=.
recode wt1 9=.
label define wt1  1 "Yes" 2 "No" 
label values wt wt1
svy: tab wt had_diarrhea, count 
svy: tab wt had_diarrhea, count cellwidth(15) format(%15.4g) row





********************************************************************************
**Univariate Logistic regression
********************************************************************************

svy: logit had_diarrhea ib5.cage_11, or *sig
svy: logit had_diarrhea ib2.HL4, or *sig
svy: logit had_diarrhea ib3.area, or *sig
svy: logit had_diarrhea ib6.HH7, or *sig
svy: logit had_diarrhea ib5.melevel, or *sig
svy: logit had_diarrhea ib3.WA, or
svy: logit had_diarrhea ib5.wlthind5, or *sig
svy: logit had_diarrhea ib2.Religion, or *sig
svy: logit had_diarrhea ib2.hhsex, or
svy: logit had_diarrhea ib1.ethnicity2, or *sig
svy: logit had_diarrhea ib2.TS, or *sig
svy: logit had_diarrhea i.TF, or *sig
svy: logit had_diarrhea ib1.SI, or *sig
svy: logit had_diarrhea i.HHM, or
svy: logit had_diarrhea ib2.swt, or
svy: logit had_diarrhea ib2.wt, or

********************************************************************************
**Multivariate Logistic regression
********************************************************************************

svy: logit had_diarrhea ib5.cage_11 ib2.HL4 ib3.area ib6.HH7 ib5.melevel ib5.wlthind5 ib2.Religion ib1.ethnicity2 ib2.TS i.TF ib1.SI, or

logit had_diarrhea ib5.cage_11 ib2.HL4 ib3.area ib6.HH7 ib5.melevel ib5.wlthind5 ib2.Religion ib1.ethnicity2 ib2.TS i.TF ib1.SI

lroc

estat ic



******************************************************************************** 
*2012
********************************************************************************

clear all
*directory
cd "E:\Diarrhea\Bangladesh MICS 2012-13 SPSS Datasets"

******************************************************************************** 
*DATA MERGE 
********************************************************************************

use "hh" , clear
sort HH1 HH2
save "hh" , replace

use "wm", clear
sort HH1 HH2 LN
save "wm" , replace

use "bh", clear
sort HH1 HH2 LN
save "bh" , replace

use "ch", clear
sort HH1 HH2 LN
save "ch" , replace

merge m:1 HH1 HH2 using hh.dta
keep if _merge == 3
drop _merge
save "ch1" , replace


merge using wm.dta
tab _merge
keep if _merge == 3
save "ch" , replace
drop _merge


********************************************************************************
*WEIGHT, STRATA, CLUSTER VARIABLE FOR THE APPENDED DATA
********************************************************************************
gen wgt=chweight
svyset [pw=wgt],psu(HH1) strata(stratum)

********************************************************************************
*Checking information with report
********************************************************************************
*outcome and key predictor
svy: tab CA1
gen had_diarrhea = .
replace had_diarrhea = 1 if CA1==1
replace had_diarrhea = 0 if CA1==2  
replace had_diarrhea  = . if CA1==8
replace had_diarrhea  = . if CA1==9
label define diar   1 "Yes" 0 "No"  
label value had_diarrhea  diar
svy: tab had_diarrhea
svy: tab had_diarrhea, count cellwidth(15) format(%15.3g)

*Age.
svy: tab CAGE_11
svy: tab CAGE_11 had_diarrhea, count cellwidth(15) format(%15.3g) row

*child sex.
svy: tab HL4 had_diarrhea, row
svy: tab HL4 had_diarrhea, count cellwidth(15) format(%15.3g) row

*Inadequate supervision.
recode EC3A 8=.
recode EC3A 9=.
recode EC3B 8=.
recode EC3B 9=.
generate IS2    = .
replace  IS2    = 0 if (EC3A == 0) 
replace  IS2    = 1 if (EC3A == 1) 
replace  IS2    = 1 if (EC3A == 2) 
replace  IS2    = 1 if (EC3A == 3) 
replace  IS2    = 1 if (EC3A == 4)
replace  IS2    = 1 if (EC3A == 5)  
replace  IS2    = 1 if (EC3A == 6) 
replace  IS2    = 1 if (EC3A == 7)

replace  IS2    = 0 if (EC3B == 0) 
replace  IS2    = 1 if (EC3B == 1) 
replace  IS2    = 1 if (EC3B == 2) 
replace  IS2    = 1 if (EC3B == 3) 
replace  IS2    = 1 if (EC3B == 4)
replace  IS2    = 1 if (EC3B == 5)  
replace  IS2    = 1 if (EC3B == 6) 
replace  IS2    = 1 if (EC3B == 7)

tab IS2
label define IS2 1 "Yes" 0 "No"
svy: tab IS2 had_diarrhea, row
svy: tab IS2 had_diarrhea, count cellwidth(15) format(%15.3g) row

*Weight for Age underweight.
tab WAZ2
recode WAZ2 99.97 = .
recode WAZ2 99.98 = .
recode WAZ2 99.99 = .
tab WAZ2
generate underweight1    = .
replace  underweight1    = 1 if (WAZ2 <= -2) 
replace  underweight1   = 2 if (WAZ2 > -2) & (WAZ2 <.) 
label define underweight1 1 "Yes" 2 "No"
label values underweight underweight1
svy: tab underweight had_diarrhea, count cellwidth(15) format(%15.3g) row


*Height for Age Stunned.
tab HAZ2
recode HAZ2 99.97 = .
recode HAZ2 99.98 = .
recode HAZ2 99.99 = .
tab HAZ2
generate Stunned1    = .
replace  Stunned1    = 1 if (HAZ2 <= -2) 
replace  Stunned1    = 2 if (HAZ2 > -2) & (HAZ2 <.) 
label define Stunned1 1 "Yes" 2 "No"
label values Stunned Stunned1
svy: tab Stunned had_diarrhea, count cellwidth(15) format(%15.3g) row

*Weight for Age Wasted.
tab WHZ2
recode WHZ2 99.97 = .
recode WHZ2 99.98 = .
recode WHZ2 99.99 = .
tab WHZ2
generate Wasted1    = .
replace  Wasted1    = 1 if (WHZ2 <= -2) 
replace  Wasted1    = 2 if (WHZ2 > -2) & (WHZ2 <.) 
label define Wasted1 1 "Yes" 2 "No"
label values Wasted Wasted1
svy: tab Wasted had_diarrhea, count cellwidth(15) format(%15.3g) row

*Weight for Age Overweight.
generate Overweight1    = .
replace  Overweight1    = 1 if (WHZ2 >= 2) 
replace  Overweight1    = 2 if (WHZ2 < 2)
label define Overweight1 1 "Yes" 2 "No"
label values Overweight Overweight1
svy: tab Overweight had_diarrhea, count cellwidth(15) format(%15.3g) row


*Residence.
svy: tab HH6
gen area1=HH6
recode area1 1=1
recode area1 2/4=2
recode area1 5=3
label define area1  1 "Rural" 2 "Urban" 3 "Tribal"
label values area area1
svy: tab area had_diarrhea, count cellwidth(15) format(%15.3g) row

*Division.
svy: tab HH7
svy: tab HH7 had_diarrhea, count cellwidth(15) format(%15.3g) row

*Education.
svy: tab melevel
gen ME1 = melevel
recode ME1 9=.
recode ME1 1=1
recode ME1 2=1
recode ME1 3=2
recode ME1 4=3
recode ME1 5=4
label define ME1  1 "Prin" 2 "Pric" 3 "Secin" 4 "Seccom"
label values ME ME1
svy: tab ME had_diarrhea, count cellwidth(15) format(%15.3g) row

*Mother Age.
svy: tab WAGE
gen WA21=WAGE
recode WA21 1=1
recode WA21 2/4=2
recode WA21 5/7=3
label define WA21 1 "15-19" 2 "20-34" 3 "35+"
label values WA2 WA21
svy: tab WA2 had_diarrhea, count cellwidth(15) format(%15.3g) row

*Wealth index Status.
svy: tab windex5
recode windex5 0=.
svy: tab windex5 had_diarrhea, count cellwidth(15) format(%15.3g) row

*Religion.
svy: tab HC1A
gen Religion1=HC1A
recode Religion1 1=1
recode Religion1 2/7=2
recode Religion1 9=.
label define Religion1 1 "Islam" 2 "Others"
label values Religion Religion1
svy: tab Religion had_diarrhea, count cellwidth(15) format(%15.3g) row

*household sex.
svy: tab HHSEX had_diarrhea, count cellwidth(15) format(%15.3g) row


*ethnicity.
svy: tab ethnicity had_diarrhea, count cellwidth(15) format(%15.3g) row

*toilet facility shared.
generate TFS1    = WS15
recode TFS1 9 = .
label define TFS1 1 "Yes" 2 "No"
label values TFS TFS1
svy: tab TFS had_diarrhea, count cellwidth(15) format(%15.3g) row

*Type of toilet facility.
svy: tab WS11
gen TF1=WS11
recode TF1 11/23=1
recode TF1 31/96=2
recode TF1 99=.
label define TF1 1 "improved" 2 "unimproved" 3 "other"
label values TF TF1
svy: tab TF1 had_diarrhea, row
svy: tab TF1 had_diarrhea, count cellwidth(15) format(%15.3g) row

*Salt Iodization.
svy: tab SA1
gen SI2=SA1
recode SI2 1=0
recode SI2 2=1
recode SI2 3=1
recode SI2 4=0
recode SI2 6=0
recode SI2 9=.
label define SI2 0 "No" 1 "Yes"
label values SI SI2
svy: tab SI had_diarrhea, count cellwidth(15) format(%15.3g) row

*Mass Media.
recode MT2 9=.
recode MT3 9=.
recode MT4 9=.
generate MM1    = .
replace  MM1    = 0 if (MT2 == 4) 
replace  MM1    = 1 if (MT2 == 1) 
replace  MM1    = 1 if (MT2 == 2) 
replace  MM1    = 1 if (MT2 == 3) 
replace  MM1    = 0 if (MT3 == 4)
replace  MM1    = 1 if (MT3 == 1)  
replace  MM1    = 1 if (MT3 == 2) 
replace  MM1    = 1 if (MT3 == 3)
replace  MM1    = 0 if (MT4 == 4)  
replace  MM1    = 1 if (MT4 == 1) 
replace  MM1    = 1 if (MT4 == 2) 
replace  MM1    = 1 if (MT4 == 3)
label define MM1 1 "Yes" 0 "No"
label values MM MM1
svy: tab MM had_diarrhea, count cellwidth(15) format(%15.3g) row


*household members.
svy: tab HH48
gen HHM=HH48
recode HHM 2/4=0
recode HHM 5/34=1
label define HHM 0 "No" 1 "Yes"
svy: tab HHM had_diarrhea, count cellwidth(15) format(%15.3g) row

*Animals.
generate HAni1    = HC17
recode HAni1 9 = .
label define HAni1 1 "Yes" 2 "No"
label values HAni HAni1
svy: tab HAni had_diarrhea, count cellwidth(15) format(%15.3g) row

*Source water type (100ml).
svy: tab WS1
gen swt1=WS1
recode swt 11/14=1
recode swt 21=1
recode swt 31=1
recode swt 32=2
recode swt 41=1
recode swt 42=2
recode swt 51=1
recode swt 61/72=2
recode swt 81=2
recode swt 91/92=1
recode swt 96=2
recode swt 99=.
label define swt  1 "Improved" 2 "Unimproved" 
label values swt1 swt
svy: tab swt had_diarrhea, count cellwidth(15) format(%15.3g) row


*Source of water.
generate SW1    = WQ12
recode SW1 8 = .
label define SW1 1 "Direct" 2 "Covered" 3 "Uncovered"
label values SW SW1
svy: tab SW had_diarrhea, count cellwidth(15) format(%15.3g) row

*Water treatment.
svy: tab WS9
gen wt1=WS9
recode wt1 8=.
recode wt1 9=.
label define wt1  1 "Yes" 2 "No" 
label values wt wt1
svy: tab wt had_diarrhea, count 
svy: tab wt had_diarrhea, count cellwidth(15) format(%15.3g) row


********************************************************************************
**Univariate Logistic regression
********************************************************************************

svy: logit had_diarrhea ib5.CAGE_11, or *sig
svy: logit had_diarrhea ib2.HL4, or 
svy: logit had_diarrhea i.IS2, or *sig
svy: logit had_diarrhea ib2.underweight, or
svy: logit had_diarrhea ib2.Stunned, or
svy: logit had_diarrhea ib2.Wasted, or *sig
svy: logit had_diarrhea i.Overweight, or *sig
svy: logit had_diarrhea ib2.area, or *sig
svy: logit had_diarrhea ib60.HH7, or *sig
svy: logit had_diarrhea ib4.ME, or 
svy: logit had_diarrhea ib3.WA2, or *sig
svy: logit had_diarrhea ib5.windex5, or
svy: logit had_diarrhea ib2.Religion, or
svy: logit had_diarrhea ib2.HHSEX, or
svy: logit had_diarrhea ib2.ethnicity, or
svy: logit had_diarrhea ib2.TFS, or *sig
svy: logit had_diarrhea i.TF1, or
svy: logit had_diarrhea ib1.SI, or
svy: logit had_diarrhea ib1.MM, or
svy: logit had_diarrhea i.HHM, or *sig
svy: logit had_diarrhea ib2.HAni, or
svy: logit had_diarrhea ib2.swt, or
svy: logit had_diarrhea ib3.SW, or *sig
svy: logit had_diarrhea ib2.wt, or

********************************************************************************
**Multivariate Logistic regression
********************************************************************************

svy: logit had_diarrhea ib5.CAGE_11 i.IS2 ib2.Wasted i.Overweight ib2.area ib60.HH7 ib3.WA2 ib2.TFS i.HHM ib3.SW, or

logit had_diarrhea ib5.CAGE_11 i.IS2 ib2.Wasted i.Overweight ib2.area ib60.HH7 ib3.WA2 ib2.TFS i.HHM ib3.SW, or

lroc

estat ic



******************************************************************************** 
*2019
********************************************************************************

clear all
*directory
cd "E:\Diarrhea\Bangladesh MICS6 SPSS Datasets"

******************************************************************************** 
*DATA MERGE 
********************************************************************************

use "hh" , clear
sort HH1 HH2
save "hh" , replace

use "wm", clear
sort HH1 HH2 LN
save "wm" , replace

use "bh", clear
sort HH1 HH2 LN
save "bh" , replace

use "ch", clear
sort HH1 HH2 LN
save "ch" , replace

merge m:1 HH1 HH2 using hh.dta
keep if _merge == 3
drop _merge
save "ch1" , replace


merge using wm.dta
tab _merge
keep if _merge == 3
save "ch" , replace
drop _merge


********************************************************************************
*WEIGHT, STRATA, CLUSTER VARIABLE FOR THE APPENDED DATA
********************************************************************************
gen wgt=chweight
svyset [pw=wgt],psu(HH1) strata(stratum)

********************************************************************************
*Checking information with report
********************************************************************************
*outcome and key predictor
svy: tab CA1
gen had_diarrhea = .
replace had_diarrhea = 1 if CA1==1
replace had_diarrhea = 0 if CA1==2  
replace had_diarrhea  = . if CA1==8
replace had_diarrhea  = . if CA1==9
label define diar   1 "Yes" 0 "No"  
label value had_diarrhea  diar
svy: tab had_diarrhea
svy: tab had_diarrhea, count cellwidth(15) format(%15.2g)


*Age.
svy: tab CAGE_11
svy: tab CAGE_11 had_diarrhea, count cellwidth(15) format(%15.3g) row

*child sex.
svy: tab HL4 had_diarrhea, row
svy: tab HL4 had_diarrhea, count cellwidth(15) format(%15.3g) row

*Inadequate supervision.
recode EC3A 8=.
recode EC3A 9=.
recode EC3B 8=.
recode EC3B 9=.
generate IS1    = .
replace  IS1    = 0 if (EC3A == 0) 
replace  IS1    = 1 if (EC3A == 1) 
replace  IS1    = 1 if (EC3A == 2) 
replace  IS1    = 1 if (EC3A == 3) 
replace  IS1    = 1 if (EC3A == 4)
replace  IS1    = 1 if (EC3A == 5)  
replace  IS1    = 1 if (EC3A == 6) 
replace  IS1    = 1 if (EC3A == 7)

replace  IS1    = 0 if (EC3B == 0) 
replace  IS1    = 1 if (EC3B == 1) 
replace  IS1    = 1 if (EC3B == 2) 
replace  IS1    = 1 if (EC3B == 3) 
replace  IS1    = 1 if (EC3B == 4)
replace  IS1    = 1 if (EC3B == 5)  
replace  IS1    = 1 if (EC3B == 6) 
replace  IS1    = 1 if (EC3B == 7)

tab IS1
label define IS1 1 "Yes" 0 "No"
label values IS IS1
svy: tab IS had_diarrhea, row
svy: tab IS had_diarrhea, count cellwidth(15) format(%15.3g) row

*Weight for Age underweight.
tab WAZ2
recode WAZ2 99.97 = .
recode WAZ2 99.98 = .
recode WAZ2 99.99 = .
tab WAZ2
generate underweight1    = .
replace  underweight1    = 1 if (WAZ2 <= -2) 
replace  underweight1   = 2 if (WAZ2 > -2) & (WAZ2 <.) 
label define underweight1 1 "Yes" 2 "No"
label values underweight underweight1
svy: tab underweight had_diarrhea, count cellwidth(15) format(%15.3g) row

*Height for Age Stunned.
tab HAZ2
recode HAZ2 99.97 = .
recode HAZ2 99.98 = .
recode HAZ2 99.99 = .
tab HAZ2
generate Stunned1    = .
replace  Stunned1    = 1 if (HAZ2 <= -2) 
replace  Stunned1    = 2 if (HAZ2 > -2) & (HAZ2 <.) 
label define Stunned1 1 "Yes" 2 "No"
label values Stunned Stunned1
svy: tab Stunned had_diarrhea, count cellwidth(15) format(%15.3g) row

*Weight for Age Wasted.
tab WHZ2
recode WHZ2 99.97 = .
recode WHZ2 99.98 = .
recode WHZ2 99.99 = .
tab WHZ2
generate Wasted1    = .
replace  Wasted1    = 1 if (WHZ2 <= -2) 
replace  Wasted1    = 2 if (WHZ2 > -2) & (WHZ2 <.) 
label define Wasted1 1 "Yes" 2 "No"
label values Wasted Wasted1
svy: tab Wasted had_diarrhea, count cellwidth(15) format(%15.3g) row

*Weight for Age Overweight.
generate Overweight1    = .
replace  Overweight1    = 1 if (WHZ2 >= 2) 
replace  Overweight1    = 2 if (WHZ2 < 2)
label define Overweight1 1 "Yes" 2 "No"
label values Overweight Overweight1
svy: tab Overweight had_diarrhea, count cellwidth(15) format(%15.3g) row

*Residence.
svy: tab HH6
gen area1=HH6
recode area1 1=1
recode area1 2/4=2
recode area1 5=3
label define area1  1 "Rural" 2 "Urban" 3 "Tribal"
label values area area1
svy: tab area had_diarrhea, count cellwidth(15) format(%15.3g) row

*Division.
svy: tab HH7
svy: tab HH7 had_diarrhea, count cellwidth(15) format(%15.3g) row

*Education.
svy: tab melevel
recode melevel 9=.
svy: tab melevel had_diarrhea, count cellwidth(15) format(%15.3g) row

*Mother Age.
svy: tab WAGE
gen WA21=WAGE
recode WA21 1=1
recode WA21 2/4=2
recode WA21 5/7=3
label define WA21 1 "15-19" 2 "20-34" 3 "35+"
label values WA2 WA21
svy: tab WA2 had_diarrhea, count cellwidth(15) format(%15.3g) row

*Wealth index Status.
svy: tab windex5
recode windex5 0=.
svy: tab windex5 had_diarrhea, count cellwidth(15) format(%15.3g) row

*Religion.
svy: tab HC1A
gen Religion1=HC1A
recode Religion1 1=1
recode Religion1 2/7=2
recode Religion1 9=.
label define Religion1 1 "Islam" 2 "Others"
label values Religion Religion1
svy: tab Religion had_diarrhea, count cellwidth(15) format(%15.3g) row

*household sex.
svy: tab HHSEX had_diarrhea, count cellwidth(15) format(%15.3g) row

*ethnicity.
svy: tab ethnicity had_diarrhea, count cellwidth(15) format(%15.3g) row


*toilet facility shared.
generate TFS1    = WS15
recode TFS1 9 = .
label define TFS1 1 "Yes" 2 "No"
label values TFS TFS1
svy: tab TFS had_diarrhea, count cellwidth(15) format(%15.3g) row

*Type of toilet facility.
svy: tab WS11
gen TF1=WS11
recode TF1 11/23=1
recode TF1 31/96=2
recode TF1 99=.
label define TF1 1 "improved" 2 "unimproved"
label values TF TF1
svy: tab TF had_diarrhea, row
svy: tab TF1 had_diarrhea, count cellwidth(15) format(%15.2g) row


*Salt Iodization.
svy: tab SA1
gen SI2=SA1
recode SI2 1=0
recode SI2 2=1
recode SI2 3=1
recode SI2 4=0
recode SI2 6=0
recode SI2 9=.
label define SI2 0 "No" 1 "Yes"
label values SI SI2
svy: tab SI had_diarrhea, count cellwidth(15) format(%15.3g) row


*Mass Media.
recode MT1 9=.
recode MT2 9=.
recode MT3 9=.
generate MM1    = .
replace  MM1    = 0 if (MT1 == 0) 
replace  MM1    = 1 if (MT1 == 1) 
replace  MM1    = 1 if (MT1 == 2) 
replace  MM1    = 1 if (MT1 == 3) 
replace  MM1    = 0 if (MT2 == 0)
replace  MM1    = 1 if (MT2 == 1)  
replace  MM1    = 1 if (MT2 == 2) 
replace  MM1    = 1 if (MT2 == 3)
replace  MM1    = 0 if (MT3 == 0)  
replace  MM1    = 1 if (MT3 == 1) 
replace  MM1    = 1 if (MT3 == 2) 
replace  MM1    = 1 if (MT3 == 3)
label define MM1 1 "Yes" 0 "No"
label values MM MM1
svy: tab MM had_diarrhea, count cellwidth(15) format(%15.3g) row

*household members.
svy: tab HH48
gen HHM=HH48
recode HHM 2/4=0
recode HHM 5/34=1
label define HHM 0 "No" 1 "Yes"
svy: tab HHM had_diarrhea, count cellwidth(15) format(%15.3g) row

*Animals.
generate HAni1    = HC17
recode HAni1 9 = .
label define HAni1 1 "Yes" 2 "No"
label values HAni HAni1
svy: tab HAni had_diarrhea, count cellwidth(15) format(%15.3g) row

*Source water type (100ml).
svy: tab WS1
gen swt1=WS1
recode swt 11/14=1
recode swt 21=1
recode swt 31=1
recode swt 32=2
recode swt 41=1
recode swt 42=2
recode swt 51=1
recode swt 61/72=2
recode swt 81=2
recode swt 91/92=1
recode swt 96=2
recode swt 99=.
label define swt  1 "Improved" 2 "Unimproved" 
label values swt1 swt
svy: tab swt had_diarrhea, count cellwidth(15) format(%15.3g) row


*Source of water.
generate SW1    = WQ12
recode SW1 8 = .
label define SW1 1 "Direct" 2 "Covered" 3 "Uncovered"
label values SW SW1
svy: tab SW had_diarrhea, count cellwidth(15) format(%15.3g) row

*Water treatment.
svy: tab WS9
gen wt1=WS9
recode wt1 8=.
recode wt1 9=.
label define wt1  1 "Yes" 2 "No" 
label values wt wt1
svy: tab wt had_diarrhea, count 
svy: tab wt had_diarrhea, count cellwidth(15) format(%15.3g) row


********************************************************************************
**Univariate Logistic regression
********************************************************************************


svy: logit had_diarrhea ib5.CAGE_11, or *sig
svy: logit had_diarrhea ib2.HL4, or *sig
svy: logit had_diarrhea i.IS, or *sig
svy: logit had_diarrhea ib2.underweight, or *sig
svy: logit had_diarrhea ib2.Stunned, or *sig
svy: logit had_diarrhea ib2.Wasted, or *sig
svy: logit had_diarrhea i.Overweight, or *sig
svy: logit had_diarrhea ib2.area, or 
svy: logit had_diarrhea ib60.HH7, or *sig
svy: logit had_diarrhea ib4.melevel, or *sig
svy: logit had_diarrhea ib3.WA2, or 
svy: logit had_diarrhea ib5.windex5, or *sig
svy: logit had_diarrhea ib2.Religion, or *sig
svy: logit had_diarrhea ib2.HHSEX, or *sig
svy: logit had_diarrhea ib2.ethnicity, or *sig
svy: logit had_diarrhea ib2.TFS, or *sig
svy: logit had_diarrhea i.TF1, or *sig
svy: logit had_diarrhea ib1.SI, or *sig
svy: logit had_diarrhea ib1.MM, or *sig
svy: logit had_diarrhea i.HHM, or *sig
svy: logit had_diarrhea ib2.HAni, or
svy: logit had_diarrhea ib2.swt, or
svy: logit had_diarrhea ib3.SW, or 
svy: logit had_diarrhea ib2.wt, or

********************************************************************************
**Multivariate Logistic regression
********************************************************************************

**p<0.200: cage_11 HL4 area HH7 melevel wlthind5 Religion ethnicity2 TS TF SI


svy: logit had_diarrhea ib5.CAGE_11 ib2.HL4 i.IS i.underweight i.Stunned i.Wasted i.Overweight ib6.HH7 ib5.melevel ib5.windex5 ib2.Religion i.HHSEX ib1.ethnicity ib2.TFS  i.TF1 ib1.SI i.MM i.HHM, or

logit had_diarrhea ib5.CAGE_11 ib2.HL4 i.IS i.underweight i.Stunned i.Wasted i.Overweight ib6.HH7 ib5.melevel ib5.windex5 ib2.Religion i.HHSEX ib1.ethnicity ib2.TFS  i.TF1 ib1.SI i.MM i.HHM

lroc
predict p
roctab score p

rocreg had_diarrhea CAGE_11 HL4 IS underweight Stunned Wasted Overweight HH7 melevel windex5 Religion HHSEX ethnicity TFS TF1 SI MM HHM

estat ic

coefplot, xline(1)  omitted headings(i.CAGE_11 = "{bf:CAGE_11}") eform drop(_cons) xtitle(Odds ratio)



