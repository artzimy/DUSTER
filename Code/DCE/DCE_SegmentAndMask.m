nVols=size(DCE4D,4);
BadSlicesF2=[];
BadTimePoints=[];
%%

DCEMeanSegQB1=SPM_SegmentWithB1(MeanFN,Force);
FMaskFN=[WorkingP 'FBrainMsk.nii'];

ManMaskFN=[WorkingP 'Manual_BrainMask.nii'];
if(exist(ManMaskFN,'file'))
    %AddToLog(WorkingP,'a_2caaaaa','Using Manual_BrainMask');
    AddToLog(WorkingP,'a_2caaaaa','Using Manual.BrainMask');
    BrainMask=loadniidata(ManMaskFN)>0;
end

% If the brain mask have black holes in it, fill them
FBrainMask=bwfillHoles3Dby2D(BrainMask);
Raw2Nii(BrainMask,[WorkingP 'FBrainMsk.nii'],'int16',T1MapFN);
disp('FBrainMsk finished');

BrainMskFN=[WorkingP 'BrainMask.nii'];
%% Step 6.5 SPM masking
BaselineNoBadSliFN=[WorkingP 'BaselineNoBadSli.nii'];
BaselineNoBadSli=Baseline;
BaselineNoBadSli(:,:,BadSlicesF2)=NaN;
Raw2Nii(BaselineNoBadSli,BaselineNoBadSliFN,'float32', MeanFN);
% 
% DCEMeanSegP=SPM_Segment(BaselineNoBadSliFN,Force,[],false);
DCEMeanSegP=DCEMeanSegQB1;
C1=loadniidata([DCEMeanSegP 'c1ForSeg.nii'])/256;
C2=loadniidata([DCEMeanSegP 'c2ForSeg.nii'])/256;
C3=loadniidata([DCEMeanSegP 'c3ForSeg.nii'])/256;
if(Options.Mask_thresh>0)
    MinSPMBrainValue=Options.Mask_thresh;
else
    MinSPMBrainValue=0.5;    
end
% % BrainMask=(C1+C2)>MinSPMBrainValue;
% % 
BrainMaskA=(C1+C2+C3)>MinSPMBrainValue;
BrainMaskA=bwfillHoles3Dby2D(BrainMaskA);
se=strel('disk',2,8);
BrainMaskA=imerode(BrainMaskA,se);
BrainMaskA=bwfillHoles3Dby2D(BrainMaskA);
if((Options.Mask_thresh>0) && ~exist(ManMaskFN,'file'))
    BrainMask=BrainMaskA;
    FBrainMask=BrainMask;
end
Raw2Nii(BrainMask,BrainMskFN,'float32',MeanFN);
Raw2Nii(BrainMask,FMaskFN,'float32',MeanFN);

disp('SPM segment finished');
BaselineNoBadSliFN2=[WorkingP 'BaselineNoBadSli2.nii'];

% In unix, run the system cp command with no "-p" because it gives an
% error when the destination is in another computer so source and dest
% files have different owner
if (filesep == '/') % Unix
    system(['cp -f ' BaselineNoBadSliFN ' ' BaselineNoBadSliFN2]);
else  % Windows
    copyfile(BaselineNoBadSliFN,BaselineNoBadSliFN2,'f');    
end

% DCEMeanSegP2=SPM_Segment(BaselineNoBadSliFN2,Force,[],FMaskFN);
DCEMeanSegP2=DCEMeanSegQB1;

BaseSeg3D(:,:,:,1)=loadniidata([DCEMeanSegP2 'c1ForSeg.nii'])/256;
BaseSeg3D(:,:,:,2)=loadniidata([DCEMeanSegP2 'c2ForSeg.nii'])/256;
BaseSeg3D(:,:,:,3)=loadniidata([DCEMeanSegP2 'c3ForSeg.nii'])/256;
BaseSeg3D(:,:,:,4)=loadniidata(FMaskFN);
[Tmp, BaseSeg3DAll]=max(BaseSeg3D(:,:,:,1:3),[],4);
BaseSeg3DAll(~BaseSeg3D(:,:,:,4))=0;
% BaseCleaned=loadniidata([DCEMeanSegP2 'mForSeg.nii']);
BaseCleaned=MeanVol;

