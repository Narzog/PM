profile clear

eval_f = 'eval_f_Heat';
eval_u = 'eval_u_step';
p.eval_f = 'eval_f_Heat';
p.eval_u = 'eval_u_step';

t0 = 0;
tf = 0.1;
timestep = 1e-6;

figure('Name', 'Trap Data');
hold on
%q = 2
profile -memory on
p.A = Ah2;
p.b = bh2;
x0 = zeros(2,1);
tic
[X2,t2] = ForwardEuler(eval_f,x0,p,eval_u,t0,tf,timestep,0);
time_q2 = toc
y2 = c'*Vq2*X2;
plot(t2,y2,'black')

%q = 5
p.A = Ah5;
p.b = bh5;
x0 = zeros(5,1);
tic
[X5,t5] = ForwardEuler(eval_f,x0,p,eval_u,t0,tf,timestep,0);
time_q5 = toc
y5 = c'*Vq5*X5;
plot(t5,y5,'red')

%q = 10
p.A = Ah10;
p.b = bh10;
x0 = zeros(10,1);
tic;
[X10,t10] = ForwardEuler(eval_f,x0,p,eval_u,t0,tf,timestep,0);
time_q10 = toc
y10 = c'*Vq10*X10;
plot(t10,y10,'green')

%original
p.A = A;
p.b = b;
x0 = zeros(N,1);
tic
[Xori,tori] = ForwardEuler(eval_f,x0,p,eval_u,t0,tf,timestep,0);
time_original = toc
yori = c'*Xori;
plot(tori,yori,'blue')
legend('q=2','q=5','q=10','original','Location','southeast')
hold off

profile('info')
profile status
profile viewer
profile off


% figure
% plot(tori,yori,'.',t2,X2,'s',t5,X5,'d',t10,X10,'+')
% legend('original','q=2','q=5','q=10','Location','southeast')
% xlabel('t')
% ylabel('y')

figure
semilogy(tori,abs(yori-yori),tori,abs(yori-y2),tori,abs(yori-y5),tori,abs(yori-y10))
legend('','q=2','q=5','q=10')
xlabel('t')
ylabel('|y_q(t)-y(t)|')