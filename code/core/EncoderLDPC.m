function y = EncoderLDPC(H,n,k,u)
y(1:k) = u;
y(k+1:n) = mod(H(:,1:k) * u,2);
y = transpose(y);
end