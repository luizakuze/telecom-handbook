#include "calculadora.h"
int * soma_1_svc(operandos *argp, struct svc_req *rqstp){
    static int result;
    result = argp->a + argp->b;
    return &result;
}