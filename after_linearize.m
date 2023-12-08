function f = linearization_function(x0,p,u)
A = p.Alinear; 
B = p.Blinear; 
f = A* x0 + B; 
end