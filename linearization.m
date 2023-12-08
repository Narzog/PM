clear all;
close all;
N=100;
u        = 1;
eval_f = "eval_f_LinearSystem";
[p,x_start,t_start,t_stop,max_dt_FE] = getParam_HeatBar(N, 1000);
eval_func = eval_f_LinearSystem(x_start,p,u);
% eval_f_LinearSystem(x_start,p,u); 
linearized_function = linearization_function(x0,p,u);
% disp(linearized_function )
