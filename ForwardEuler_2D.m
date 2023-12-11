function  [X_vec] = ForwardEuler_2D(eval_f, x_start, p, eval_u, t_start, t_stop, timestep, visualize)
x_start_vec = x_start(:);
X_vec(:,1) = x_start_vec;
t(1) = t_start;
Nx = p.Nx;
Ny = p.Ny;     
fig =figure;
filename = "Testing"
for n = 1 : ceil((t_stop - t_start) / timestep)
    dt = min(timestep, (t_stop - t(n)));
    t(n + 1) = t(n) + dt;
    
    u = 1; 


    X_2D = reshape(X_vec(:, n), Nx, Ny); 
    f_2D = feval(eval_f, X_2D, p, u); 
    f_vec = f_2D(:); 
    X_vec(:, n + 1) = X_vec(:, n) + dt * f_vec;
   
    if visualize
        matrixShape = reshape(X_vec(:, n + 1), Nx, Ny);
        paddedMatrix = zeros(Nx+3, Ny+3);
        paddedMatrix(2:Nx+1, 2:Ny+1) = matrixShape;
        % pad= padarray(paddedMatrix, [1 1], 0, 'post');
        surf(paddedMatrix);
        % set_zlabel("Temperature"); 
        title(sprintf('2D Heat Bar, Time (seconds)  =  %f', t(n)));
        % view(0, 90);   % Set the view to be from directly above

        drawnow;
        zlim([0.5,2]);         
        % colorbar;
        % frame = getframe(fig);
        % im = frame2im(frame);
        % [imind, cm] = rgb2ind(im, 256);
        % if n == 1
        %     imwrite(imind, cm, filename, 'gif', 'Loopcount', inf, 'DelayTime', 0.1);
        % else
        %     imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.1);
        % end
    end
end

end
