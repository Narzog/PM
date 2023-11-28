function [X,t] = Trapezoidal(eval_f,x_start,p,eval_u,t_start,t_stop,timestep,visualize)
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
if visualize
   VisualizeState(t,X,1,'.b');
end
p.eval_f = eval_f;
p.delta_t = timestep;
eval_t = 'eval_f_trapezoid';
errf = 1e-10;
errDeltax = 1e-8;
relDeltax = Inf;
MaxIter = 200;
FiniteDifference = 1;
eval_Jf = 'eval_jf_trapezoid';

for n = 1 : ceil((t_stop-t_start)/timestep)
   dt       = min(timestep, (t_stop-t(n)));
   t(n+1)   = t(n) + dt;
   u        = feval(eval_u, t(n));
   f        = feval(eval_f, X(:,n), p, u);
   p.gamma = X(:,n) + dt/2*f;
   X(:,n+1) = NewtonNd(eval_t,X(:,n),p,u,errf,errDeltax,relDeltax,MaxIter,visualize,FiniteDifference,eval_Jf);
   if visualize
      VisualizeState(t,X,n+1,'.b');
   end
end