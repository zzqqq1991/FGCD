function [ Cout ] = C_thres( Cin, th,dim,num)

    C = mapminmax(Cin,0,1);
    C_big = C > th;
    C_n = NeighborMatrix(C_big,dim);
    C_s = sum(C_n,3);
    Cout = C_s > num;
    

end

