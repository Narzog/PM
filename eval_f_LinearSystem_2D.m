function f = eval_f_LinearSystem_2D(x,p,u)
N = p.Nx * p.Ny; 
p.A = spalloc(N, N, 5 * N); 
p.dz = p.dx; 
for ix = 1:p.Nx
    for iy = 1:p.Ny
         k = (iy-1) * p.Nx + ix;
         k_nicr = p.electronic_mean_free * x(ix, iy) + p.phonon_mean_free * x(ix, iy)^3;
         Rc = (1/k_nicr) * p.dz; 
        p.A(k, k) = p.A(k, k) + 1/Rc;
        if ix > 1 %this is for the left side 
            j = k - 1;
            p.A(k, j) = p.A(k, j) - 1/Rc;
            p.A(j, k) = p.A(j, k) - 1/Rc;
        end
        if ix < p.Nx %rifght side
            j = k + 1;
            p.A(k, j) = p.A(k, j) - 1/Rc;
            p.A(j, k) = p.A(j, k) - 1/Rc;
        end
        if iy > 1 % connect to the bottom 
            j = k - p.Nx;
            p.A(k, j) = p.A(k, j) - 1/Rc;

            p.A(j, k) = p.A(j, k) - 1/Rc;
        end
        if iy < p.Ny %top 
             j = k + p.Nx;
            p.A(k, j) = p.A(k, j) - 1/Rc;
            p.A(j, k) = p.A(j, k) - 1/Rc;
        end
    end
end
Rloss = (1/p.ka) / p.dz;
for k = 1:N
    p.A(k, k) = p.A(k, k) + 1/Rloss;
end
p.A     = -p.A/p.Cstore; 
% disp(p.A)
% lambda = eig(p.A);
% slowest_eigenvalue = min(abs(lambda));
% fastest_eigenvalue = max(abs(lambda));

% t_stop = (slowest_eigenvalue*2);    %use this to wait until slowest mode
% max_dt_FE = 1/fastest_eigenvalue;
% disp(size(p.A)); 
x_vec_flat = x(:); %This would be N^2 by 1 so a colimn vector p.A is a N^2 by N^2
f_vec = p.A * x_vec_flat + p.B * u;
disp(p.A);
% disp(size(p.A * x_vec_flat )); 
% disp("B");
% disp(size(p.B)); 
f = reshape(f_vec, [p.Nx, p.Ny]);
end
