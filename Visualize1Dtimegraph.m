function Visualize1Dtimegraph()
% parameters
N = 10 ;
[p,x_start,t_start,t_stop,max_dt_FE] = getParam_HeatBar(N, 100);
eval_f = 'eval_f_LinearSystem';
eval_u = 'eval_u_step';
visualize = 0;

timestep = .01;
[X_tr,t_tr] = Trapezoidal(eval_f,x_start,p,eval_u,t_start,t_stop,timestep,visualize);

% 1D 
t_dym = size(t_tr, 2);
for i=1:t_dym
    hold off;
    plot([1:size(X_tr, 1)], X_tr(:, i))
    ylim([2, 3]);
    xlim([1, 10]);
    xlabel('Nodes');
    ylabel('Temperature');
    title(strcat('Temperatures at Timestep:  ', num2str(t_tr(i))));
    drawnow
    pause(.01)
end
hold off

% Color bar
[X, Y] = meshgrid(1:N, 1:10);
for i=1:t_dym
    hold off
    Z = repmat(X_tr(:, i),1,10);
    % Create the surface plot
    surf(X, Y, Z', 'EdgeColor', 'interp', 'FaceColor', 'interp'); %last one
    zlim([1.99 2.8]);
    xlim([1, 10]);
    % ylim([1, 10]);
    xlabel('Nodes');
    title(strcat('Temperatures at Timestep:  ', num2str(t_tr(i))));
    view(2);
    colormap('hot');
    colorbar;
    clim([2, 2.8]);
    set(gcf,'Color','w');
    drawnow
    pause(.1)
end


end