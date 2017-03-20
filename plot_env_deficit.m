% This plots the average environmental deficit
%
% Charles Rouge, last modified 2017

function plot_env_deficit(file_name)

x = xlsread(file_name,'Env_Cons');
xrule = xlsread('IRASresults.xlsx','Results');
in = xrule(:,12);
c = size(x,2);

flow = 800; % minimum requirement in ML/day

%% Deficit statistics 
is_def = (in<0.99);
sim_def = flow*sum((1-in).*is_def)/sum(is_def); % rule-based
y = flow*sum((1-x).*repmat(is_def,1,c))/sum(is_def); % optimized

%% Plot average environmental deficit
env_d = [y(1:3:9); y(2:3:9); y(3:3:9)];
figure
bar(env_d)
hold on
plot(0:4,sim_def*ones(1,5),'r','LineWidth',2)
legend('E=-0.3','E=-0.4','E=-0.5','Rule-based')
xlabel('Environmental value (£M)')
ylabel('Average deficit (ML/day)')
set(gca,'Xlim',[.5 3.5])
set(gca,'XTickLabel',[250 500 750])
