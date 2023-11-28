function [X,t] = Trapezoidal_Dynamic(eval_f,x_start,p,eval_u,t_start,t_stop,timestep,visualize, counter_set)
% uses Forward Euler to simulate states model dx/dt=f(x,p,u)
% startin from state vector x_start at time t_start
% until time t_stop, with time intervals timestep
% eval_f is a text string defining the name of the function that evaluates f(x,p,u)
% eval_u is a text string defining the name of the funciton that evaluates u(t)
% visualize ~= 0 is an optional parameter triggering the generation of intermediate plots of the state
% 
% EXAMPLE
% [X,t] = ForwardEuler(eval_f,x_start,p,eval_u,t_start,t_stop,timestep,visualize);


X(:,1) = x_start;
t(1)   = t_start;
p.eval_f = eval_f;
p.delta_t = timestep;
eval_t = 'eval_f_trapezoid';
errf = 1e-4;
errDeltax = 1e-4;
relDeltax = Inf;
MaxIter = 50;
FiniteDifference = 1;
eval_Jf = 'eval_jf_trapezoid';
current_time = 0;
dt = timestep;
counter = counter_set;
while current_time < t_stop
    % dt
u        = feval(eval_u, t(end));
if counter == counter_set
[f,dt]  = feval('eval_f_LinearSystem_trap', X(:,end), p, u);
dt = dt/20;
        % lambda = eig(p.A);
 % fastest_eigenvalue = max(abs(lambda)); 
 % % usually Forward Euler is unstable for timestep>2/fastest_eigenvalue
 % dt = 1/fastest_eigenvalue;
 counter = 1;
else
   f  = feval(eval_f, X(:,end), p, u);
end
   current_time =  current_time + dt;
   t(end+1)   = t(end) + dt;
   p.gamma = X(:,end) + dt/2*f;
   X(:,end+1) = NewtonNd(eval_t,X(:,end) +  40* dt * f,p,u,errf,errDeltax,relDeltax,MaxIter,visualize,FiniteDifference,eval_Jf);
    counter = counter + 1;
end