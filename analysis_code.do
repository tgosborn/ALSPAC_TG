*----------------------------------
* Script name: alspac 1 analysis
* Description: includes codes for descriptive analyses, logistic regression, propensity score matching, interaction models and replicated analyses using multiple imputations. 
* Author: Tom G. Osborn
* Date: 2025-02-28
* Version: 2.4.0
* Licence: UCL
* Dependencies: requires Stata 18+ and ALSPAC data
*----------------------------------

******************************************************
* Derive summary statistics
******************************************************

*** Comparing analytic sample with the excluded sample in terms of characteristics
gen analytic_miss = missing(attenduni) | missing(MHSU24)

* Differences between included and excluded from the analytic sample by each variable  
tabulate analytic_miss sex, chi2 row  
tabulate analytic_miss ethnic, chi2 row  
tabulate analytic_miss sexor_bin, chi2 row  
tabulate analytic_miss edmum_bin, chi2 row  
tabulate analytic_miss family_comp, chi2 row  
tabulate analytic_miss IMDscore00_g, chi2 row  
tabulate analytic_miss aut_bin, chi2 row   
tabulate analytic_miss SMFQ17_bin, chi2 row  
tabulate analytic_miss dis_status, chi2 row  
tabulate analytic_miss carerstatus, chi2 row  
tabulate analytic_miss ACE2, chi2 row  

* Differences between university attendees and non-attendees by each variable  
tabulate attenduni sex, chi2 row  
tabulate attenduni ethnic, chi2 row  
tabulate attenduni sexor_bin, chi2 row  
tabulate attenduni edmum_bin, chi2 row  
tabulate attenduni family_comp, chi2 row  
tabulate attenduni IMDscore00_g, chi2 row  
tabulate attenduni aut_bin, chi2 row   
tabulate attenduni SMFQ17_bin, chi2 row  
tabulate attenduni dis_status, chi2 row  
tabulate attenduni carerstatus, chi2 row  
tabulate attenduni ACE2, chi2 row  
tabulate attenduni MHSU24, chi2 row
tabulate attenduni MHSU_GP, chi2 row
tabulate attenduni MHSU_cons, chi2 row
tabulate attenduni MHSU_MH, chi2 row
tabulate attenduni MHSU_meds, chi2 row 

* Explore relationships between variables
* Compute pairwise Pearson correlation coefficients between variables
pwcorr sex ethnic sexor_bin edmum_bin family_comp aut_bin IMDscore00_g aut_bin AUDIT_disorder CAST SMFQ17 dis_status carerstatus ACE2 MHSU24 MHSU_GP MHSU_cons MHSU_MH MHSU_meds, sig

************************************
*** Estimating Proportions of Health Service Use ***
************************************

* By each variable for MHSU24  
proportion MHSU24, over(attenduni sex)  
proportion MHSU24, over(attenduni ethnic)  
proportion MHSU24, over(attenduni sexor_bin)  
proportion MHSU24, over(attenduni edmum_bin) 
proportion MHSU24, over(attenduni family_comp)  
proportion MHSU24, over(attenduni IMDscore00_g)  
proportion MHSU24, over(attenduni aut_bin)
proportion MHSU24, over(attenduni SMFQ17_bin) 
proportion MHSU24, over(attenduni dis_status)   
proportion MHSU24, over(attenduni carerstatus)
proportion MHSU24, over(attenduni ACE2)  

* By each variable for SMFQ17_bin  
proportion SMFQ17_bin, over(attenduni sex)  
proportion SMFQ17_bin, over(attenduni ethnic)  
proportion SMFQ17_bin, over(attenduni sexor_bin)  
proportion SMFQ17_bin, over(attenduni edmum_bin) 
proportion SMFQ17_bin, over(attenduni family_comp)  
proportion SMFQ17_bin, over(attenduni IMDscore00_g) 
proportion SMFQ17_bin, over(attenduni aut_bin)  
proportion SMFQ17_bin, over(attenduni carerstatus)  
proportion SMFQ17_bin, over(attenduni dis_status)  
proportion SMFQ17_bin, over(attenduni ACE2)  
proportion SMFQ17_bin, over(attenduni MHSU24)  

********************************
* Part 3 - logistic regression modelling - univariate and multivariate analyses 

* H0=the comparison groups do not differ (critical value of p=<0.05)
********************************

** Associations with outcome variables MHSU24
logistic MHSU24 i.attenduni
logistic MHSU24 i.sex 
logistic MHSU24 i.ethnic
logistic MHSU24 i.sexor_bin
logistic MHSU24 i.edmum_bin 
logistic MHSU24 i.family_comp 
logistic MHSU24 i.IMDscore00_g
logistic MHSU24 i.aut_bin
logistic MHSU24 i.SMFQ17_bin
logistic MHSU24 i.carerstatus 
logistic MHSU24 i.dis_status
logistic MHSU24 i.ACE2

** Associations with outcome variables GP
logistic MHSU_GP i.attenduni
logistic MHSU_GP i.sex 
logistic MHSU_GP i.ethnic
logistic MHSU_GP i.sexor_bin
logistic MHSU_GP i.edmum_bin 
logistic MHSU_GP i.family_comp 
logistic MHSU_GP i.IMDscore00_g
logistic MHSU_GP i.aut_bin
logistic MHSU_GP i.SMFQ17_bin
logistic MHSU_GP i.carerstatus 
logistic MHSU_GP i.dis_status
logistic MHSU_GP i.ACE2

** Associations with outcome variable counselling 
logistic MHSU_cons i.attenduni
logistic MHSU_cons i.sex 
logistic MHSU_cons i.ethnic
logistic MHSU_cons i.sexor_bin
logistic MHSU_cons i.edmum_bin 
logistic MHSU_cons i.family_comp 
logistic MHSU_cons i.IMDscore00_g
logistic MHSU_cons i.aut_bin
logistic MHSU_cons i.SMFQ17_bin
logistic MHSU_cons i.carerstatus 
logistic MHSU_cons i.dis_status
logistic MHSU_cons i.ACE2

** Associations with the outcome variable mental health service
logistic MHSU_MH i.attenduni
logistic MHSU_MH i.sex 
logistic MHSU_MH i.ethnic
logistic MHSU_MH i.sexor_bin
logistic MHSU_MH i.edmum_bin 
logistic MHSU_MH i.family_comp 
logistic MHSU_MH i.IMDscore00_g
logistic MHSU_MH i.aut_bin
logistic MHSU_MH i.SMFQ17_bin
logistic MHSU_MH i.carerstatus 
logistic MHSU_MH i.dis_status
logistic MHSU_MH i.ACE2

* Associations with the outcome variable medication use
logistic MHSU_meds i.attenduni
logistic MHSU_meds i.sex 
logistic MHSU_meds i.ethnic
logistic MHSU_meds i.sexor_bin
logistic MHSU_meds i.edmum_bin 
logistic MHSU_meds i.family_comp 
logistic MHSU_meds i.IMDscore00_g
logistic MHSU_meds i.aut_bin
logistic MHSU_meds i.SMFQ17_bin
logistic MHSU_meds i.carerstatus 
logistic MHSU_meds i.dis_status
logistic MHSU_meds i.ACE2

** Associations with exposure variable attenduni
logistic attenduni i.sex
logistic attenduni i.ethnic
logistic attenduni i.sexor_bin
logistic attenduni i.edmum_bin
logistic attenduni i.family_comp
logistic attenduni i.IMDscore00_g
logistic attenduni i.aut_bin
logistic attenduni i.SMFQ17_bin
logistic attenduni i.carerstatus
logistic attenduni i.dis_status
logistic attenduni i.ACE2

************************************************************
*** Multivariate Analysis ***
************************************************************

* Modeling the relationship between university attendance (reported at ages 25-26) 
* and health service use for mental health problems (reported at age 24)  

************************************************************
*** Any Health Service Use for a Mental Health Problem ***
************************************************************

