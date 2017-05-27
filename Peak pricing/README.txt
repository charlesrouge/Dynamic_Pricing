This folder contains the data for the analysis of peak pricing. It contains an Excel file that contains all the data, and
two Matlab routines used to plot the Figures obtained in the paper.

1) All the data on peak pricing, including sensitivity analysis, is available on "Peak_pricing.xlsx"

The sheets are as follows:
=> "param_ref_sensitivity" contains the parameters used for the analysis in the reference "Ref" scenario, along with the possibility to do sensitivity analysis
=> "Lucas2010" contains the data from Lucas et al. (2010) used in the paper
=> "rollout_ref" computes the number of smart meters for the "Ref" scenario
=> "benefits_ref" uses data from the previous 2 spreadsheets to compute savings form peak pricing for different price increases
=> "rollout_sensitivity" is the same as "rollout_ref" but for the sensitivity scenario
=> "benefits_sensitivity" is the same as "benefits_ref" but for the sensitivity scenario
=> "benefits_E=-0.3" is the same as "benefits_ref" but for E=-0.3, all other parameters are same as "Ref" scenario
=> "benefits_E=-0.5" is the same as "benefits_ref" but for E=-0.5, all other parameters are same as "Ref" scenario


2) The two Matlab routines use data from the spreadsheet and they are:
=> plot_lucas.m produces Figure 4 from the paper when called
=> plot_peak_pricing_benefits.m produces Figure 6 when called