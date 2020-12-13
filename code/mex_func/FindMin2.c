#include "mex.h"
#include "math.h"

#define INF 1e20
void mexFunction(
        int nlhs,               // number of outputs
        mxArray *plhs[],        // outputs vector
        int nrhs,               // number of inputs
        const mxArray *prhs[]   // inputs vector
        )
{
    
    double *myV;
    double min1,min2,curV;
    int len, i,i1;
    int *index;
    
    /* 1. Check validity of expressions */
    
    // check input length
    if (nrhs != 1)
        mexErrMsgTxt("One input arguments required");
    // check output length
    if (nlhs != 3)
        mexErrMsgTxt("Three output argument required");
    
    
    // received values
    myV = mxGetPr(prhs[0]);
    len = mxGetN(prhs[0]);
    
    min1 = myV[0];
    i1 = 0;
    for (i=1; i<len; i++)
    {
        curV = myV[i];
        if(curV < min1)
        {   
            min2 = min1;
            min1 = curV;
            i1 = i;
        }             
        else
        {    if(curV < min2)
             {  min2 = curV; 
             }
        }     
                
    }
    plhs[0] = mxCreateDoubleScalar(min1);
    plhs[1] = mxCreateDoubleScalar(min2);
    plhs[2] = mxCreateDoubleMatrix(1,2, mxREAL);

    index[0] = i1;  
    index = (int*) mxGetData(plhs[2]);
    /* 5. Exit */
    
    return;
    
}
