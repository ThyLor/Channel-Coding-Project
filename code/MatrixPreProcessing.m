function [Hsparse] = MatrixPreProcessing(H,c,t,b)
%I create the entire matrix,then i will consider ony yhe systematic part of
%it.
%RATIONALE: since the matrix is sparse, firstly a (c*b)x(t*b) zero
%matrix is created, then the ones are added according to the matrix policy.
Hsparse = sparse(zeros(c*b,t*b));
%Indexes of sparse Matrix. i --> raw index, j --> column index
for i=1:c
    for j=1:t
        %Get the submatrix index
        index = H(i,j);
        %If the sub-matrix is composed of all zeros, move on.
        if(index == -1) 
            if(j ~= c) %If im not in the last sub column, then i can move forward.
             j=j+1;   
            end           
        else
            %Encode
            iTemp = index ;
            k = 1;
            deltaB = b - iTemp;
            while(k <= deltaB)
                Hsparse((i-1)*b + k,(j-1)*b + iTemp + k) = 1;
                k = k + 1;
            end
            while(k <= b)
             Hsparse((i-1)*b + k,(j-1)*b + k -deltaB) = 1;
             k = k +1;
            end
        end
    end
end
