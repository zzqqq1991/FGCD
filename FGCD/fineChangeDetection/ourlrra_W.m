function [mintol_A,mintol_E] = ourlrra_W(D,W,givenE,parameter)
%parameter:lambda,gama,fai,display, functionnum,model,lastE

lambda = parameter.lambda;
gama = parameter.gama;
rou = parameter.rou;
display = parameter.display;
functionnum = parameter.functionnum;

% tol = 1.8e-4;
mintol = 1;
mintol_E = []; %��Сtol��Ӧ��E
mintol_A = []; %��Сtol��Ӧ��A
tolvec = [];
maxIter = 200;
[d, n] = size(D);
m = d;
rho = 1.1;
max_mu = 1e10;
mu = 0.01;  %��һ����Χ�ڣ�����ԽС�����Խ�ã�������Խ��
% mu = 10^-6;

% atx = A'*X;
% inv_a = inv(A'*A+eye(m));
%% Initializing optimization variables
% intialize
A = zeros(m,n);
J = zeros(m,n);
E = sparse(d,n);


Y1 = zeros(d,n);
Y2 = zeros(m,n);
%% Start main loop
iter = 0;
if parameter.display
    disp(['initial,rank=' num2str(rank(A))]);
end
while iter<maxIter
    iter = iter + 1;
    %update A
    temp = D-E+(Y1/mu);
    [U,sigma,V] = svd(temp,'econ');
    sigma = diag(sigma);
    svp = length(find(sigma>1/mu));
    if svp>=1
        sigma = sigma(1:svp)-1/mu;
    else
        svp = 1;
        sigma = 0;
    end
    A = U(:,1:svp)*diag(sigma)*V(:,1:svp)';
    %udpate J
    temp = E - (Y2/mu);
    J = sign(temp).*pos(abs(temp)-(lambda/mu));
    %update E
    tempE1 = [];
    tempE2 = [];
    
    tempE1 = D-A+J +(Y1+Y2)/mu;
    tempE2 = gama*W + 2*speye(d,d);

    if size(givenE)>0
        tempE1 = tempE1 + rou*parameter.givenEcons*givenE;
        tempE2 = tempE2 + rou*parameter.givenEcons;
    end
    if size(parameter.mask)>0 & size(givenE)>0
        tempE1 = parameter.maskcons*tempE1;
        tempE2 = tempE2*parameter.maskcons;
    end
%     if model == 1
%         tempE1 = D-A+J +(Y1+Y2)/mu;
%         tempE2 = 2*speye(d,d);
%     elseif model == 2
%         tempE1 = D-A+J +(Y1+Y2)/mu;
%         tempE2 = (gama*W + 2*speye(d,d));
%     elseif model == 3
%         tempE1 = fai*lastE + D-A+J +(Y1+Y2)/mu;
%         tempE2 = ((fai + 2)*speye(d,d));
%     elseif model == 4
%         tempE1 = fai*lastE + D-A+J +(Y1+Y2)/mu;
%         tempE2 = (gama*W + (fai + 2)*speye(d,d));
%     end

    
    if functionnum == 1
    %1
    E =  tempE2 \ tempE1;
    %1end
    elseif functionnum == 2
    %2
    [tempnum,tempdim] = size(tempE1);
    E = [];
    for i=1:tempdim
        [E1,flag] = cgs(tempE2, tempE1(:,i));
%         [E2,flag] = cgs(tempE2, tempE1(:,2));
        E = [E, E1];
    end
    %2end
    elseif functionnum == 3
    %3
    [E1] = symmlq(tempE2, tempE1(:,1));
    [E2] = symmlq(tempE2, tempE1(:,2));
    E = [E1,E2];
    %3end
    elseif functionnum == 4
    %4
    [E1] = lsqr(tempE2, tempE1(:,1));
    [E2] = lsqr(tempE2, tempE1(:,2));
    E = [E1,E2];
    %4end
    elseif functionnum == 5
    %5
        temp1 = [tempE2, tempE1(:,1)];
        temp1=rref(temp1);
        E1 = temp1(:,end);
        temp2 = [tempE2, tempE1(:,1)];
        temp2=rref(temp2);
        E2 = temp2(:,end);
        E = [E1,E2];
    %5end
    end
    
    leq1 = D - A - E;
    leq2 = J - E;
    stopC = max(max(max(abs(leq1))),max(max(abs(leq2))));
    tolvec(end+1) = stopC;
%     if display && (iter==1 || mod(iter,50)==0 || stopC<tol)
    if display
        disp(['iter ' num2str(iter) ',mu=' num2str(mu,'%2.1e') ...
            ',rank=' num2str(rank(A,1e-4*norm(A,2))) ',stopALM=' num2str(stopC,'%2.3e')]);
    end
    
    if stopC<mintol   %�����¼��С�Ĳв�
        mintol = stopC;
        mintol_E = E;
        mintol_A = A;
    end
    
    %�ҳ�tolvec�����N�������ֵ
    N = 10;
    if length(tolvec)>N
        maxtemp = max(tolvec(end-N:end));
        if stopC == maxtemp %�п��ܻ�������ǵ���ֵ��Ŀ�꺯���Ŀ�����Сֵ��ҪС����˵�stopC������Сֵ���п��ܻᷴ���������ж���������˾ͽ���
            break;
        end
    end
%     if stopC<tol 
%         break;
%     else
        Y1 = Y1 + mu*leq1;
        Y2 = Y2 + mu*leq2;
        mu = min(max_mu,mu*rho);
%     end
end