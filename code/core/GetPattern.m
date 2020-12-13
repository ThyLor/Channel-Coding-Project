function [perMatrVC, perMatrCV] = GetPattern(H,nO,cnOR,cnOC)
n = size(H,2);
perMatrVC = sparse(zeros(nO,nO));
patternCV = zeros(nO,1);
perMatrCV = sparse(zeros(nO,nO));
%from cv representation to vc representation
for j=1:n
    cS = find(H(:,j));
    for iC=1:length(cS)
        curRow = cS(iC);
        rS = find(H(curRow,:));
        for i=1:length(rS)
            if(rS(i) == j)
                arg1 = cnOC(j) + iC;
                arg2 = cnOR(curRow) + i;
                patternCV(arg1) = arg2;
                break;
            end
        end
    end
end
for i=1:nO
    perMatrCV(i,patternCV(i)) = 1;
end
perMatrVC  = transpose(perMatrCV); %Isn't that wonderful? (-:

