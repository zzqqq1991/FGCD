function [ output_args ] = saveResult( result, dir )
%SAVERESULT 此处显示有关此函数的摘要
%   此处显示详细说明
mkdir([dir 'flowed\']);
writeAllImages(result.Xflowed, [dir 'flowed\'], 'Xflowed');
mkdir([dir 'lighted\']);
writeAllImages(result.Xlighted, [dir 'lighted\'], 'Xlighted');

flowduringTime = result.flowduringTime;
lightduringTime = result.lightduringTime;



if result.isdodetection == 1

    mkdir([dir 'detection\']);

    writeAllImages(result.XError, [dir 'detection\'], 'XError');
    writeAllImages(result.YError, [dir 'detection\'], 'YError');
    writeAllImages(result.XA, [dir 'detection\'], 'XA');
    writeAllImages(result.YA, [dir 'detection\'], 'YA');


    imwrite(result.XErrorAvg, [dir 'detection\XErrorAvg.jpg']);
    imwrite(result.YErrorAvg, [dir 'detection\YErrorAvg.jpg']);
    imwrite(result.ErrorAvg, [dir 'detection\ErrorAvg.jpg']);

    detectionduringTime = result.detectionduringTime;
else
    detectionduringTime = 0;
end


alltime = flowduringTime + lightduringTime + detectionduringTime;

save([dir 'costtime.mat'], 'flowduringTime', 'lightduringTime', 'detectionduringTime', 'alltime');

end

