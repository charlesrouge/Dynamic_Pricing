% Figure for peak pricing, Charles Rouge, 2017

% Reading excel files
x4 = xlsread('Peak_pricing.xlsx','benefits_ref');
x3 = xlsread('Peak_pricing.xlsx','benefits_E=-0.3');
x5 = xlsread('Peak_pricing.xlsx','benefits_E=-0.5');

% PLotting results
figure
subplot(1,2,1)
hold on
plot(x3(:,1),x3(:,2),'r','LineWidth',1.5)
plot(x4(:,1),x4(:,2),'b','LineWidth',1.5)
plot(x5(:,1),x5(:,2),'k','LineWidth',1.5)
xlabel('Peak-hour price increase (%)')
ylabel('Use reduction (%)')
title('a) Demand response')
legend('E=-0.3','E=-0.4','E=-0.5')
set(gca,'Xlim',[0 300])

subplot(1,2,2)
hold on
plot(x3(:,1),x3(:,6),'r','LineWidth',1.5)
plot(x3(:,1),x3(:,4),'--r','LineWidth',1.5)
plot(x4(:,1),x4(:,6),'b','LineWidth',1.5)
plot(x4(:,1),x4(:,4),'--b','LineWidth',1.5)
plot(x5(:,1),x5(:,6),'k','LineWidth',1.5)
plot(x5(:,1),x5(:,4),'--k','LineWidth',1.5)
xlabel('Peak-hour price increase (%)')
ylabel('Operational savings (M£)')
title('b) Network-related benefits')
set(gca,'Xlim',[0 300],'Ylim',[0 1000])
legend('Total, E=-0.3','Mains expansion, E=-0.3','Total, E=-0.4',...
    'Mains expansion, E=-0.4','Total, E=-0.5','Mains expansion, E=-0.5')