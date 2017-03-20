function plot_price(file_name,p,p_increase)

x = xlsread(file_name,'Env_P')+p;
l = size(x,1);
c = size(x,2);

p_lim = p*(1+p_increase);

x = (x >= p_lim);

%% Frequency
y = zeros(3,3);
y(1,1:3) = sum(x(:,1:3));
y(2,1:3) = sum(x(:,4:6));
y(3,1:3) = sum(x(:,7:9));
y = y'/85;
figure
bar(y)
legend('E=-0.3','E=-0.4','E=-0.5')
xlabel('Environmental value (£M)')
ylabel('Frequency of occurrence (weeks/year)')
out = [...%'%Frequency of a ' 
    num2str(100*p_increase) '% urban price increase'];
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
%                 size(z)
%             else
%                 ev
%                 size(z,1)
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
figure
bar(rav)
legend('E=-0.3','E=-0.4','E=-0.5')
xlabel('Environmental value (£M)')
ylabel('Average duration (weeks)')
out = [...%'Average duration of ' 
    num2str(100*p_increase) ...
    '% urban price increase'];
title(out)
set(gca,'XTickLabel',[250 500 750])

% PLotting number of events
nev = [nbev(1:3:9); nbev(2:3:9); nbev(3:3:9)];
figure
bar(nev)
legend('E=-0.3','E=-0.4','E=-0.5')
xlabel('Environmental value (£M)')
ylabel('Number of events')
out = [...%'Number of ' 
    num2str(100*p_increase) ...
    '% urban price increase'];% events'];
title(out)
set(gca,'XTickLabel',[250 500 750])