se=strel('disk',4,8);
EBrainMask=imerode(FBrainMask,se);
EEBrainMask=imerode(EBrainMask,se);
EEEBrainMask=imerode(EEBrainMask,se);

[MaxVal3D MaxEnhancementTime]=max(DCE4D,[],4);
MaxRatioToBaseline=MaxVal3D./Baseline;
EnhancementMsk=MaxRatioToBaseline>MinEnhancementR & MaxEnhancementTime>(BolusStart-1); % & MRIdx<(BolusStart+3);
TooEnhancedForNAWM=MaxRatioToBaseline>1.5;

CSFMask=BaseSeg3DAll==3 & BaseSeg3D(:,:,:,3)>Options.ThreshForRefMasks & EEEBrainMask==1;
WMMask=BaseSeg3DAll==2 & BaseSeg3D(:,:,:,2)>Options.ThreshForRefMasks & EEEBrainMask==1 & ~TooEnhancedForNAWM;

if(sumn(WMMask)<100)
    WMMask=BaseSeg3DAll==2 & BaseSeg3D(:,:,:,2)>Options.ThreshForRefMasks*0.9 & EEEBrainMask==1 & ~TooEnhancedForNAWM;
end
BaseSeg3DAllx=BaseSeg3DAll;
BaseSeg3DAllx(CSFMask)=4;
BaseSeg3DAllx(WMMask)=5;

SDCE=size(DCE4D);

Tmp=max(BrainMask,[],3);
F=find(max(Tmp,[],2));
GoodRows=F(1):F(end);
F=find(max(Tmp,[],1));
GoodCols=F(1):F(end);
GoodSlices=setdiff(1:SDCE(3),BadSlicesF2);
%%
%     MaxV=max(BaseCleaned(:))*0.1;
MaxV=median(BaseCleaned(isfinite(BaseCleaned) & BaseCleaned>100))*2;
[q MaxV]=FindDR(BaseCleaned(BrainMask));
for i=1:numel(GoodSlices)
    CurSli=GoodSlices(i);
    I=squeeze(BaseCleaned(:,:,CurSli));
    %         [Tmp MaxV]=FindDR(I);
    ClrM=[1 0 0; 0 1 0; 0 0 1; 1 1 0; 1 0 1];
    IRGB=repmat(min(1,I/MaxV),[1 1 3]);
    for tt=1:3
        BW2 = bwmorph(squeeze(BaseSeg3DAll(:,:,CurSli)==tt),'remove');
        for kk=1:3
            TmpI=IRGB(:,:,kk);
            TmpI(BW2)=ClrM(tt,kk);
            IRGB(:,:,kk)=TmpI;
        end
    end
    for tt=4:5
        BW2 = bwmorph(squeeze(BaseSeg3DAllx(:,:,CurSli)==tt),'remove');
        for kk=1:3
            TmpI=IRGB(:,:,kk);
            TmpI(BW2)=ClrM(tt,kk);
            IRGB(:,:,kk)=TmpI;
        end
    end
    IRGB3(:,:,:,i)=IRGB;
end

figure(9899);clf;
montage(mritransform(IRGB3(GoodRows,GoodCols,:,:)))
title(num2str(GoodSlices));
saveas(9899,[WorkingP 'BaseSeg'  '.png']);
saveas(9899,[WorkingP 'BaseSeg'  '.fig']);
%%
close(9899);
AddToLog(WorkingP,'ya_2d',['Img segmentation. Red - GM, Green - WM, Blue - CSF, Magenta - WM for reference, Yellow - CSF for reference.'],['BaseSeg'  '.png']);
%%
Raw2Nii(CSFMask,[WorkingP 'RefAuto_Base' '_CSF_2430.nii'],'float32', MeanFN);
Raw2Nii(WMMask,[WorkingP 'RefAuto_Base' '_WM_830.nii'],'float32', MeanFN);
%%
[MaxVal3D, MaxEnhancementTime]=max(DCE4D,[],4);
MaxRatioToBaseline=MaxVal3D./Baseline;
EnhancementMsk=MaxRatioToBaseline>MinEnhancementR & MaxEnhancementTime>(BolusStart-1); % & MRIdx<(BolusStart+3);

Msk=EnhancementMsk & MskMinSignal & BrainMask;