function [p,x_start,t_start,t_stop,max_dt_FE] = getParam_HeatBar(N,L);
% Defines the parameters for vector field f(x,p,u) = p.A x+ p.B u


% REGRESSION TESTS 
%No sources 
heat_source = 0; 
ambient_temperature = 0.0;
p.electronic_mean_free = .2; 
p.phonon_mean_free = .2;
t_stop = .25

% REGRESSION TESTS (1)
heat_source = 1; 
ambient_temperature = 10.0;
p.electronic_mean_free = .2; 
p.phonon_mean_free = .2;
t_stop = .70


% REGRESSION TESTS (2)
% heat_source = 1; 
% ambient_temperature = 10.0;
% p.electronic_mean_free = .2; 
% p.phonon_mean_free = 1;
% t_stop = .70


%REGRESSION TESTS (3)
heat_source = 1; 
ambient_temperature = 10.0;
p.electronic_mean_free = 1; 
p.phonon_mean_free = .2;
t_stop = .70

%REGRESSION TESTS (4)
heat_source = 1; 
ambient_temperature = 20.0;
p.electronic_mean_free = .2; 
p.phonon_mean_free = .2;
t_stop = .70

%FAILURE (5) 
heat_source = 1; 
ambient_temperature = 20.0;
p.electronic_mean_free = 2; 
p.phonon_mean_free = 20;
t_stop = .70



%RUN JACOBIAN AFTER THIS  (1) Control 
heat_source = 1; 
ambient_temperature = 10.0;
t_stop = 1;
p.electronic_mean_free = .2; 
p.phonon_mean_free = .2;
% %(2) Changed the phonon mean free path right now
% %Run Jacobian see difference between phonon mean free
% %This makes sense because right now temperature is very low and so there is
% %a larger T dependence as the phonon mean free is T^3 dependence 
heat_source = 1; 
ambient_temperature = 10.0;
t_stop = 1;
p.electronic_mean_free = .2; 
p.phonon_mean_free = 1;

% % (3) Run Jacobian see difference between electronic mean free path
% %now changing the electronic mean free path means a much greater increase
% %than the one before. 
heat_source = 1; 
ambient_temperature = 10.0;
t_stop = 1;
p.electronic_mean_free = 1; 
p.phonon_mean_free = .2;
% 
% %RUN JACOBIAN AFTER THIS  (4)
% %notice jacobian smaller, change in ambient means change in the starting
% %position of temperatures 
% heat_source = 1; 
% ambient_temperature = 1.0;
% t_stop = 1;
% p.electronic_mean_free = .2; 
% p.phonon_mean_free = .2;
% 
% %RUN JACOBIAN AFTER THIS  (5)
%notice jacobian smaller, change in ambient means change in the starting
%position of temperatures 
heat_source = 1; 
ambient_temperature = 20.0;
t_stop = 1;
p.electronic_mean_free = .2; 
p.phonon_mean_free = .2;



% corresponding to a 1D hear conducting bar problem
% the full state space model equations are dx/dt = f(x,p,u) where
% x is the state vector of the system
% u is the vector of inputs to the system
% p is a structure containing all model parameters  
% Since f(x,p,u) is a linear vector field it is more efficient 
% to precompute here only once matrices p.A and p.A 
% and the use the generic functions eval_f_LinearSystem eval_Jf_LinearSystem
% every time an evaluation of f(x,p.u) and its Jacobian will be needed
% 
% INPUT:
% N          the number of discretization nodes/states/unknowns along the bar
%            including the two terminal nodes 
% L          [optional] total lenght of the bar, if not specified L=1 is used
%
% OUPUTS:
% p.gamma    coef. related to thermal capacitance per unit length of the bar
% p.km       thermal conductance through metal per unit length of the bar
% p.ka       thermal conductance to air per unit length of the bar
% p.dz       leanth of each bar section
% p.A        dynamical matrix of the state space system (Laplacian discretization)
% p.B        input matrix (one column for each input) in this case single input on the left
% x_start    if needed for typical transient simulations
% x_stop     if needed for typical transient simulations
% max_dt_FE  useful if using Forward Euler for transient simulations
%
% EXAMPLE:
% [p,x_start,t_start,t_stop,max_dt_FE] = getParam_HeatBar(N);

% define material properties parameters
p.N = N;
p.gamma = 0.1; %related to thermal capacitance per unit length of the bar
p.km    = 0.1; %related to thermal conductance through metal per unit length of the bar
p.ka    = 0.1; %replace with kapitza 
if ~exist('L','var')
   L=1;
end
p.dz   = L/(N-1); % length of each segment. N includes the two terminal nodes
                  % notice when changing N what stays constant is the total length L
                  % not the length of each discretization section.
                  % results should not depend on the number of sections
                  % for a large enough number of sections
p.Cstore = p.gamma  * p.dz; %the longer the section the larger the thermal storage
Rc     = (1/p.km) * p.dz; %the longer the section the larger the thermal resistance
Rloss  = (1/p.ka) / p.dz; %the longer the section the larger the thermal leakage
                          %hence the smaller the thermal resistance to ambient
% p.A    = spalloc(N,N,3*N);%allocate space for large sparse dynamic matrix in advance
% % coupling resistors Rc between i and j=i+1
% for i = 1:N-1,
%    j=i+1;
%    p.A(i,i) = p.A(i,i)+(+1/Rc);
%    p.A(i,j) = p.A(i,j)+(-1/Rc);
%    p.A(j,i) = p.A(j,i)+(-1/Rc);
%    p.A(j,j) = p.A(j,j)+(+1/Rc);
% end
% leakage resistor Rloss between i and ground
p.B     = sparse(zeros(N,1));  %makes sure all elements are sparse 
Ia  = p.ka * p.dz * ambient_temperature ;%ambient air
for i = 1:N,
   p.B(i,1) = p.B(i,1) + Ia;
  % p.A(i,i) = p.A(i,i) + 1/Rloss;
end

                               %otherwise matlab will convert them to full when adding
p.B(1,1)=  heat_source;		     % heat source at the leftmost side of the bar

                       % otherwise the system is completely unstable
p.B     = p.B/p.Cstore;  % note this is important to make sure results
                       % will not depend on the number of sections N
                       

% define also some example parameters for a typical transient simulation                       
x_start = sparse(zeros(N,1)); 
for i = 1:N, 
    x_start(i,1) = x_start(i,1) + ambient_temperature/1000; 
end
t_start = 0;

% lambda = eig(p.A);
% slowest_eigenvalue = min(abs(lambda));
% fastest_eigenvalue = max(abs(lambda));

% to see steady state need to wait until the slowest mode settles
% t_stop = (slowest_eigenvalue*2);    %use this to wait until slowest mode
 
% usually Forward Euler is unstable for timestep>2/fastest_eigenvalue
% max_dt_FE = 1/fastest_eigenvalue;
max_dt_FE = .0005