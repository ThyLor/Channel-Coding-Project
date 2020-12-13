function [LLR] = LLR_BICM(r,matrSym,sigwS,M)
curVal = zeros(2^M,1);
len = length(r);
LLR = zeros(len * M,1);
for p = 1:length(r)
    curVal(:) = r(p);
    for j = 1:M
        phi = ComputeTranProb(curVal,matrSym(:,j),-0.5/sigwS,2^M);
        LLR((p-1)*M + j) = log(sum(phi(1:2^(M-1)))/sum(phi(2^(M-1)+1:2^M)));
    end
end