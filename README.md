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
This code includes stuff from:\
SPM8 from https://www.fil.ion.ucl.ac.uk/spm/software/spm8/ \
NIFTI-Tools from https://www.mathworks.com/matlabcentral/fileexchange/8797-tools-for-nifti-and-analyze-image \
MRIcron from https://people.cas.sc.edu/rorden/mricron/index.html

# Contact
giladliberman@gmail.com

# Refs
\[1\] DUSTER: Dynamic contrast enhance up-sampled temporal resolution analysis method, *Magnetic Resonance Imaging*, DOI: [10.1016/j.mri.2015.12.014](http://dx.doi.org/10.1016/j.mri.2015.12.014)

\[2\] Optimization of DCE-MRI protocol for the assessment of patients with brain tumors, *Magnetic Resonance Imaging*, DOI: [10.1016/j.mri.2016.07.003](http://dx.doi.org/10.1016/j.mri.2016.07.003)

\[3\] Differentiation between Treatment-Related Changes and Progressive Disease in Patients with High Grade Brain Tumors using Support Vector Machine Classification based on DCE MRI, *Journal of Neuro-Oncology*, DOI: [10.1007/s11060-016-2055-7](http://dx.doi.org/10.1007/s11060-016-2055-7)

\[4\] Human cerebral blood volume measurements using dynamic contrast enhancement in comparison to dynamic susceptibility contrast MRI, *Neuroradiology*, DOI: [10.1007/s00234-015-1518-4](http://dx.doi.org/10.1007/s00234-015-1518-4)

\[5\] Classification of tumor area using combined DCE and DSC MRI in patients with glioblastoma, *Journal of Neuro-Oncology*, 34(4): 442–450. DOI: [10.1007/s11060-014-1639-3](http://dx.doi.org/10.1007/s11060-014-1639-3)

\[6\] Differentiation between *vasogenic-edema* versus *tumor-infiltrative* area in patients with glioblastoma during bevacizumab therapy: A longitudinal MRI study, *European Journal of Radiology*, DOI: [10.1016/j.ejrad.2014.03.026](http://dx.doi.org/10.1016/j.ejrad.2014.03.026)

\[7\] Optimization of two-compartment-exchange-model analysis for dynamic contrast-enhanced mri incorporating bolus arrival time, *Journal of Magnetic Resonance Imaging*, DOI: [10.1002/jmri.25362](http://dx.doi.org/10.1002/jmri.25362)

\[8\] T<sub>1</sub> Mapping using Variable Flip Angle SPGR Data with Flip Angle Correction, *Journal of Magnetic Resonance Imaging*, DOI: [10.1002/jmri.24373](http://dx.doi.org/10.1002/jmri.24373)
