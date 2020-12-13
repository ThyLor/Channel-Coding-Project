function [newU] = Puncturing(y)
pLen = 1080;
newU = zeros(pLen,1);
p1 = 1:720;
p2 = 757:1116;
newU(p1) = y(p1);
newU(p2) = y(p2);

