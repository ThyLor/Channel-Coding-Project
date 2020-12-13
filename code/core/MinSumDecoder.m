function [u_hat] = MinSumDecoder(nOR,nOC,nO,LLRprior,varLLRs,upMatrVC,perMatrCV,perMatrVC, iter, Hreal)
LLRcv = zeros(nO,1);
u_hat = zeros(length(nOC),1);
LLRvc = LLRprior;
for it=1:iter
    %LLRvc must be in Check representation, hence i multiply it by the
    LLRvc = perMatrVC * LLRvc; 
    %Compute the sign of each LLRcv
    tmp = sign(LLRvc);
    tmp(tmp == 0) = 1;
    signLLRcv = ComputeSign(tmp,nOR,nO);
    %Now, for each check node, find the two minimum value of the LLRs
    curIndex = 1;
    for j=1:length(nOR)
        checkInt = curIndex:nOR(j)+curIndex-1;
        [curCheckSort, sortIndex] = sort(abs(LLRvc(checkInt)));
        %Reasonably, we can consider only two values, the 2 lowest abs(LLR)
        LLRcv(checkInt) = curCheckSort(1); 
        LLRcv(curIndex + sortIndex(1)-1) = curCheckSort(2);
        curIndex = nOR(j) + curIndex;
    end    
    LLRcv = LLRcv .* signLLRcv;
    %At the end of this cycle all LLRcv are updated.
    %LLRcv and LLRvc in Check representation.
   LLRcv = perMatrCV * LLRcv; %Because now i want the LLRs in the Variable representation
   LLRvc = upMatrVC * LLRcv + LLRprior; %LLRvc is now, by def in variable representation
   %Stat decision
    curIndex = 1;
    for j=1:length(nOC)
         sumLLRcv = sum(LLRcv(curIndex:nOC(j)+curIndex-1));
         if(varLLRs(j) + sumLLRcv < 0)
            u_hat(j) = 1;
         else
             u_hat(j) = 0;
         end
         curIndex = curIndex + nOC(j);
    end
    if( mod(Hreal * u_hat,2) == 0)
        break;
    end
end
