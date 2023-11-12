function test_tgcr


close all
format compact
%clc
disp(' '); disp(' ');

disp('******* testing tgcr.m *********')

num_tests     = 10;
N             = 6	% size of the matrix
num_clusters  = 7	   % number of clusters

disp(' ')
disp('testing fast solutions')
tolrGCR       = 1e-12 % to test fast solutions in about num_clusters iterations
% matrix = [
%     1, 2, 3, 4, 5;
%     6, 7, 8, 9, 10;
%     11, 12, 13, 14, 15;
%     16, 17, 18, 19, 20;
%     21, 22, 23, 24, 25
% ];
% matrix = eye(5)
diagonal_entries = [2, 2, 3, 3, 4, 4];

% Create a 6x6 matrix with specified diagonal entries
% matrix = diag(diagonal_entries);
matrix = [1, 0, 0, 0, 0;
     0, 2, 0, 0, 0;
     0, 0, 3, 0, 0;
     0, 0, 0, 4, 0;
     0, 0, 0, 0, 5];
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
   b= [3; 4; 1; 2; 3; 4 ];

% Transpose the 1x5 matrix to a 5x1 matrix
   
   % b     = rand(N,1);
   tic
   xGCR   = tgcr(A,b,tolrGCR,N);
   display(xGCR);
   % timesGCR(h) = toc;
   % tic
   % xLU   = A\b;
   % timesLU(h)  = toc;
   % errors(h)   = max(xLU-xGCR);
end

eigD  = eig(A_matrix);
eigA  = eig(A);
close
plot(real(eigA),imag(eigA),'.')
hold on
plot(real(eigD),imag(eigD),'ro')
axis equal
title('eigenvalues')
   
% ave_time_GCR   = mean(timesGCR)
% ave_time_LU    = mean(timesLU)
% max_x_error      = max(errors)
