function [matrSym] = GetSymbolForAllPer(M)
matrSym = zeros(2^M,M);
 matrPat = +(dec2bin(0:(2^M)-1)=='1');
 if(M==2)
    for j = 1:M
        matrSym(:,j) = ConstMapper2(matrPat(:,1),matrPat(:,2),2^M);
        if(j ~= M)
        matrPat(:,[j j+1]) =  matrPat(:,[j+1 j]);
        end
    end
 else
     for j = 1:M
        matrSym(:,j) = ConstMapper4(matrPat(:,1),matrPat(:,2),matrPat(:,3),matrPat(:,4),2^M);
        if(j ~= M)
        matrPat(:,[j j+1]) =  matrPat(:,[j+1 j]);
        end
     end
 end
