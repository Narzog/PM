standard_err_value = 1e-1;
errf = standard_err_value ;
errDeltax = standard_err_value ;
relDeltax = standard_err_value ;
eval_f = 'eval_f_LinearSystem';
[p,x_start,t_start,t_stop,max_dt_FE] = getParam_HeatBar(10);
x0 = x_start;
% x0 = zeros(size(b));
visualize = 0;
u=0;
FiniteDifference = 1;
eval_Jf = 'eval_Jf_FiniteDifference';
MaxIter = 10000; 
[x,converged,errf_k,errDeltax_k,relDeltax_k,iterations,X] = NewtonNd(eval_f,x0,p,u,errf,errDeltax,relDeltax,MaxIter,visualize,FiniteDifference,eval_Jf);
disp(converged);
disp(x)

