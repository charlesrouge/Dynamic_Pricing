This folder contains the data for the analysis of scarcity pricing. It contains:


1) "IRASresults.xlsx": an Excel file that contains the results from the IRAS run, which are being preprocessed by Matlab routines

2) "MAIN.m"
THIS IS THE MAIN ROUTINE
Run it on Matlab and it uses all other routines to produce the Figure and the Tables from the paper


3) Other Matlab routine called in MAIN.m. They all are detailed through comments in the code but here's an overview:
	"dyn_scarcity_pricing.m" uses the method described in the Appendix of the paper to compute scarcity pricing results
	"plot_scarcity-event.m" outputs the Figure 7 from the paper
	"plot_env_deficit.m" produces average deficit metrics for the different scenarios (and can plot them if required)
	"plot_env.m" produces metrics for the environmental flow deficit EVENTS in the different scenarios (and can plot them if required)
	"plot_price.m" produces metrics for the price increase EVENTS in the different scenarios (and can plot them if required)
