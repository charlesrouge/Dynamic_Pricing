x = xlsread('IRASresults.xlsx','Results');
yo = xlsread('Scarcity.xlsx','Env_P');
zo = xlsread('Scarcity.xlsx','Env_Cons');

deb = 1201;
fin = 1308;

% days
da=x(deb+2:fin+2,1)-8400;

% Residential price
y = yo(deb:fin,4:6);

% Environmental flow
z = zo(deb:fin,4:6);
zb = x(deb:fin,10);

figure
subplot(1,2,1)
hold on
plot(da,y(:,1)/london.p*100,'k','LineWidth',1.5)
plot(da,y(:,2)/london.p*100,'r','LineWidth',1.5)
plot(da,y(:,3)/london.p*100,'--k','LineWidth',1.5)
xlabel('Time (Months)')
ylabel('Price increase (%)')
title('Dynamic urban price')
set(gca,'Xlim',[1 730])
set(gca,'XTick',[1 32 60 91 121 152 182 213 244 274 305 335 366 397 425 ...
    456 496 527 557 588 619 649 680 710],'XTickLabel', {'J','F','M','A',...
    'M','J','J','A','S','O','N','D','J','F','M','A','M','J','J','A','S',...
    'O','N','D'})

subplot(1,2,2)
hold on
plot(da,800*(1-zb),'b','LineWidth',2)
plot(da,800*(1-z(:,1)),'k','LineWidth',1.5)
plot(da,800*(1-z(:,2)),'r','LineWidth',1.5)
plot(da,800*(1-z(:,3)),'--k','LineWidth',1.5)
xlabel('Time (Months)')
ylabel('Shortage (ML/day)')
title('Environmental shortage')%out)
legend('Rule-based allocation','Scarcity pricing (£250M)','Scarcity pricing (£500M)','Scarcity pricing (£750M)')
set(gca,'Xlim',[1 730])
set(gca,'XTick',[1 32 60 91 121 152 182 213 244 274 305 335 366 397 425 ...
    456 496 527 557 588 619 649 680 710],'XTickLabel', {'J','F','M','A',...
    'M','J','J','A','S','O','N','D','J','F','M','A','M','J','J','A','S',...
    'O','N','D'})