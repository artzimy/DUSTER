# DUSTER
MRI DCE analysis
------------------
![Banner](/docs/Banner1.png)
------------------
# Installation
Just download and put somewhere.
DUSTER is written in MATLAB, so it should be platform independent. Tested on Ubuntu 18.04 with MATLAB 2018-19.
# Run
Edit /Code/DCE/DCE_Main.m :
Provide the .nii file names: 
* main DCE run
* T<sub>1</sub> map
* \[optionally\] B1<sup>+</sup> map.

The files should be already coregistered and aligned/motion corrected.\

Also needed:
* TimeBetweenDCEVols in secons.
* TR in ms.
* FA in degrees.

We normally acquire ~60 volumes at a temporal resolution of ~6 seconds, with TR ~5ms, and FA ~20<sup>o</sup>.
## UIs
The program includes 2 UIs for manual inspection/intervention during the analsys:
1. Arterial voxels selection UI. Several voxels with significant arterial content should be chosed, preferably from the artery feeding the tumor. The system is robust to inaccurate selection.
2. AIF parameters UI.

And finally, a UI for exploring the results.

# More inside
## T<sub>1</sub> mapping from VFA-SPGR data
Also included is code for T<sub>1</sub> mapping calculation from VFA-SPGR data, using the nominal FAs, and estimation of the real FAs produced by the system, detailed in \[8\].

## 2CXM
In case the termporal resolution is good enough (i.e. volume every < 3 seconds), the 2-compartments-exchange-model may be used, providing additional flow information. Code for the analysis, based on \[7\], is provided here. If you're interested, please contact us.

# Other sofware used
The code includes stuff from:\
NIFTI-Tools from https://www.mathworks.com/matlabcentral/fileexchange/8797-tools-for-nifti-and-analyze-image \
MRIcron from https://people.cas.sc.edu/rorden/mricron/index.html \
Some optional calls to FSL https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/
# Contact
giladliberman@gmail.com

# Output maps (nii formt)
# DCE Maps \
Ktrans - Transfer coefficient of concentration between the blood plasma and extravascular extracellular space (EES) (1/min) \
Ve - Total EES volume. Given in arbitrary units (0-1) \ 
Vp - Total blood plasma volume. Given in arbitrary units (0-1) \
Kep -  Rate of consentaion ("Invers premability" - What returns blood vessels). given in 1/min \
BAT - Bolus arrival time Ve. Given in secounds \
RMS - Root mean squareerror map per voxel relative to the AIF \
rRMS3D and RMStoNoise - Normelized RMS maps 

# Relaxometry folder: \
T13DOFA - T1 map \
PD3DOFA - PD map \
RMS3DOFA - RMS of relaxometry map

# Advanced DCE GUI options
1. SubSampling – Allowing to sub-sample the original data (use lower temporal resolution)
Default: 1. DO NOT CHANGE (used for high resolution data).  3= for HTR change from 2sec to 6sec
2. nVolsToRemoveFromStart - Cut the first volumes of the test (for Siemens the first volumes are distorted).  Default: 0
3. nVolsToRemoveFromEnd - Cut the last volumes of the test (sometimes the last volumes are distorted).  Default: 0
4. SubSecondResolution - Number of sub seconds parts for super resolution ("2" means 1/2 of a second). Default: 2
5. MinFirstBolusStd - The minimum width of the bolus (standard deviation of the Gaussian that represents the first bolus). Default: 2
6. EM_Num_Of_Iterations - Number of iterations for the Expected Minimization algorithm which finds the optimal AIF and parameters. ).  Default: 5. (Currently not used).
7. FMS_TolFun - Function Minimum Search's (Matlab's) parameter. Tolerate Function – minimal improvement for continuing the search. Default: e^(-11)
8. FMS_MaxFunEvals – Number of possibilities for the F Mean Search at each step to change. Can think of it as in the case of 2-D vector f(X) ( How many 2-D  points to move to from the current one). Default: 10000
9. FMS_MaxIter - Maximal Number of iterations for FMS algorithm. Default: 10000
10. MaxTDif_ForAIFSearch - The possible shift in time for the AIF of the representing voxels (in seconds). Default: 3
11. MaxTDif_ForWholeVOI - Same as MaxTDif_ForAIFSearch, just when allowing shifting in time for all voxels in VOI (and not just representing voxels). Default: 6
12. Rep_MaxAroundBolus - Number of clusters around the bolus (for finding representing voxels). Default: 10
13. Rep_RatioToEnd - Number of clusters around the end of the test (for finding representing voxels). Default: 10
14. Rep_nPerSet - Number of total clusters will be MaxAroundBolus *Rep_RatioToEnd. This option will determine how many representing voxels we will choose from each cluster. Default: 1
15. Mask_Thresh - Set threshold for masking (the general mask of where to work).
For positive values (0-1) uses SPM for masking.
For negative values (0 to -1) uses BET for masking.
The absolute value is passed to the SPM or BET. 
Default: 0.5 (i.e., positive, uses SPM and the thresholds with 0.5).
16. Run_On_All - Run all processing steps. Default: 0 (Currently not used).
17. TimeDelayToMaskVeins – Delay from Bolus peak.  Default: -0.5
18. WeightForAIFMeanVesses – Similarity to the selected AIF Default: 0?
19. MainCoregistration - Choose between 1-realignment, 0-no motion correction and >=2 – coregister to that volume. Default: 1
20. CoregRelaxToMain - Do coregistration between Relaxometry and main. Default: 1
21. MakeNoBATManualArtAnalysis – If "1" and manualArt.nii exists, take the arteries from that file, take their average and make a regular calculation (we have AIF so we simply use Murase to get the PK parameters) without the possibility to shift BAT. Default: 0
22. MakeBATManualArtAnalysis - If "1" and manualArt.nii exists, take the arteries from that file, calculate the parameters using F Min Search on the picked arteries (instead of finding representative) and allow the possibility to shift BAT. Default: 0 (Currently not used). 
23. MakeBATAutoArtAnalysis – The default mode of choosing the arteries automatically. Default: 1
24. Extracted FAs - Correct the flip angles of the scan (we assume there is an error).Default: 1 (Currently not used).
25. IncludingMainInT1 - Default: 1. Include the DCE main (FA 20) in T1 calculation. (DO only if the DCE main acquired with the same calibration as the DESPOTs)
26. UsingN3T1 - Do inhomogeneity correction.  Default: 1
27. TimeMultiplier - Default: 1. can be used for time correction in Siemens data  (insert the estimated TR: -6 for STR and -2 for HTR).
28. Use_Single_M0 - Enable calculating T1 using a single angel. Default: 0
29. Calc_Gains_Diff - Enable/disable gains calculation made by Gilad. Default: 1
30. ThreshForRefMask. Default: 0.99 – threshold for the segmented WM mask (used as reference for T1 and Vp  cakculation)

