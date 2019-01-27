function H_AI = SystematicForm(H)
H_AI = AIForm(H);


function matSwapped = Swap(mat,n,j,x,y)
temp = mat(x,1+j:n);
mat(x,1+j:n) = mat(y,1+j:n);
mat(y,1+j:n) = temp;
matSwapped = mat;

function H_permuted = AIForm(myMatrix)
m = size(myMatrix,1);
n = size(myMatrix,2);
n_m = n-m;
%For each possible sub-matrix
for j=0:m-1
    flag = 0;
    %if(myMatrix(1+j,m+1+j) == 0) %here is n_m = n - m, not m
    if(myMatrix(1+j,n_m+1+j) == 0)
       k = j + 1;
       while(flag == 0 && k < m)
           %if(myMatrix(1+k,m+1+j) == 1)  %here is n_m = n - m, not m
           if(myMatrix(1+k,n_m+1+j) == 1)
               myMatrix = Swap(myMatrix,n,0,1+j,1+k);
               flag = 1;               
           end
           k = k + 1;
       end
    else
        flag = 1;
    end
   %The first element of the current raw is equal to 1
   if(flag == 1)
       for i=(j+1):m-1
           %if(myMatrix(1+i,m+1+j) == 1)%here is n_m = n - m, not m
           if(myMatrix(1+i,n_m+1+j) == 1)
                myMatrix(1+i,:) = mod(myMatrix(1+j,:) ...
                                    + myMatrix(1+i,:),2);
           end
       end
   end
end
%Now myMatrix(1:5: n/2+1:n) is in "staircase" form
%--> diagonalize it
for i = 0:m-2
    for j=1:m-1-i
               if(myMatrix(j,n-i) == 1)
                   myMatrix(j,1:n) = mod(myMatrix(j,:) ...
                                     + myMatrix(m-i,:),2);
               end
    end
end
H_permuted = myMatrix;


