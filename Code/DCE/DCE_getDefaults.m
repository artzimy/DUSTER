Defaults.SubSampling=1;
Defaults.nVolsToRemoveFromStart=0;
Defaults.nVolsToRemoveFromEnd=0;
Defaults.SubSecondResolution=2;
Defaults.MinFirstBolusStd=2;
Defaults.EM_Num_Of_Iterations=0;
Defaults.FMS_TolFun=1e-11;
Defaults.FMS_MaxFunEvals=10000;
Defaults.FMS_MaxIter=10000;
Defaults.MaxTDif_ForAIFSearch=3;
Defaults.MaxTDif_ForWholeVOI=6;
Defaults.Rep_MaxAroundBolus=4;
Defaults.Rep_RatioToEnd=4;
Defaults.Rep_nPerSet=2;
Defaults.Mask_thresh=0.5;
Defaults.Run_On_All=0;
Defaults.TimeDelayToMaskVeins=-0.5;
Defaults.WeightForAIFMeanVesses=0.3;
Defaults.MainCoregistration=1;
Defaults.CoregRelaxToMain=1;

% If "1" and manualArt.nii exists, take the arteries from that file, 
% take their average and make a regular calculation (we have AIF so we 
% simply use Murase to get the PK parameters) without the possibility to shift BAT.
Defaults.MakeNoBATManualArtAnalysis=0;
% If "1" and manualArt.nii exists, take the arteries from that file, calculate the parameters 
% using F Min Search on the picked arteries (instead of finding representative) and allow the possibility to shift BAT
Defaults.MakeBATManualArtAnalysis=0;
% Default mode of choosing the arteries automatically
Defaults.MakeBATAutoArtAnalysis=1;
Defaults.MakeBATPopArtAnalysis=0;
Defaults.ExtractFAs=1;
Defaults.IncludeMainInT1=0;
Defaults.UseN3OnT1=1;
Defaults.TimeMultiplier=1;
Defaults.Use_Single_M0=0;
Defaults.Calc_Gains_Diff=1;
Defaults.ThreshForRefMasks=0.99;


Defaults.UseN3OnT1=false;
Defaults.Use_Single_M0=false;
Defaults.TimeMultiplier=1;
