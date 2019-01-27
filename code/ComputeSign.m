function signLLRcv = ComputeSign(checkVarSign,nOR,nO)
curIndex = 1;
signLLRcv = zeros(nO,1);
for i = 1:length(nOR)
    curInterval = curIndex:curIndex + nOR(i) -1;
    signLLRcv(curInterval) = prod(checkVarSign(curInterval));
    for j=1:nOR(i)
        signLLRcv(curIndex + j - 1) = signLLRcv(curIndex + j - 1) * checkVarSign(curIndex + j - 1);
    end
    curIndex = curIndex + nOR(i);
end
