[A,b] = ps3p2_Loads;
% display(A);
% smallest_bound = 1e-4; 
c = condest(A) 
% k = 1;
% while 2*((sqrt(c) - 1)/(sqrt(c) + 1))^k > smallest_bound
%     k = k + 1;     
% end
% %Answer 
% display(k)
% 
% circle_centers = diag(A);
% circle_radii = sum(abs(A), 2) - abs(circle_centers);
% lambda_max_bound = max(circle_centers + circle_radii);
% lambda_min_bound = min(circle_centers - circle_radii);
% disp(lambda_max_bound);
% disp(lambda_min_bound);
% ratio = lambda_max_bound/lambda_min_bound ;
% 
% k = 1;
% while 2*((sqrt(ratio) - 1)/(sqrt(ratio) + 1))^k > smallest_bound
%     k = k + 1;     
% end
% %Answer 
% display(k)
% 
% tolrGCR       = 1e-4; 
% N=10000; 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%% 2 B %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% [x, r_norms, k_list, r_norms_list] = tgcr(A,b,tolrGCR,N);
% 
% elemental_inverted_diagonal = 1./diag(A);
% inverted_A_withnoinv = diag(elemental_inverted_diagonal);
% 
% [x, r_norms, k_list, r_norms_list]= tgcr(inverted_A_withnoinv*A,inverted_A_withnoinv*b,tolrGCR,N);
% % [x, r_norms, k_list, r_norms_list]= tgcr(inverted_A_withnoinv*A,inverted_A_withnoinv*b,tolrGCR,N);
% 
% 
% 
% 
% 
% 



% disp(x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [A,b] = ps3p2_Loads
% Loads from input files the descriptions of the 2D grid of resistors
% modeling heat diffusion on a heat conducting plate
% with nonuniform leakage
% and a single source in the center
% as described in problem 2 of PS3
%
% EXAMPLE USE:
% [A,b] = ps3p2_Load

% Historical development note up until to Fall 2020 
% we were using .mat proprietary matlab file format containing both Resistors and Isources
% in that case this function was implemented by the following single line of code
% load(InputName)

% From Fall 2021 we switched to .txt simple ASCII text format that is more compatible: 
% across different versions of matlab 
% across different programming languages
% and can also be read and edited manually by a human!
% in this case this funciton can be implemented by the following two lines of code

A = sparse(load('ps3p2_A.txt'));
b = sparse(load('ps3p2_b.txt'));
end

