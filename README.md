# DUSTER
MRI DCE analysis
------------------
![Banner](/docs/Banner1.png)
------------------
# Installation
Just download and put somewhere.
The code is all MATLAB, so should be platform independent. Tested on Ubuntu with MATLAB 2018-19.
# Run
Edit /Code/DCE/DCE_Main.m :
Just provide the .nii files: one for the main DCE run, one for T1 map and optionally one for B1<sup>+</sup> map. The files should be already coregistered and aligned/motion corrected.
Also provide:
TimeBetweenDCEVols in secons.
TR in ms.
FA in degrees.

We normally use ~60 volumes at ~6 secons temporal resolution, with TR ~5ms, and FA ~20.
## UIs
The program includes 2 UIs for manual inspection/intervention during the analsys:
1. Arterial voxels selection UI,
2. AIF parameters UI.
And finally, a UI for exploring the results.
Details about the UIs can be found here:

# More inside
## T<sub>1</sub> mapping from VFA-SPGR data
Also included is code for T1 mapping calculation from VFA-SPGR data, using the nominal FAs, and estimation of the real FAs produced by the system.

## 2CXM
In case the termporal resolution is good enough (i.e. volume every <3sec), the 2-compartments-echange-model may be used, providing additional flow information. Code for the analysis, based on [X], is provided here. If you're interested, please contact us.

# Other sofware used
This code includes stuff from:
SPM8 from https://www.fil.ion.ucl.ac.uk/spm/software/spm8/ \
NIFTI-Tools from https://www.mathworks.com/matlabcentral/fileexchange/8797-tools-for-nifti-and-analyze-image \
MRIcron from https://people.cas.sc.edu/rorden/mricron/index.html \
# Refs
The main ref is:

"DUSTER: Dynamic contrast enhance up-sampled temporal resolution analysis method.", *Magnetic Resonance Imaging*, DOI: [10.1016/j.mri.2015.12.014](http://dx.doi.org/10.1016/j.mri.2015.12.014)

"Optimization of DCE-MRI protocol for the assessment of patients with brain tumors.", *Magnetic Resonance Imaging*, DOI: [10.1016/j.mri.2016.07.003](http://dx.doi.org/10.1016/j.mri.2016.07.003)

"Differentiation between Treatment-Related Changes and Progressive Disease in Patients with High Grade Brain Tumors using Support Vector Machine Classification based on DCE MRI.", *Journal of Neuro-Oncology*, DOI: [10.1007/s11060-016-2055-7](http://dx.doi.org/10.1007/s11060-016-2055-7)

"Human cerebral blood volume measurements using dynamic contrast enhancement in comparison to dynamic susceptibility contrast MRI.", *Neuroradiology*, DOI: [10.1007/s00234-015-1518-4](http://dx.doi.org/10.1007/s00234-015-1518-4)

"Classification of tumor area using combined DCE and DSC MRI in patients with glioblastoma.", *Journal of Neuro-Oncology*, 34(4): 442–450. DOI: [10.1007/s11060-014-1639-3](http://dx.doi.org/10.1007/s11060-014-1639-3)



\years{2014}M. Artzi, F. Bokstein, D.T. Blumenthal, O. Aizenstein, \textbf{G. Liberman}, B.W. Corn and D. Ben Bashat, “Differentiation between \emph{vasogenic-edema} versus \emph{tumor-infiltrative} area in patients with glioblastoma during bevacizumab therapy: A longitudinal MRI study", \emph{European Journal of Radiology} 83(7), 1250-1256. DOI: \href{http://dx.doi.org/10.1016/j.ejrad.2014.03.026}{10.1016/j.ejrad.2014.03.026}\\

\years{2016}G. Nadav, \textbf{G. Liberman}, M. Artzi, N. Kiryati and D. Ben Bashat, "Optimization of two-compartment-exchange-model analysis for dynamic contrast-enhanced mri incorporating bolus arrival time", \emph{Journal of Magnetic Resonance Imaging}. DOI: \href{http://dx.doi.org/10.1002/jmri.25362}{10.1002/jmri.25362}\\

\years{2013}\textbf{G. Liberman}, Y. Louzoun and D. Ben Bashat, “$T_1$ Mapping using Variable Flip Angle SPGR Data with Flip Angle Correction", \emph{Journal of Magnetic Resonance Imaging}   40: 171–180. DOI: \href{http://dx.doi.org/10.1002/jmri.24373}{10.1002/jmri.24373}\\
