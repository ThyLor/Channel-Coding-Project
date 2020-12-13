function [perMatrVC perMatrCV] = CreateUpdateMatrix(nOR,nOC,nO)
%nOR = vector representing the number of ones in each row
%nOC = vector representing the number of ones in each column
%nOnes = number of ones in the matrix H
perMatrCV = zeros(nO,nO);
perMatrVC = zeros(nO,nO);
% PermuteVC: from cv to vc
%Note that we're supposing that nOC(i) > 1 for any i
curIndex = 1;
for i=1:length(nOR)
   perMatrVC(curIndex:nOC(i)+curIndex-1,curIndex:nOC(i)+curIndex-1) = ones(nOC(i));
   curIndex = curIndex + nOC(i);
end
perMatrVC(logical(eye(nO))) = 0;
%PermuteCV: from vc to cv
%Note that we're supposing that nOR(i) > 1 for any i
%Actually there is no need of another computation since perMatrCV =
%perMatrVC inverse = perMatrVC transpose
curIndex = 1;
for i=1:length(nOR)
   perMatrCV(curIndex:nOR(i)+curIndex-1,curIndex:nOR(i)+curIndex-1) = ones(nOR(i));
   curIndex = curIndex + nOR(i);
end
perMatrCV(logical(eye(nO))) = 0;