* Model 1: Unadjusted  
logistic MHSU24 i.attenduni  

* Model 2: Adjusted for individual predisposing factors  
logistic MHSU24 i.attenduni i.sex i.sexor_bin i.ethnic  

* Model 3: Adjusted for individual + family predisposing factors  
logistic MHSU24 i.attenduni i.sex i.sexor_bin i.ethnic i.family_comp  

* Model 4: Adjusted Model 3 + Enabling factors  
logistic MHSU24 i.attenduni i.sex i.sexor_bin i.ethnic i.family_comp i.edmum_bin i.IMDscore00_g  

* Model 5: Adjusted Model 4 + Need factors  
logistic MHSU24 i.attenduni i.sex i.sexor_bin i.ethnic i.family_comp i.edmum_bin i.IMDscore00_g i.dis_status i.aut_bin i.SMFQ17_bin  

************************************************************
*** General Practice Use ***
************************************************************

* Model 1: Unadjusted  
logistic MHSU_GP i.attenduni  

* Model 2: Adjusted for individual predisposing factors  
logistic MHSU_GP i.attenduni i.sex i.sexor_bin i.ethnic  

* Model 3: Adjusted for individual + family predisposing factors  
logistic MHSU_GP i.attenduni i.sex i.sexor_bin i.ethnic i.family_comp  

* Model 4: Adjusted Model 3 + Enabling factors  
logistic MHSU_GP i.attenduni i.sex i.sexor_bin i.ethnic i.family_comp i.edmum_bin i.IMDscore00_g  

* Model 5: Adjusted Model 4 + Need factors  
logistic MHSU_GP i.attenduni i.sex i.sexor_bin i.ethnic i.family_comp i.edmum_bin i.IMDscore00_g i.SMFQ17_bin i.aut_bin i.dis_status  

************************************************************
*** Counselling Use ***
************************************************************

* Model 1: Unadjusted  
logistic MHSU_cons i.attenduni  

* Model 2: Adjusted for individual predisposing factors  
logistic MHSU_cons i.attenduni i.sex i.sexor_bin i.ethnic  

* Model 3: Adjusted for individual + family predisposing factors  
logistic MHSU_cons i.attenduni i.sex i.sexor_bin i.ethnic i.family_comp  

* Model 4: Adjusted Model 3 + Enabling factors  
logistic MHSU_cons i.attenduni i.sex i.sexor_bin i.ethnic i.family_comp i.edmum_bin i.IMDscore00_g  

* Model 5: Adjusted Model 4 + Need factors  
logistic MHSU_cons i.attenduni i.sex i.sexor_bin i.ethnic i.family_comp i.edmum_bin i.IMDscore00_g i.SMFQ17_bin i.aut_bin i.dis_status  

************************************************************
*** Mental Health Services Use ***
************************************************************

* Model 1: Unadjusted  
logistic MHSU_MH i.attenduni  

* Model 2: Adjusted for individual predisposing factors  
logistic MHSU_MH i.attenduni i.sex i.sexor_bin i.ethnic  

* Model 3: Adjusted for individual + family predisposing factors  
logistic MHSU_MH i.attenduni i.sex i.sexor_bin i.ethnic i.family_comp  

* Model 4: Adjusted Model 3 + Enabling factors  
logistic MHSU_MH i.attenduni i.sex i.sexor_bin i.ethnic i.family_comp i.edmum_bin i.IMDscore00_g  

* Model 5: Adjusted Model 4 + Need factors  
logistic MHSU_MH i.attenduni i.sex i.sexor_bin i.ethnic i.family_comp i.edmum_bin i.IMDscore00_g i.SMFQ17_bin i.aut_bin i.dis_status  

************************************************************
*** Medication Use ***
************************************************************

* Model 1: Unadjusted  
logistic MHSU_meds i.attenduni  

* Model 2: Adjusted for individual predisposing factors  
logistic MHSU_meds i.attenduni i.sex i.sexor_bin i.ethnic  

