function [ result ] = FlowLightingDetection( X, Y, parameterFlow, parameterLighting, parameterDetection )

result = [];

isdodetection = 1;

%% flow
startTime = clock;
Xflowed = []; flow = [];
if parameterFlow.isBlockProcess == 1
    [Xflowed, flow] = cameraGeometryCorrection_Piecemeal_Parallel(X,Y,parameterFlow);  %cameraGeometryCorrection_Piecemeal_Parallel
else
    [Xflowed, flow] = cameraGeometryCorrection(X,Y,parameterFlow);  %cameraGeometryCorrection_Piecemeal_Parallel
end
% Xflowed = X;

endTime = clock;
flowduringTime = etime(endTime,startTime);
%% lighting  
startTime = clock;
Xlighted = [];
for i = 1:size(X, 4)
    if isfield(parameterLighting, 'givenLightedT')
        parameterLighting.lastT = parameterLighting.givenLightedT(:,:,:,i);
    end
    if parameterLighting.isBlockProcess == 1
        [Xlighted(:,:,:,i), T] = lightingCorrection_Piecemeal_Parallel(Xflowed(:,:,:,i),Y(:,:,:,i), parameterLighting);  %lightingCorrection_Piecemeal_Parallel
    else
        [Xlighted(:,:,:,i), T] = lightingCorrection(Xflowed(:,:,:,i),Y(:,:,:,i), parameterLighting);  %lightingCorrection_Piecemeal_Parallel
    end
    
end
endTime = clock;
lightduringTime = etime(endTime,startTime);

if isdodetection == 1
    
    %% detection
    startTime = clock;
    if isfield(parameterDetection, 'givenEX')
        parameterDetection.lastEX = parameterDetection.givenEX;
        parameterDetection.lastEY = parameterDetection.givenEY;
    end
    XError=[];YError=[];XA=[];YA = [];
    if parameterDetection.isBlockProcess == 1
        [XError,YError,XA,YA] = fineChangeDetection_Piecemeal_Parallel(Xlighted,Y,parameterDetection); %fineChangeDetection_Piecemeal_Parallel
    else
        [XError,YError,XA,YA] = fineChangeDetection(Xlighted,Y,parameterDetection); %fineChangeDetection_Piecemeal_Parallel
    end

    endTime = clock;
    detectionduringTime = etime(endTime,startTime);

    num = size(XError,4);
    XErrorAvg = zeros(size(XError(:,:,:,1)));
    YErrorAvg = zeros(size(YError(:,:,:,1)));
    for i = 1 : num
        XErrorAvg = XErrorAvg + XError(:,:,:,i);
        YErrorAvg = YErrorAvg + YError(:,:,:,i);
    end

    XErrorAvg = XErrorAvg/num;
    YErrorAvg = YErrorAvg/num;
    ErrorAvg = (XErrorAvg + YErrorAvg)/2;
end



result.Xflowed = Xflowed;
result.Xflow = flow;
result.flowduringTime = flowduringTime;
result.Xlighted = Xlighted;
result.lightedT = T;
result.lightduringTime = lightduringTime;

result.isdodetection = isdodetection;

if isdodetection == 1 
    result.XError = XError;
    result.YError = YError;
    result.XErrorAvg = XErrorAvg;
    result.YErrorAvg = YErrorAvg;
    result.ErrorAvg = ErrorAvg;
    result.XA = XA;
    result.YA = YA;
    result.detectionduringTime = detectionduringTime;
end

end

