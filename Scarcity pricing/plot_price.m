% Computes the statistics of price increase from the file 'filename'
% where scarcity outputs are stored, baseline urban price 'p', and a target
% price increase 'p_increase', expressed as % increase.
%
% Binary option "toplot": there is no plot if it is 0 or if argument 
% omitted
% 
% Charles Rouge, 2017


function [freq,no_ev,res] = plot_price(file_name,p,p_increase,toplot)

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
freq = [y(1,1:3), y(2,1:3), y(3,1:3)];

if nargin == 4 && toplot 
    figure
    bar(y)
    legend('E=-0.3','E=-0.4','E=-0.5')
    xlabel('Environmental value (£M)')
    ylabel('Frequency of occurrence (weeks/year)')
    out = [...%'%Frequency of a ' 
        num2str(100*p_increase) '% urban price increase'];
    title(out)
    set(gca,'XTickLabel',[250 500 750])
end

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
res = [rav(1,1:3), rav(2,1:3), rav(3,1:3)];

if nargin == 4 && toplot 
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
end

%% PLotting number of events
nev = [nbev(1:3:9); nbev(2:3:9); nbev(3:3:9)];
no_ev = [nbev(1:3:9), nbev(2:3:9), nbev(3:3:9)];

if nargin == 4 && toplot 
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
end



