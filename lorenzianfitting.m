% Lorentzian function accepting parameters as a vector
lorentzian = @(p, x) (p(1)/pi) * (p(2) ./ ((x - p(3)).^2 + p(2).^2));

% Initial guess for the parameters: [A, gamma, x0]
initialGuess = [1, 1, 0];

% Perform the fitting
params = lsqcurvefit(lorentzian, initialGuess, x, y);

plot(x, y, 'b.'); % Plot the original data
hold on;
plot(x, lorentzian(params, x), 'r-'); % Plot the fitted curve
legend('Data', 'Lorentzian Fit');
xlabel('x');
ylabel('y');
title('Lorentzian Fitting');
hold off;
