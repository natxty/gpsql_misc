s= """
ANTISEL Selidis Bros s.a.
li = list(set([i.strip() for i in s.split('\n') if i]))

s= """Al-Zahrawi Medical Services Co.

_li = list(set([i.strip() for i in s.split('\n') if i]))

for i in li:
	if i not in _li:
		print i
		
		
		
		
"""
# RESULTS FROM THE COMPARISON

INOCHEM S.A. de C.V.
Gen-Probe GTI Diagnostics, Inc.
Tree Med SDN, BHD
Metek Lab, Inc. # Same as above
Zhuhai Bioyamei Investment Co., Ltd.
Inno-Train Diagnostics Gmb # Similar to the above, just with no 'h'
Tae Yeong CnL
GTI Italia SRL # Same as above, just no '.' seperator
Mind Biomeds Pvt. Ltd.
Inter Medico
UNIPARTS, S.A.
Beijing Rose Co-Win Medical Tech. Co., Ltd.



Gen-Probe Fluoroanalyzer V
LIFECODES HLA Genotyping V
LIFECODES KIR Genotyping V 
LIFECODES Cytokine SNP Typing V
LIFECODES Red Cell Genotyping V
LIFECODES Screen & Identification  V
LIFECODES LSA Single Antigen V
LIFECODES Donor Specific Antibody -- Repeated
LIFECODES LSA MIC V
LIFECODES Serology Products  -- Missing
LIFECODES Platelet Antibody Detection Products -- Missing
LIFECODES HPA Genotyping -- Missing
LIFECODES Donor Screening -- Missing



"""