* Model 3: Adjusted for individual and family predisposing factors  
logistic MHSU_meds i.attenduni i.sex i.sexor_bin i.ethnic i.family_comp  

* Model 4: Adjusted Model 3 + Enabling factors  
logistic MHSU_meds i.attenduni i.sex i.sexor_bin i.ethnic i.family_comp i.edmum_bin i.IMDscore00_g  

* Model 5: Adjusted Model 4 + Need factors  
logistic MHSU_meds i.attenduni i.sex i.sexor_bin i.ethnic i.family_comp i.edmum_bin i.IMDscore00_g i.SMFQ17_bin i.aut_bin i.dis_status  

************************************************************
*** Propensity Score Matching (PSM) Analysis ***
************************************************************

*** Step 1: Propensity Score Estimation & Matching ***

* Matching on characteristics: sex, sexual orientation, maternal education, SMFQ17 (mental health), and autism
* Caliper(0.02): Restricts matches to within 0.02 SD of the PS
* n(1): Nearest neighbour matching (1-to-1)
* logit: Uses logistic regression for PS estimation
* common: Keeps observations within common support
* Used ordinal sexual orientation and maternal education, and continuous SMFQ17 and autism variables instead of binary versions to maximize information for propensity score matching

psmatch2 i.attenduni i.sex_orient i.edmum SMFQ17 autism, out(MHSU24) caliper(0.02) n(1) logit common  

*** Step 2: Balance Check ***

* Check balance of covariates between treatment and control groups
* pstest checks standardized mean differences (SMD) between matched groups
* Ideally, SMD should be <0.10 for adequate balance

pstest i.sex i.sex_orient i.edmum SMFQ17 autism  

* Conduct t-tests to assess mean differences in university attendance (attenduni) by MHSU24 group  
* unequal: Allows for unequal variances between groups  
* if _weight!=. & _support==1: Ensures only matched observations in common support are used  

ttest attenduni, by(MHSU24) unequal if _weight!=. & _support==1  
ttest attenduni, by(MHSU24) unequal if _weight!=. & _support==1  

* Tabulate a categorical variable to assess balance with chi-square test
tabu attenduni sex, col chi if _weight!=. & _support==1  

*** Step 3: Visualization of Balance ***

* Plot distribution of propensity scores for both groups
psgraph  

* Kernel density plot comparing PS distributions
pstest _pscore, density both  

*** Step 4: Treatment Effect Estimation ***

* Logistic regression BEFORE applying PSM  
logistic MHSU24 i.attenduni  

* Logistic regression AFTER applying PSM (weighted by matched sample)  
logistic MHSU24 i.attenduni [fweight=_weight]  

************************************************************
*** General Practice Use (MHSU_GP) ***
************************************************************

* Repeat steps for General Practice use outcome
psmatch2 i.attenduni i.sex i.sex_orient i.edmum SMFQ17 autism, out(MHSU_GP) caliper(0.02) n(1) logit common  
pstest i.sex i.sex_orient i.edmum SMFQ17 autism  
ttest attenduni, by(MHSU_GP) unequal if _weight!=. & _support==1  
ttest attenduni, by(MHSU_GP) unequal if _weight!=. & _support==1  
tabu attenduni sex, col chi if _weight!=. & _support==1  
psgraph  
pstest _pscore, density both  
logistic MHSU_GP i.attenduni  
logistic MHSU_GP i.attenduni [fweight=_weight]  

************************************************************
*** Counselling Use (MHSU_cons) ***
************************************************************

psmatch2 i.attenduni i.sex i.sex_orient i.edmum SMFQ17 autism, out(MHSU_cons) caliper(0.02) n(1) logit common  
pstest i.sex i.sex_orient i.edmum SMFQ17 autism  
ttest attenduni, by(MHSU_cons) unequal if _weight!=. & _support==1  
ttest attenduni, by(MHSU_cons) unequal if _weight!=. & _support==1  
tabu attenduni sex, col chi if _weight!=. & _support==1  
psgraph  
pstest _pscore, density both  
logistic MHSU_cons i.attenduni  
logistic MHSU_cons i.attenduni [fweight=_weight]  

