function test_tgcr


close all
format compact
%clc
disp(' '); disp(' ');

disp('******* testing tgcr.m *********')

num_tests     = 10;
N             = 100	% size of the matrix
num_clusters  = 7	   % number of clusters

disp(' ')
disp('testing fast solutions')
tolrGCR       = 1e-12 % to test fast solutions in about num_clusters iterations


eigenvalues = [0.1, 1000, linspace(30, 31, N-2)];
matrix = diag(eigenvalues);

test(num_tests,N,matrix,tolrGCR)

% disp(' ')
% disp('testing accurate solutions')
% tolrGCR       = 1e-12 % to test very accurate solutions
% test(num_tests,N,num_clusters,tolrGCR)



%*****************************************************
function [x] = test(num_tests,N,A_matrix,tolrGCR)


for h = 1:num_tests;
   A     =  A_matrix;
   % b = [1; 1; 1; 1; 1];
   % b= [3; 4; 1; 2; 3; 4 ];

% Transpose the 1x5 matrix to a 5x1 matrix
   
   b     = rand(N,1);
   tic
   [x, r_norms, k_list, r_norms_list]  = tgcr(A,b,tolrGCR,N);
   % display(xGCR);
   % timesGCR(h) = toc;
   % tic
   % xLU   = A\b;
   % timesLU(h)  = toc;
   % errors(h)   = max(xLU-xGCR);
end

eigD  = eig(A_matrix);
eigA  = eig(A);
close
plot(k_list,r_norms_list,'.')
% hold on
% plot(real(eigD),imag(eigD),'ro')
% axis equal
% title('eigenvalues')
% 
% ave_time_GCR   = mean(timesGCR)
% ave_time_LU    = mean(timesLU)
% max_x_error      = max(errors)
