function [Ah,bh,ch,Vq] = EigenmodeTruncation(A,b,c,q)
    [V,D] = eigs(sparse(A),q);
    bt = V\b;
    ct = V\c;
    
    N = length(A);
    H = zeros(N,1);
    for i = 1:q
        H(i) = abs(bt(i)*ct(i)/D(i,i));
    end
    [B,I] = sort(H,'descend');
    
    Ah = zeros(q,q);
    bh = zeros(q,1);
    ch = zeros(q,1);
    Vq = zeros(N,q);
    for j = 1:q
        Ah(j,j) = D(I(j),I(j));
        bh(j) = bt(I(j));
        ch(j) = ct(I(j));
        Vq(:,j) = V(:,I(j));
    end
    
end