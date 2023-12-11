% EigenTrunc -- Step 1
close all
clear
clc
profile clear
N = 100;
standard_err_value = 1e-4;
[p,x_start,t_start,t_stop,max_dt_FE] = getParam_HeatBar(N, 1000);
x0 = sparse(zeros(N,1));
eval_f2 = 'eval_f_LinearSystem'; %Non-Linear Version
eval_f = 'linear_func_always'; %Linear Version -- Use for EigenTrunc
eval_u = 'eval_u_step';
timestep = 1*10^(-3);
visualize = 1;
u=1;

hold on
%Non-Linear Version
tic;
[X_fe,t_fe] = ForwardEuler(eval_f2,x_start,p,eval_u,t_start,t_stop,timestep,visualize);
disp('Original')
t=toc
disp(X_fe(:, end))


%Linear Version -- Use for EigenTrunc
tic;
[X_fe_linear,t_fe_linear,A,B] = ForwardEulerLin(eval_f,x_start,p ,eval_u,t_start,t_stop,timestep,visualize);
disp('Linear')
tlin=toc
disp(X_fe_linear(:, end))
hold off
