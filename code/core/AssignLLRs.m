function [LLRprior] = AssignLLRs(inLLRs,nOC,nO)
LLRprior = zeros(nO,1);
initIndex = 1;
for i=1:length(nOC)
    LLRprior(initIndex:nOC(i)+initIndex-1) = inLLRs(i); %Variable representation
    initIndex = initIndex + nOC(i);
end