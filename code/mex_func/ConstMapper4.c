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
    
    double *y0, *y1, *y2, *y3;
    double *mappedR,*mappedI;
    int len,M;
    
    
    /* 1. Check validity of expressions */
    
    // check input length
    if (nrhs != 5)
        mexErrMsgTxt("Five input arguments required");
    // check output length
    if (nlhs != 1)
        mexErrMsgTxt("One output argument required");
    
    
    /* 2. Read inputs */
    
    // received values
    y0 = mxGetPr(prhs[0]);
    y1 = mxGetPr(prhs[1]);
    y2 = mxGetPr(prhs[2]);
    y3 = mxGetPr(prhs[3]);
    len = *mxGetPr(prhs[4]);
    
    /* 3. Prepare output vectors */
    
    plhs[0] = mxCreateDoubleMatrix(len,1, mxCOMPLEX);
    mappedR = mxGetPr(plhs[0]);
    mappedI = mxGetPi(plhs[0]);

    
    /* 4. Run the algorithm */
    int i;
     for (i=0; i<len; i++)
     {
        mappedR[i] = (3 - 2*y2[i])*(2*y3[i] - 1);
        mappedI[i] = (3 - 2*y0[i])*(2*y1[i] - 1);
     }
    
    
    /* 5. Exit */
    
    return;
    
}
