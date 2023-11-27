clc; 
clear;
close all;
%%%%%%%%%%%%%%%%%%
N = 100 ;
standard_err_value = 1e-4;
[p,x_start,t_start,t_stop,max_dt_FE] = getParam_HeatBar(N, 1000);
x0 = sparse(zeros(N,1)); %%% ALso have to play 
% x0 = x_start; 
VisualizeNetworkPM4(x0, standard_err_value,N)
%%%%%%%%%%%%%%%%%%%%%%%%%%

% standard_err_value = 1e-4;
% errf = standard_err_value ;
% errDeltax = standard_err_value ;
% relDeltax = standard_err_value ;
% eval_f = 'eval_f_LinearSystem';
% N = 100;  %%play around  with amount of nodes 
% [p,x_start,t_start,t_stop,max_dt_FE] = getParam_HeatBar(N, 1000);
% x0 = sparse(zeros(N,1)); %%% ALso have to play 
% % x0 = x_start; 
% visualize = 0;
% u=1;
% FiniteDifference = 1;
% eval_Jf = 'eval_Jf_FiniteDifference';
% MaxIter = 100; 
% 
% [x,converged,errf_k,errDeltax_k,relDeltax_k,iterations,X] = NewtonNd(eval_f,x0,p,u,errf,errDeltax,relDeltax,MaxIter,visualize,FiniteDifference,eval_Jf);
% 
% V = x;
% 
% % Create a grid for X and Y dimensions
% n = sqrt(length(V)); % Assuming V can form a square grid
% if floor(n) ~= n
%     error('Vector length is not a perfect square, cannot form a square grid.');
% end
% 
% [X, Y] = meshgrid(1:n, 1:n);
% 
% % Reshape V into a matrix for Z values
% Z = reshape(V, [n, n]);
% 
% % Create the surface plot
% % surf(X, Y, Z);
% x_length = length(x);
% vector = 1:x_length;
% vector = transpose(vector);
% % disp(vector)
% plot(vector,x);
% % 
% % surf(diag(x)) %Other one
% 
% 
% 
% % disp(converged);
% disp(x); 
% disp(errf_k);
% disp(errDeltax_k);
% disp(relDeltax_k);

% % test_newton_pm4 ---> getParam_heatbar(for p.B and change the ambient temperature  ---> eval_f_LinearSystem(for p.A)