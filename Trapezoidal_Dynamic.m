function [X,t] = Trapezoidal_Dynamic(eval_f,x_start,p,eval_u,t_start,t_stop,timestep,visualize)
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
errf = 1e-10;
errDeltax = 1e-8;
relDeltax = Inf;
MaxIter = 50;
FiniteDifference = 1;
eval_Jf = 'eval_jf_trapezoid';
current_time = t(1);
dt = timestep;
u_prev = feval(eval_u, t(1));
f_prev = feval(eval_f, X(:,end), p, u_prev);
while current_time < t_stop
    if current_time + dt > t_stop
        current_time = t_stop;
    else
        current_time = current_time + dt;
    end
    % disp(current_time)
   u  = feval(eval_u, current_time);
   f  = feval(eval_f, X(:,end), p, u);
   fe_step = X(:,end) + dt*f_prev;
   p.gamma = X(:,end) + dt/2*f_prev;
   [converged_val,converged,~,~,~,iterations,~] = NewtonNd(eval_t,fe_step,p,u,errf,errDeltax,relDeltax,MaxIter,visualize,FiniteDifference,eval_Jf);
   Jf        = eval_Jf_FiniteDifference(eval_f,converged_val,p,u);
   max_slope = max(max(Jf));
   min_slope = min(min(Jf));
if (converged == 0 || iterations > 4 )|| norm(converged_val - X(:,end), Inf)/dt > max_slope
current_time = current_time - dt;
% disp('decreased triggered')
% t(end) = current_time;
dt = dt/2;
elseif norm(converged_val - X(:,end), Inf)/dt < min_slope
current_time = current_time - dt;
dt = dt * 1.2;
% disp('increased triggered')
% t(end) = current_time;
else
X(:, end + 1) = converged_val;
t(end+1) = current_time;
f_prev = f;
u_prev = u;
end
end
end