************************************************************
*** Mental Health Services Use (MHSU_MH) ***
************************************************************

psmatch2 i.attenduni i.sex i.sex_orient i.edmum SMFQ17 autism, out(MHSU_MH) caliper(0.02) n(1) logit common  
pstest i.sex i.sex_orient i.edmum SMFQ17 autism  
ttest attenduni, by(MHSU_MH) unequal if _weight!=. & _support==1  
ttest attenduni, by(MHSU_MH) unequal if _weight!=. & _support==1  
tabu attenduni sex, col chi if _weight!=. & _support==1  
psgraph  
pstest _pscore, density both  
logistic MHSU_MH i.attenduni  
logistic MHSU_MH i.attenduni [fweight=_weight]  

************************************************************
*** Medication Use (MHSU_meds) ***
************************************************************

psmatch2 i.attenduni i.sex i.sex_orient i.edmum SMFQ17 autism, out(MHSU_meds) caliper(0.02) n(1) logit common  
pstest i.sex i.sex_orient i.edmum SMFQ17 autism  
ttest attenduni, by(MHSU_meds) unequal if _weight!=. & _support==1  
ttest attenduni, by(MHSU_meds) unequal if _weight!=. & _support==1  
tabu attenduni sex, col chi if _weight!=. & _support==1  
psgraph  
pstest _pscore, density both  
logistic MHSU_meds i.attenduni  
logistic MHSU_meds i.attenduni [fweight=_weight]  

************************************************************
*** Interaction Effects in Logistic Regression ***
************************************************************

*** Sex Interaction ***

* Model 1: Logistic regression with interaction between university attendance and sex
logistic MHSU24 i.attenduni##i.sex

* Model 2: Adjusted model, controlling for need factors (SMFQ17_bin, aut_bin)
logistic MHSU24 i.attenduni##i.sex i.SMFQ17_bin i.aut_bin 

* Display estimated coefficients matrix (e(b) contains estimated coefficients)
matrix list e(b)

* Compute odds ratios (ORs) for different levels of interaction
* OR for attenduni = 1 when sex = 0
lincom _b[1.attenduni], or

