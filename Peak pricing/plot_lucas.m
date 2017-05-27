% Reproduces the figure "Graph 3" from demrules.xlsx
% Charles Rouge 2017

x=xlsread('Peak_pricing.xlsx','Lucas2010');

figure
plot(x(:,1),x(:,3),'ok')
hold on
a=0:94;
b=0.0106*a.^2-1.51*a+100;
plot(a,b,'k')

xlabel('Reduction in peak demand (%)')
ylabel('Cost of mains expansion (base 100)')
set(gca,'Ylim',[0 100])
legend('Data from Lucas et al. (2010)','Quadratic regression (R^2=0.89)')