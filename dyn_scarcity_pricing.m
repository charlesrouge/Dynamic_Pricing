% Dichotomic routine to find the efficient price
%
% Charles ROUGE, 2017

function [cu,pu,ce,pe] = dyn_scarcity_pricing(city,x,show)

p0 = city.p;
E = city.E;
target = city.target;

% potential weekly environmental benefits
touben = city.ben/(365.25/7);

%% Initialize algorithm

% Consumptions and flows
cu = x(:,1); % urban consumptions (fraction of demand)
fu = x(:,2); % urban flows
ce = x(:,3); % env consumptions (fraction of demand)
fe = x(:,4); % env flows

% Initial quantities
aw = fu+fe; % amount of water to allocate (unchanging)
cui = cu;
fui = fu;

% Prices
pu = p0.*cu.^(1/E); % inital urban price
pe = 2/(target*86400*7)*touben*(1-ce); % inital env price

% Compute minimal possible urban price (if env disregarded)
pumin = p0.*min(1,(aw.*cu./fu)).^(1/E);
% Corresponding maximal env price
pemax = 2/(target*86400*7)*touben; 


%% Main loop to get same marginal price for urban and other uses
diff = max(abs((pu-p0)-pe)); % initialize maximal amount by which price can be changed
cc = 0; % iteration count

while diff > 1E-5 && cc < 1000
    
    %% Choosing the price update that maximizes urban price
    
    % Case 1: update urban price
    pu_int_1 = max(pumin,p0+(pe+(pu-p0))/2);
    
    % CAse 2: update env price
    pe_int = min(pemax,(pe+(pu-p0))/2);
    ce_int = 1-pe_int*target*86400*7/2/touben;
    fe_int = ce_int*target; % Lower bound
    fu_int = aw - fe_int;
    cu_int = min(1,cui.*fu_int./fui);
    pu_int_2 = p0.*cu_int.^(1/E);
    
    pu = max(pu_int_1,pu_int_2);
    
    %% Update everything
    % update urban consumption and flow
    cu = (pu/p0).^E;
    fu = fui.*cu./cui;
    
    % update environmental flow and consumption
    fe =  aw - fu;
    ce = min(fe/target,1);
    
    % update environmental price
    pe = 2/(target*86400*7)*touben*(1-ce);
    
    % update stopping criteria
    diff = max(max(abs((pu-p0)-pe).*(ce > 1E-10).*(cu > 1E-10)));
    cc = cc+1;
    
end

if nargin == 3 && show
    disp(['E = ' num2str(E)])
    disp(['Annual environmental benefits = £' num2str(city.ben/1E6) 'M'])
    disp(['  Number of iterations: ' num2str(cc)])
end