* OR for attenduni = 1 when sex = 1
lincom _b[1.attenduni] + _b[1.attenduni#1.sex], or

* Compute marginal effects of university attendance by sex
margins i.attenduni##i.sex
marginsplot

************************************************************
*** Ethnicity Interaction ***
************************************************************

* Model 1: Interaction between university attendance and ethnicity
logistic MHSU24 i.attenduni##i.ethnic 

* Model 2: Adjusted model, controlling for need factors (SMFQ17_bin, aut_bin)
logistic MHSU24 i.attenduni##i.ethnic i.SMFQ17_bin i.aut_bin

* OR for attenduni = 1 when ethnicity = 0
lincom _b[1.attenduni], or

* OR for attenduni = 1 when ethnicity = 1
lincom _b[1.attenduni] + _b[1.attenduni#1.ethnic], or

* Compute marginal effects of university attendance by ethnicity
margins i.attenduni##i.ethnic
marginsplot

************************************************************
*** Sexual Orientation Interaction ***
************************************************************

* Model 1: Interaction between university attendance and sexual orientation
logistic MHSU24 i.attenduni##i.sexor_bin

* Model 2: Adjusted model, controlling for need factors (SMFQ17_bin, aut_bin)
logistic MHSU24 i.attenduni##i.sexor_bin i.SMFQ17_bin i.aut_bin

* OR for attenduni = 1 when sexual orientation = 0
lincom _b[1.attenduni], or

* OR for attenduni = 1 when sexual orientation = 1
lincom _b[1.attenduni] + _b[1.attenduni#1.sexor_bin], or

* Compute marginal effects of university attendance by sexual orientation
margins i.attenduni##i.sexor_bin
marginsplot

************************************************************
*** Maternal Education Interaction ***
************************************************************

* Model 1: Interaction between university attendance and maternal education
logistic MHSU24 i.attenduni##i.edmum_bin

* Model 2: Adjusted model, controlling for sex and need factors (SMFQ17_bin, aut_bin)
logistic MHSU24 i.attenduni##i.edmum_bin i.SMFQ17_bin i.aut_bin

* OR for attenduni = 1 when maternal education = 0
lincom _b[1.attenduni], or

* OR for attenduni = 1 when maternal education = 1
lincom _b[1.attenduni] + _b[1.attenduni#1.edmum_bin], or

* Compute marginal effects of university attendance by maternal education
margins i.attenduni##i.edmum_bin
marginsplot

*** Peer review request: We want to observe any differences in the association between MHSU and university attendance in those with likely depression as a sensitivity analysis. 

* SMFQ - likely depression
logistic MHSU24 i.attenduni if SMFQ17_bin ==1

************************************************************
*** Multiple Imputation (MI) - Logistic Regression ***
************************************************************

* Any Health Service Use for Mental Health (MHSU24)
mi estimate, or: logistic MHSU24 i.attenduni i.sex i.sexuality_bin i.ethnic 
mi estimate, or: logistic MHSU24 i.attenduni i.sex i.sexuality_bin i.ethnic i.family_comp
mi estimate, or: logistic MHSU24 i.attenduni i.sex i.sexuality_bin i.ethnic i.family_comp i.edmum_at_g_BIN i.IMDscore00_g
mi estimate, or: logistic MHSU24 i.attenduni i.sex i.sexuality_bin i.ethnic i.family_comp i.edmum_at_g_BIN i.IMDscore00_g i.SMFQ_at_17_BIN i.aut_bin2 i.dis_status

************************************************************
*** General Practice Use for Mental Health (MHSU_GP) ***
************************************************************

mi estimate, or: logistic MHSU_GP i.attenduni
mi estimate, or: logistic MHSU_GP i.attenduni i.sex i.sexuality_bin i.ethnic 
mi estimate, or: logistic MHSU_GP i.attenduni i.sex i.sexuality_bin i.ethnic i.family_comp
mi estimate, or: logistic MHSU_GP i.attenduni i.sex i.sexuality_bin i.ethnic i.family_comp i.edmum_at_g_BIN i.IMDscore00_g
mi estimate, or: logistic MHSU_GP i.attenduni i.sex i.sexuality_bin i.ethnic i.family_comp i.edmum_at_g_BIN i.IMDscore00_g i.SMFQ_at_17_BIN i.aut_bin2 i.dis_status

************************************************************
*** Counseling Service Use (MHSU_cons) ***
************************************************************

mi estimate, or: logistic MHSU_cons i.attenduni
mi estimate, or: logistic MHSU_cons i.attenduni i.sex i.sexuality_bin i.ethnic 
mi estimate, or: logistic MHSU_cons i.attenduni i.sex i.sexuality_bin i.ethnic i.family_comp
mi estimate, or: logistic MHSU_cons i.attenduni i.sex i.sexuality_bin i.ethnic i.family_comp i.edmum_at_g_BIN i.IMDscore00_g
mi estimate, or: logistic MHSU_cons i.attenduni i.sex i.sexuality_bin i.ethnic i.family_comp i.edmum_at_g_BIN i.IMDscore00_g i.SMFQ_at_17_BIN i.aut_bin2 i.dis_status

************************************************************
*** Mental Health Service Use (MHSU_MH) ***
************************************************************

mi estimate, or: logistic MHSU_MH i.attenduni
mi estimate, or: logistic MHSU_MH i.attenduni i.sex i.sexuality_bin i.ethnic 
mi estimate, or: logistic MHSU_MH i.attenduni i.sex i.sexuality_bin i.ethnic i.family_comp
mi estimate, or: logistic MHSU_MH i.attenduni i.sex i.sexuality_bin i.ethnic i.family_comp i.edmum_at_g_BIN i.IMDscore00_g
mi estimate, or: logistic MHSU_MH i.attenduni i.sex i.sexuality_bin i.ethnic i.family_comp i.edmum_at_g_BIN i.IMDscore00_g i.SMFQ_at_17_BIN i.aut_bin2 i.dis_status

************************************************************
*** Medication Use for Mental Health (MHSU_meds) ***
************************************************************

mi estimate, or: logistic MHSU_meds i.attenduni
mi estimate, or: logistic MHSU_meds i.attenduni i.sex i.sexuality_bin i.ethnic 
mi estimate, or: logistic MHSU_meds i.attenduni i.sex i.sexuality_bin i.ethnic i.family_comp
mi estimate, or: logistic MHSU_meds i.attenduni i.sex i.sexuality_bin i.ethnic i.family_comp i.edmum_at_g_BIN i.IMDscore00_g
mi estimate, or: logistic MHSU_meds i.attenduni i.sex i.sexuality_bin i.ethnic i.family_comp i.edmum_at_g_BIN i.IMDscore00_g i.SMFQ_at_17_BIN i.aut_bin2 i.dis_status

************************************************************
*** Interaction Effects with MI Estimates ***
************************************************************

*** Sex & University Attendance Interaction ***
mi estimate (_b[1.attenduni]), or: logistic MHSU24 i.attenduni##i.sex 
mi estimate (_b[1.attenduni] + _b[1.attenduni#1.sex]), or: logistic MHSU24 i.attenduni##i.sex 
mi estimate (_b[1.attenduni]), or: logistic MHSU24 i.attenduni##i.sex i.SMFQ_at_17_BIN i.aut_bin2
mi estimate (_b[1.attenduni] + _b[1.attenduni#1.sex]), or: logistic MHSU24 i.attenduni##i.sex i.SMFQ_at_17_BIN i.aut_bin2
* Compute Odds Ratios (ORs)
di exp()

*** Sexual Orientation & University Attendance Interaction ***
mi estimate (_b[1.attenduni]), or: logistic MHSU24 i.attenduni##i.sexuality_bin
mi estimate (_b[1.attenduni] + _b[1.attenduni#1.sexuality_bin]), or: logistic MHSU24 i.attenduni##i.sexuality_bin
mi estimate (_b[1.attenduni]), or: logistic MHSU24 i.attenduni##i.sexuality_bin i.SMFQ_at_17_BIN i.aut_bin2
mi estimate (_b[1.attenduni] + _b[1.attenduni#1.sexuality_bin]), or: logistic MHSU24 i.attenduni##i.sexuality_bin i.SMFQ_at_17_BIN i.aut_bin2
di exp()

*** Ethnicity & University Attendance Interaction ***
mi estimate (_b[1.attenduni]), or: logistic MHSU24 i.attenduni##i.ethnic
mi estimate (_b[1.attenduni] + _b[1.attenduni#1.ethnic]), or: logistic MHSU24 i.attenduni##i.ethnic
mi estimate (_b[1.attenduni]), or: logistic MHSU24 i.attenduni##i.ethnic i.SMFQ_at_17_BIN i.aut_bin2
mi estimate (_b[1.attenduni] + _b[1.attenduni#1.ethnic]), or: logistic MHSU24 i.attenduni##i.ethnic i.SMFQ_at_17_BIN i.aut_bin2
di exp()

*** Maternal Education & University Attendance Interaction ***
mi estimate (_b[1.attenduni]), or: logistic MHSU24 i.attenduni##i.edmum_at_g_BIN
mi estimate (_b[1.attenduni] + _b[1.attenduni#1.edmum_at_g_BIN]), or: logistic MHSU24 i.attenduni##i.edmum_at_g_BIN
mi estimate (_b[1.attenduni]), or: logistic MHSU24 i.attenduni##i.edmum_at_g_BIN i.SMFQ_at_17_BIN i.aut_bin2
mi estimate (_b[1.attenduni] + _b[1.attenduni#1.edmum_at_g_BIN]), or: logistic MHSU24 i.attenduni##i.edmum_at_g_BIN i.SMFQ_at_17_BIN i.aut_bin2
di exp()
