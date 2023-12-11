function [p, x_start, t_start, t_stop, max_dt_FE] = getParam_HeatBar_2D(Nx, Ny, Lx, Ly)
    % Defines the parameters for a 2D heat bar
    %Change Parameters here% 

    heat_source = 3.1; %1.1; 
    ambient_temperature = .5;
    p.electronic_mean_free = 5;  
    p.phonon_mean_free = 5;    %%% HAS T cubed dependence 
    t_stop = 0.75; %doens't matter 
    p.gamma = 0.1; %related to thermal capacitance per unit length of the bar
    p.km    = 700; %related to thermal conductance through metal per unit length of the bar
    p.ka    = 0.01; %replace with kapitza 

    % heat_source = 100.1; 
    % ambient_temperature = 1;
    % p.electronic_mean_free = 5;  
    % p.phonon_mean_free = 5; % HAS T cubed dependence 
    % t_stop = 0.75; % Doesn't matter 
    % p.gamma = 0.1; % Related to thermal capacitance per unit area
    % p.km    = 10; % Related to thermal conductance through metal per unit area
    % p.ka    = 0.1; % Replace with Kapitza 
    p.Nx = Nx;
    p.Ny = Ny;

    p.dx = Lx / (Nx - 1);
    p.dy = Ly / (Ny - 1);
    p.Cstore = p.gamma * p.dx * p.dy / 10; % The larger the section the larger the thermal storage
    p.B = sparse(zeros(Nx * Ny, 1));  
    Ia = p.ka * p.dx * p.dy * ambient_temperature;
    p.B = p.B + Ia;
    p.B(1:p.Nx) = heat_source;  
    p.B = p.B / p.Cstore;  
    x_start = ambient_temperature * ones(Nx, Ny); 
    t_start = 0;
    max_dt_FE = 0.75; 
end