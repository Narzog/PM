function f = linear_func_always(x0,p,u)
u        = 1;
eval_f = "eval_f_LinearSystem";
[Jf,dxFD] = eval_Jf_FiniteDifference(eval_f,x0,p,u);
u_0= zeros(p.N, 1);
u_0(1) = 1; 
% disp(u_0);
k_0 = eval_f_LinearSystem(x0,p,u) - Jf * (x0) - 1/(p.Cstore) * u_0;
A = Jf; 
j_0 = 1/(p.Cstore) * u_0;  
B = k_0  + u * j_0; 
% p.Alinear = A; 
% p.Blinear = B; 
f  = A* x0 + B; 
end