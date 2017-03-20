% This plots the results for flows below a threshold value "min_env" in
% ML/day
%
% Charles Rouge, last modified 2017

function plot_env(file_name,min_env)

x = xlsread(file_name,'Env_Cons');
xrule = xlsread('IRASresults.xlsx','Results');
l = size(x,1);
c = size(x,2);

x = (x < min_env/800);

%% Statistics for rule-based
x(:,c+1) = (xrule(:,12) < min_env/800);
c = c+1;

%% Frequency
y = zeros(3,3);
y(1,1:3) = sum(x(:,1:3));
y(2,1:3) = sum(x(:,4:6));
y(3,1:3) = sum(x(:,7:9));
y = y'/85;
figure
bar(y)
hold on
plot(0:4,sum(x(:,c))/85*ones(1,5),'r','LineWidth',2)
set(gca,'Xlim',[.5 3.5])
legend('E=-0.3','E=-0.4','E=-0.5','Rule-based')
xlabel('Environmental value (£M)')
ylabel('Frequency of occurrence (weeks/year)')
out = ['Environmental flow under ' num2str(min_env) 'ML/day'];
title(out)
set(gca,'XTickLabel',[250 500 750])

%% Resilience
z = [];
for i = 1:c
    ev = 0;
    t = 1;
    while t <= l
        if x(t,i) == 1
            ev = ev + 1;
            if ev > size(z,1)
                z = [z; zeros(1,c)];
            end
            while x(t,i) == 1 && t <= l
                z(ev,i) = z(ev,i)+1;
                t = t+1;
            end
        end
        t = t+1;
    end
end

nbev = sum((z>0)); % number of events

% Plotting average resilience
rav = zeros(3,3);
rav(1,1:3) = sum(z(:,1:3:9))./nbev(1:3:9);
rav(2,1:3) = sum(z(:,2:3:9))./nbev(2:3:9);
rav(3,1:3) = sum(z(:,3:3:9))./nbev(3:3:9);
rrb = sum(z(:,10))/nbev(10);
figure
bar(rav)
hold on
plot(0:4,rrb*ones(1,5),'r','LineWidth',2)
set(gca,'Xlim',[.5 3.5])
legend('E=-0.3','E=-0.4','E=-0.5','Rule-based')
xlabel('Environmental value (£M)')
ylabel('Average duration (weeks)')
out = ['Environmental flow under ' num2str(min_env) 'ML/day'];
title(out)
set(gca,'XTickLabel',[250 500 750])

% PLotting number of events
nev = [nbev(1:3:9); nbev(2:3:9); nbev(3:3:9)];
figure
bar(nev)
hold on
plot(0:4,nbev(10)*ones(1,5),'r','LineWidth',2)
set(gca,'Xlim',[.5 3.5])
legend('E=-0.3','E=-0.4','E=-0.5','Rule-based')
xlabel('Environmental value (£M)')
ylabel('Number of events')
out = ['Environmental flow under ' num2str(min_env) 'ML/day'];
title(out)
set(gca,'XTickLabel',[250 500 750])



