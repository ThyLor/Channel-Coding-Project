function [upMatrVC, upMatrCV] = CreateUpdateMatrix(nOR,nOC,nO)
%nOR = vector representing the number of ones in each row
%nOC = vector representing the number of ones in each column
%nOnes = number of ones in the matrix H
upMatrCV = sparse(zeros(nO,nO));
upMatrVC = sparse(zeros(nO,nO));
% PermuteVC: from cv to vc
%Note that we're supposing that nOC(i) > 1 for any i
curIndex = 1;
for i=1:length(nOC)
   upMatrVC(curIndex:nOC(i)+curIndex-1,curIndex:nOC(i)+curIndex-1) = ones(nOC(i));
   curIndex = curIndex + nOC(i);
end
upMatrVC(logical(eye(nO))) = 0;
%PermuteCV: from vc to cv
%Note that we're supposing that nOR(i) > 1 for any i
curIndex = 1;
for i=1:length(nOR)
   upMatrCV(curIndex:nOR(i)+curIndex-1,curIndex:nOR(i)+curIndex-1) = ones(nOR(i));
   curIndex = curIndex + nOR(i);
end
upMatrCV(logical(eye(nO))) = 0;
