% EigenTrunc Step 2

profile clear
Eye = eye(N);
b = B;
c = Eye(:,N);
c(1)=1;
c(N)=0;

profile -memory on
tic;
q = 2
[Ah2,bh2,ch2,Vq2] = EigenmodeTruncation(A,b,c,q);
t_generate_2 = toc

% profile -memory on
tic;
q = 5
[Ah5,bh5,ch5,Vq5] = EigenmodeTruncation(A,b,c,q);
t_generate_5 = toc

% profile -memory on
tic;
q = 10
[Ah10,bh10,ch10,Vq10] = EigenmodeTruncation(A,b,c,q);
t_generate_10 = toc

profile('info')
profile status
profile viewer

profile off