function [priorLLR] = PuncturingLLR(LLR,punPat,choice)
priorLLR = LLR;
if(choice == 6)
    if(punPat == 1)
        p1 = 721:756;
        p2 = 1117:1152;
    else
        p1 = 721:768;
        p2 = 1009:1104;
    end
else
    if(punPat == 1)
        p1 = 3241:3402;
        p2 = 4375:4536;
    else
        p1 = 1:216;
        p2 = 4537:4968;
    end
end
priorLLR(p1) = 0;
priorLLR(p2) = 0;
