function Visualizeerrorvtime()
N = 10 ;
[p,x_start,t_start,t_stop,max_dt_FE] = getParam_HeatBar(N, 100);
eval_f = 'eval_f_LinearSystem';
eval_u = 'eval_u_step';
visualize = 0;
load reference.mat;
fe_err_rates = zeros(2, 4);
trap_err_rates = zeros(2, 4);
dym_trap_err_rates = zeros(2, 4);
index_val = 1;
for timestep=[1e-4, 1e-3, 1e-2, 1e-1]
    disp(index_val)
    % timestep = 10^(scale_val);
    tic;
    [X_fe,t_fe] = ForwardEuler(eval_f,x_start,p,eval_u,t_start,t_stop,timestep,visualize);
    fe_err_rates(2, index_val) = toc;
    fe_err_rates(1, index_val) = norm(X_fe(:, end) - X_ref(:, end), Inf);

    tic;
    [X_trap,t_trap] = Trapezoidal(eval_f,x_start,p,eval_u,t_start,t_stop,timestep,visualize);
    trap_err_rates(2, index_val) = toc;
    trap_err_rates(1, index_val) = norm(X_trap(:, end) - X_ref(:, end), Inf);
    tic;
    [X_tr,t_tr] = Trapezoidal_Dynamic(eval_f,x_start,p,eval_u,t_start,t_stop,timestep,visualize);
    dym_trap_err_rates(2, index_val) = toc;
    dym_trap_err_rates(1, index_val) =  norm(X_tr(:, end) - X_ref(:, end), Inf);
    index_val = index_val + 1;

end

% Error vs Time Taken
scatter(fe_err_rates(2, :), fe_err_rates(1, :), 'DisplayName', 'Forward Euler')
hold on
scatter(trap_err_rates(2, :), trap_err_rates(1, :), 'DisplayName', 'Trapezoidal', 'Marker', "+")
hold on
scatter(dym_trap_err_rates(2, :), dym_trap_err_rates(1, :), 'DisplayName', 'Dynamic Trapezoidal', 'Marker', "*")
set(gca,'xscale','log');
set(gca,'yscale','log');
xlabel('Time Taken');
ylabel('Error');
title('Error vs Time');
legend();
hold off

% Error vs Timestep
timesteps_val = [1e-4 1e-3 1e-2 1e-1];
loglog(timesteps_val, fe_err_rates(1, 1:4), 'DisplayName', 'Forward Euler')
hold on
loglog(timesteps_val, trap_err_rates(1, 1:4), 'DisplayName', 'Trapezoidal')
hold on
loglog(timesteps_val, dym_trap_err_rates(1, 1:4), 'DisplayName', 'Dynamic Trapezoidal')
xlabel('Timestep Value');
ylabel('Error');
title('Calculation Times for Timesteps');
legend();
hold off
end