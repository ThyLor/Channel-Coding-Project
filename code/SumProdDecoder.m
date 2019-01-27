function [u_hat] = SumProdDecoder(nOR,nOC,LLRprior,vPLLRs,upMatrCV,upMatrVC,perMatrCV,perMatrVC, iter,Hreal)
u_hat = zeros(length(nOC),1);
minf = 1e-15;
%signLLRcv = zeros(nO,1);
%phi = @(x)  log((exp(x) + 1)/(exp(x) - 1));
LLRvc = LLRprior;
for it=1:iter
    %LLRvc must be in Check representation
    LLRvc = perMatrVC * LLRvc; 
    %Sign computation
    curSign = sign(LLRvc);
    curSign(curSign == 0) = 1;
    %signLLRcv = ComputeSign(curSign,nOR,nO)
    signLLRcv = GetSign(curSign,nOR);
    %Check the value of
    tmpP = abs(LLRvc);
    tmpP(tmpP < minf) = 1e-10;
    %Summation for any raw
    temp = upMatrCV * PhiMap(tmpP);
    %temp = upMatrCV * PhiMap(abs(LLRvc));
    %Just controlling that my function does not make any joke
    temp(temp < minf) = 1e-10;
    LLRcv =  PhiMap(temp).* signLLRcv;
    %LLRcv and LLRvc in Check representation.
    LLRcv = perMatrCV * LLRcv; %Because now i want the LLRs in the Variable representation
    LLRvc = upMatrVC * LLRcv + LLRprior; %LLRvc is now, by def in variable representation
    %Stat decision
    curIndex = 1;
    for j=1:length(nOC)
         if(vPLLRs(j) + sum(LLRcv(curIndex:nOC(j)+curIndex-1)) < 0)
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