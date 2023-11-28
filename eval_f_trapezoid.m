function f = eval_f_trapezoid(x, p, u)

og_f = feval(p.eval_f,x,p,u);

f = x - p.delta_t/2*og_f - p.gamma;

end