function [nOR, nOC, nO, cnOR, cnOC] =  CalculateNumOnes(H)
[k, n] = size(H);
nOR = zeros(k,1); %Number of ones per row
nOC = zeros(n,1); %Number of ones per col
cnOR = zeros(k+1,1); %Comulative num of ones per row. k+1 elements: 0,nOR(1), nOR(1) + nOR(2), ..
cnOC = zeros(n+1,1); %Comulative num of ones per col. n+1 elements: 0,nOC(1), .., nOC(1)+..+nOC(n)
nO = 0;
for i=1:k
    nOR(i) = sum(H(i,:)~=0);
    nO = nO + nOR(i); 
    cnOR(i+1) = nO;    
end
com = 0;
for i=1:n
    nOC(i) = sum(H(:,i)~=0);
    com = com + nOC(i);
    cnOC(i+1) = com;
end
