#include "mex.h"
#include <string.h>’
int AssignNumericData(double *pr, int size);
double get2normValue(double* pData,const int *dims,int row1,int column1,int row2,int column2);
void mexFunction(int nlhs,mxArray *plhs[],
					int nrhs, const mxArray *prhs[])
{
    double *pOut;
    double *indexrow;
    double *indexcolumn;
    double height;
    double width;
    int num = 0;
    int i,j,ni,nj;
    int indexi,indexj1,indexj2;
    double length;
    
    height = *(mxGetPr(prhs[0]));
    width = *(mxGetPr(prhs[1]));
    
    length = 2*(height-1)*(width-1);
    indexrow=(double*)malloc(sizeof(double)*length);
    indexcolumn=(double*)malloc(sizeof(double)*length);
    num = 0;
    for(i=1;i<=height-1;i++)
        for(j=1;j<=width-1;j++)
        {
            indexi = (j-1)*height+i;     //(i,j)��չ������±�
            ni = i+1;
            nj = j+1;
            indexj1 = (nj-1)*height+i; //(i,j)�ұߵ�չ���±� 
            indexj2 = (j-1)*height+ni; //(i,j)�±ߵ�չ���±�
            *(indexrow+num) = indexi;
            *(indexrow+num+1) = indexi;
            *(indexcolumn+num) = indexj1;
            *(indexcolumn+num+1) = indexj2;
            num = num+2;
        }           
    plhs[0] = mxCreateDoubleMatrix(1,length,mxREAL);
    pOut = mxGetPr(plhs[0]);
    memcpy(pOut,indexrow,num*sizeof(double));
    plhs[1] = mxCreateDoubleMatrix(1,length,mxREAL);
    pOut = mxGetPr(plhs[1]);
    memcpy(pOut,indexcolumn,num*sizeof(double));

    free(indexrow);
    free(indexcolumn);
    
    
    /*
    mxArray *mystr;
    int flag;
    char myprintchar[100], mychar[] = "This is a simple mex-file";
    mystr = mxCreateString(mychar);
    plhs[0] = mxCreateDoubleMatrix(2,3,mxREAL);
    flag = AssignNumericData(mxGetPr(plhs[0]),
            mxGetNumberOfElements(plhs[0]));
    
    mxGetString(mystr,myprintchar,
            mxGetNumberOfElements(mystr)*mxGetElementSize(mystr));
    mexPrintf(myprintchar);
    
    mxDestroyArray(mystr);
	mexPrintf("Hello Matlab world!");
     **/
}
double get2normValue(double* pData,const int *dims,int row1,int column1,int row2,int column2)
{
	double sum=0;
    double temp=0;
    long long i,offset1,offset2;
	for(i=0;i<dims[2];i++){
		offset1 = dims[0]*dims[1]*i+dims[0]*(column1-1)+row1-1;
		offset2 = dims[0]*dims[1]*i+dims[0]*(column2-1)+row2-1;
		temp = pData[offset1]-pData[offset2];
        sum+=temp*temp;
	}
    //mexPrintf("%d %d,%d %d %lf\n",row1,column1,row2,column2,sum);
    return sum;
}