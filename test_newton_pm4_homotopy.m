clc; 
clear;
close all;
standard_err_value = 1e-6;
errf = standard_err_value ;
errDeltax = standard_err_value;
relDeltax = standard_err_value;
eval_f = 'eval_f_LinearSystem_for_DTFE';
eval_Jf = 'eval_Jf_FiniteDifference_DTFE';




N = 100;  %%play around  with amount of nodes 
[p,x_start,t_start,t_stop,max_dt_FE] = getParam_HeatBar(N, 1000);
x0 = sparse(zeros(N,1)); %%% ALso have to play 
x0 = x_start;

u = 1; 
figure
hold on
visualize = 0;
FiniteDifference = 1;
q_rate = 0.1; 
MaxIter = 10; 
for q = 0:q_rate:1
    f = feval(eval_f,x0,p, u, q);
    % plot(x0,f);
    % disp(x0);
    [x,converged,errf_k,errDeltax_k,relDeltax_k,iterations,X] = NewtonNd_homotopy(eval_f,x0,p,u,errf,errDeltax,relDeltax,MaxIter,visualize,FiniteDifference,eval_Jf , q);
    x0 = x;   
    
end
hold off

title('f(x,q) Poly')
xlabel('x')
ylabel('f(x)')
% u = 0; 
% while abs(u - q_rate - 1) > tolerance
%     % f = feval(eval_f,x,p, q);
%     % 
%     % plot(x,f,"DisplayName", num2str(q));
%     % title('f(x,q) Poly')
%     % xlabel('x')
%     % ylabel('f(x)')
%     % hold on; 
%     % x_list = [x_list, x0]; 
%     % q_list = [q_list, q]; 
% 
%     visualize = 0;
%     q = 1;
%     FiniteDifference = 1;
%     MaxIter = 10; 
%     disp(x0);
%     [x,converged,errf_k,errDeltax_k,relDeltax_k,iterations,X] = NewtonNd_homotopy(eval_f,x0,p,u,errf,errDeltax,relDeltax,MaxIter,visualize,FiniteDifference,eval_Jf, q);
%     x0 = x;    
%     u = u + q_rate;
%     disp(u);
% end
disp(converged);
disp(x); 
disp("Errors")
disp(errf_k);
disp(errDeltax_k);
disp(relDeltax_k);
% legend 


% visualize = 0;
% u=1;
% FiniteDifference = 1;
% MaxIter = 100; 
% 
% [x,converged,errf_k,errDeltax_k,relDeltax_k,iterations,X] = NewtonNd(eval_f,x0,p,u,errf,errDeltax,relDeltax,MaxIter,visualize,FiniteDifference,eval_Jf);
% disp(converged);
% disp(x); 
% disp(errf_k);
% disp(errDeltax_k);
% disp(relDeltax_k);

% test_newton_pm4 ---> getParam_heatbar(for p.B and change the ambient temperature  ---> eval_f_LinearSystem(for p.A)