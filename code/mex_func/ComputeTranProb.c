#include "mex.h"
#include "math.h"


/************************************************************************
 * Main function
 ************************************************************************/

void mexFunction(
        int nlhs,               // number of outputs
        mxArray *plhs[],        // outputs vector
        int nrhs,               // number of inputs
        const mxArray *prhs[]   // inputs vector
        )
{
    
    double *rR, *rI, *sR,*sI,*mu;
    double konst;
    int len;
    
    
    /* 1. Check validity of expressions */
    
    // check input length
    if (nrhs != 4)
        mexErrMsgTxt("Three input arguments required");
    // check output length
    if (nlhs != 1)
        mexErrMsgTxt("One output argument required");
    
    
    /* 2. Read inputs */
    
    // received values
    rR = mxGetPr(prhs[0]);
    rI = mxGetPi(prhs[0]);
    sR = mxGetPr(prhs[1]);
    sI = mxGetPi(prhs[1]);
    konst = *mxGetPr(prhs[2]);
    len = *mxGetPr(prhs[3]);
    
    /* 3. Prepare output vectors */
    plhs[0] = mxCreateDoubleMatrix(len,1, mxREAL);
    mu = mxGetPr(plhs[0]);    
    /* 4. Run the algorithm */
    int i;
    for (i=0; i<len; i++)
    {
        mu[i] = exp(konst*( pow((rR[i] - sR[i]),2) + pow((rI[i] - sI[i]),2)));
    }
    
    /* 5. Exit */
    
    return;
    
}
