function F = FTrap(x,p,u)
    dt = p.dt;
    xp = p.xp;
    up = p.up;
    eval_f = p.eval_f;
    
    F = x - 0.5*dt*(feval(eval_f,x,p,u) + feval(eval_f,xp,p,up)) - xp;