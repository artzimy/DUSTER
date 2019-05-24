disp('Rough estimation of bolus time');
% We mask again for all slices with value bigger than minimum (this time for all time periods and not just the first)
DCE2D=Reshape4d22d(DCE4D,MskMinSignal);
% Get the median of each of the 3d images for the entire time slots 
MedTC=median(DCE2D,1);

TwoMinTimePoint=floor(2/TimeBetweenDCEVolsMin);
Ps=zeros(1,numel(MedTC))+2;
% We use the t-test to get the biggest probability that the distribution of the sample
% is diffrent than the rest of the test ( -> smallest Ps value)
for i=3:min(TwoMinTimePoint,numel(MedTC)-2) %Take the minimum out of 2 minutes frame to 2 frames before the end
    [h Ps(i)]=ttest2(MedTC(1:i),MedTC((i+1):end),[],[],'unequal');
end
mLPs=-log(Ps);
% figure;plot(1:numel(MedTC),MedTC,'b',1:numel(MedTC),mLPs.*(max(MedTC)-min(MedTC))./(max(mLPs)-min(mLPs))+min(MedTC),'r')
[Tmp, BolusStart]=max(mLPs);

% ASK GILAD - why did he add +1?
BolusStart=BolusStart+1;
BolusStartMin=(BolusStart-1)*TimeBetweenDCEVolsMin;
% BolusStart=find(MedTC>MedTC(1)+20,1);
% The base line is the mean of the first images until the bolus
Baseline=mean(DCE4D(:,:,:,1:(BolusStart-2)),4);
BaselineFN=[WorkingP 'Baseline.nii'];
Raw2Nii(Baseline,BaselineFN,'float32', MeanFN);
figure(78362);subplot(1,2,2);
plot(MedTC); hold on;plot([BolusStart BolusStart],[min(MedTC) max(MedTC)],'r');
title('Bolus start approximation');

saveas(78362,[WorkingP 'SlicesIntensityAndBolusTime.png']);
saveas(78362,[WorkingP 'SlicesIntensityAndBolusTime.fig']);
close(78362)
AddToLog(WorkingP,'a_2xx',['Bolus start index estimation:' num2str(BolusStart) '.']);
AddToLog(WorkingP,'ya_2xx',['Bolus start index estimation:' num2str(BolusStart) '.'],'SlicesIntensityAndBolusTime.png');