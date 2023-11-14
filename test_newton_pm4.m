standard_err_value = 1e-7;
errf = standard_err_value ;
errDeltax = standard_err_value ;
relDeltax = standard_err_value ;
eval_f = 'eval_f_LinearSystem';
N = 20;  %%play around  with amount of nodes 
[p,x_start,t_start,t_stop,max_dt_FE] = getParam_HeatBar(N);
% x0 = sparse(zeros(N,1)); %%% ALso have to play 
x0 = x_start; 
% visualize = 1;
u=1;
FiniteDifference = 1;
eval_Jf = 'eval_Jf_FiniteDifference';
MaxIter = 10; 
[x,converged,errf_k,errDeltax_k,relDeltax_k,iterations,X] = NewtonNd(eval_f,x0,p,u,errf,errDeltax,relDeltax,MaxIter,visualize,FiniteDifference,eval_Jf);
disp(converged);
disp(x); 
disp(errf_k);
disp(errDeltax_k);
disp(relDeltax_k);
% disp(iterations);

% test_newton_pm4 ---> getParam_heatbar(for p.B and change the ambient temperature  ---> eval_f_LinearSystem(for p.A)