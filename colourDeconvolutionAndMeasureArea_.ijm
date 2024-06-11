// Script Description: Measure regions from a colour deconvolved image.
// Requirements : Colour_Deconvolution2 plugin
// Author: Yannick Krempp
// Date: 2024-06-11

// *** script parameters ***

ROLLING_RADIUS = 500; // Rolling ball radius for background subtraction
THRESHOLD_METHOD = "MaxEntropy"; // Thresholding method
MIN_SIZE = 30; // Minimum size of particles to be analyzed

// *** PREPROCESSING STEPS ***

// Set the desired measurements for analysis
run("Set Measurements...", "area standard redirect=None decimal=3");

// Reset the ROI manager
roiManager("reset");

// Get the ID of the original image
originalID = getImageID();

// *** COLOUR DECONVOLUTION STEPS ***

// Subtract background from the image
run("Subtract Background...", "rolling=" + ROLLING_RADIUS + " light sliding disable");

// Perform colour deconvolution
run("Colour Deconvolution2", "vectors=[User values] output=[RGB_Keep_C2] [r1]=0.11227720221571842 [g1]=0.27062192986383377 [b1]=0.9561158930482146 [r2]=0.1061794227905056 [g2]=0.791353241517514 [b2]=0.6020680836214442 [r3]=0.36511030955446117 [g3]=0.7357772909541171 [b3]=0.570373772164592");

// Convert the image to 8-bit
run("8-bit");

// *** ANALYSIS STEPS ***

// Set the threshold using MaxEntropy method
setAutoThreshold(THRESHOLD_METHOD + " no-reset");

// Set the option for black background
setOption("BlackBackground", true);

// Convert the image to a binary mask
run("Convert to Mask");

// Dilate the mask
run("Dilate");

// Analyze the particles in the image
run("Analyze Particles...", "size=" + MIN_SIZE + "-Infinity show=[Count Masks] clear summarize add composite");

// *** POSTPROCESSING STEPS ***

// Apply the glasbey LUT to the image
run("glasbey on dark");

// Get the ID of the count masks image
countMasksID =  getImageID();

// Select the original image
selectImage(originalID);

// Show all ROIs without labels
roiManager("Show All without labels");

// Tile the images
run("Tile");