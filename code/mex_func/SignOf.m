#include "math.h"
#include "matrix.h"
#include <stdlib.h>
#include <float.h>


/************************************************************************
 * Useful function
 ************************************************************************/

#define sign(x) (x>=0.0?1.0:0.0)

void mexFunction(
        int nlhs,               // number of outputs
        mxArray *plhs[],        // outputs vector
        int nrhs,               // number of inputs
        const mxArray *prhs[]   // inputs vector
        )
{
    
    double *LLRs, *mapLLRs;
    int length;
    
    
    /* 1. Check validity of expressions */
    
    // check input length
    if (nrhs != 1)
        mexErrMsgTxt("Two input arguments required");
    // check output length
    if (nlhs != 1)
        mexErrMsgTxt("One output argument required");
    
    
    /* 2. Read inputs */
    
    // received values
    LLRs = mxGetPr(prhs[0]);
    // vector length
    length = mxGetM(prhs[0]);
    
    // other parameters can be also read
    // k = mxGetScalar(mxGetField(prhs[1], 0, "k"));
    // sigw = mxGetScalar(mxGetField(prhs[1], 0, "sigw"));
    // but add processing time
    
    // you may also print some useful information for debugging purposes
    // printf("k = %d, n = %d, sigw = %f\n",k,n,sigw);
    
    
    /* 3. Prepare output vectors */
    
    plhs[0] = mxCreateDoubleMatrix(length,1, mxREAL);
    mapLLRs = mxGetPr(plhs[0]);
    
    /* 4. Run the algorithm */
    
    int i;    
    for (i=0; i<length; i++)
    {
        mapLLRs[i] = log((exp(LLRs[i]) + 1)/(exp(LLRs[i]) - 1));
    }    
    
    /* 5. Exit */
    
    return;
    
}