# Relaxometry coregistration - Use the list box:
Can coregister to DCEMean ('Mean 4D'), use no coregistration (' No coreg’) or coregister to the median angle. Anyway will coregister the T1 map o DCE mean.

# Add reference files insert NIFTI files named:
RefVp_WM_830.nii
RefT1_WM_830.nii
Manual_BrainMask.nii
Manual_B1.nii [values ~1]

# For artery selection:
InspectedRepVox.nii - Takes exactly what's there, or
ManualArtMask.nii - Looks for arteries only inside that mask.

# Run additional time points from the DCEmain:
Order and names of folders:
St88_Se13_DCE_MAIN_15
St88_Se13_DCE_MAIN_15_UIDChange01
St88_Se13_DCE_MAIN_15_UIDChange04

# Improve B1 (calc T1 map) by excluding lesion area from RefT1_WM_830 map:
WMExMask.nii - Lesion mask mask.



# Refs
\[1\] DUSTER: Dynamic contrast enhance up-sampled temporal resolution analysis method, *Magnetic Resonance Imaging*, DOI: [10.1016/j.mri.2015.12.014](http://dx.doi.org/10.1016/j.mri.2015.12.014)

\[2\] Optimization of DCE-MRI protocol for the assessment of patients with brain tumors, *Magnetic Resonance Imaging*, DOI: [10.1016/j.mri.2016.07.003](http://dx.doi.org/10.1016/j.mri.2016.07.003)

\[3\] Differentiation between Treatment-Related Changes and Progressive Disease in Patients with High Grade Brain Tumors using Support Vector Machine Classification based on DCE MRI, *Journal of Neuro-Oncology*, DOI: [10.1007/s11060-016-2055-7](http://dx.doi.org/10.1007/s11060-016-2055-7)

\[4\] Human cerebral blood volume measurements using dynamic contrast enhancement in comparison to dynamic susceptibility contrast MRI, *Neuroradiology*, DOI: [10.1007/s00234-015-1518-4](http://dx.doi.org/10.1007/s00234-015-1518-4)

\[5\] Classification of tumor area using combined DCE and DSC MRI in patients with glioblastoma, *Journal of Neuro-Oncology*, 34(4): 442–450. DOI: [10.1007/s11060-014-1639-3](http://dx.doi.org/10.1007/s11060-014-1639-3)

\[6\] Differentiation between *vasogenic-edema* versus *tumor-infiltrative* area in patients with glioblastoma during bevacizumab therapy: A longitudinal MRI study, *European Journal of Radiology*, DOI: [10.1016/j.ejrad.2014.03.026](http://dx.doi.org/10.1016/j.ejrad.2014.03.026)

\[7\] Optimization of two-compartment-exchange-model analysis for dynamic contrast-enhanced mri incorporating bolus arrival time, *Journal of Magnetic Resonance Imaging*, DOI: [10.1002/jmri.25362](http://dx.doi.org/10.1002/jmri.25362)

\[8\] T<sub>1</sub> Mapping using Variable Flip Angle SPGR Data with Flip Angle Correction, *Journal of Magnetic Resonance Imaging*, DOI: [10.1002/jmri.24373](http://dx.doi.org/10.1002/jmri.24373)
