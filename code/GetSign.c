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
    
    double *oldSign, *signLLRs, *nOR, totSgn, curVal;
    int length,lengthR,i,j,myIndex;
    
    
    /* 1. Check validity of expressions */
    
    // check input length
    if (nrhs != 2)
        mexErrMsgTxt("Two input arguments required");
    // check output length
    if (nlhs != 1)
        mexErrMsgTxt("One output argument required");
    
    
    /* 2. Read inputs */
    
    // received values
    oldSign = mxGetPr(prhs[0]);
    nOR = mxGetPr(prhs[1]);
    // vector length
    length = mxGetM(prhs[0]);
    lengthR = mxGetM(prhs[1]);
    
    /* 3. Prepare output vectors */
    
    plhs[0] = mxCreateDoubleMatrix(length,1, mxREAL);
    signLLRs = mxGetPr(plhs[0]);
    
    /* 4. Run the algorithm */
    myIndex = 0;
    for (i=0; i<lengthR; i++)
    {
        curVal = nOR[i];
        totSgn = 1;
        for (j=0; j<curVal; j++)
            totSgn *= oldSign[myIndex + j];
        for (j=0; j<curVal; j++)
            signLLRs[myIndex + j] = totSgn * oldSign[myIndex + j];
        myIndex += curVal;
    }    
    
    /* 5. Exit */
    
    return;
    
}
