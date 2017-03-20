% Outputs for three values of E (put the closest one to 0 in citydef) and
% for three values of city.ben (put the smallest in citydef)

%% reading London IRAS results
xtab = xlsread('IRASresults.xlsx','Results');
l = size(x,1);

% array with urban consumption and flow, env demand and flow. Consumptions
% expressed as fractions of demand requirements.
x = xtab(:,[8 6 12 11]);

% outputs for 9 scenarios
cu = zeros(l,9); % urban consumptions (fraction)
pu = zeros(l,9); % urban prices
ce = zeros(l,9); % env consumptions (fraction)
pe = zeros(l,9); % env prices

%% Parameters
london.p = 2.05; % 1.2629+0.7943; % base residential price (£/m3)
london.target = 9.259; % environmental target ((m3.s^-1).week)
london.ben = 2.5E8; % environmental and other cross-sector benefits (£/year) 
london.E = -.3; % Price elasticity of demand
london.dc = 1; % demand curve bu point expansion method (1 constant E, 2 constant slope)

baseben = london.ben; % initialize env valuation

count = 0; % keeping track of the number of scenarios explored

%% Scarcity pricing
for i = 1:3
    
    for j = 1:3
        count = count + 1;
        [cu(:,count),pu(:,count),ce(:,count),pe(:,count)] = ...
            dyn_scarcity_pricing(london,x,1);
        london.ben = london.ben + baseben; % change env valuation
    end
    
    london.E = london.E-0.1; % change elasticity
    london.ben = baseben; % reset env valuation
    
end

%% Writing outputs (comment if needed)
out = 'Scarcity.xlsx';
xlswrite(out,cu,'Urban_Cons')
xlswrite(out,ce,'Env_Cons')
xlswrite(out,pe,'Env_P') % Equivalent to plot "Env" or "Urban" prices

%% Plotting results (comment if needed)
plot_env_deficit(out) % average environmental flow deficit
plot_env(out,400) % stats for failure event under threshold in ML/day
plot_price(out,london.p,0.5) % plot stats for price increase events (e.g. above 50% increase)