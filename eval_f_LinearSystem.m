function f = eval_f_linearSystem(x,p,u)
% evaluates the vector field f(x,p,u) 
% at state vector x, and with vector of inputs u.
% p is a structure containing all model parameters
% i.e. in this case: matrices p.A and p.B 
% corresponding to state space model dx/dt = p.A x + p.B u
%
% f = eval_f_linearSystem(x,p,u)
N = p.N;
p.A    = spalloc(N,N,3*N);%allocate space for large sparse dynamic matrix in advance
% coupling resistors Rc between i and j=i+1


for i = 1:N-1,
   j=i+1;
   k_nicr = p.electronic_mean_free * x(i, 1) + p.phonon_mean_free * x(i, 1)^3;
   %k_nicr = p.electronic_mean_free * x(i, 1);
 
   Rc     = (1/k_nicr) * p.dz; %the longer the section the larger the thermal resistance
   p.A(i,i) = p.A(i,i)+(+1/Rc);
   p.A(i,j) = p.A(i,j)+(-1/Rc);
   p.A(j,i) = p.A(j,i)+(-1/Rc);
   p.A(j,j) = p.A(j,j)+(+1/Rc);
end
Rloss = (1/p.ka) / p.dz;
for i = 1:N,
   p.A(i,i) = p.A(i,i) + 1/Rloss;
end

p.A     = -p.A/p.Cstore; % note this will result in a 1/p.dz^2 term in A
                       % also pay attention to the negative sign

lambda = eig(p.A);
% slowest_eigenvalue = min(abs(lambda));
fastest_eigenvalue = max(abs(lambda));

% t_stop = (slowest_eigenvalue*2);    %use this to wait until slowest mode

max_dt_FE = 1/fastest_eigenvalue;

f = p.A * x + p.B * u;
end