function [ parameterflow, parameterlight, parameterlrr ] = getAllParameter()

parameter = [];
parameter.pieceWidth = 600;
parameter.pieceHeight = 500;
parameter.crossrate = 0.1;
parameter.isBlockProcess = 0;

parameterflow = [];
parameterflow = parameter;
parameterflow.marginrate = 0.1;


parameterlight = [];

parameterlight = parameter;
parameterlight.interNum = 5; 
parameterlight.lambda = 0.1;   % If the lighting correction is insufficient, reduce the value (ԽС�仯Խ���ԣ���ֵ��С�ᵼ�ºͲο�ͼ����ȫ��ͬ)
parameterlight.fai_E = 80;
parameterlight.Omega = 0;

parameterlrr = [];
parameterlrr = parameter;
parameterlrr.lambda = 0.0015;  % If you want to get more changes, reduce the value (ֵԽ�󣬵õ��ı仯Խ��)
parameterlrr.gama = 0.0025;
parameterlrr.rou = 0;
parameterlrr.display = false;

end

