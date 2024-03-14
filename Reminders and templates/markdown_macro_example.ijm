/*
# Simple Macro
Author: Yannick Krempp
Goal: Illustrate IJMMD 

Usage : 
1) Make sure you have the IJMMD plugin installed.
2) Open the script in Fiji's script editor.
3) Select "IJ1 Macro Markdown" as the language for the script instead of "ImageJ Macro"
4) Run the macro from the script
    
# Open the blobs.gif sample image and create a copy  
*/

run("Blobs (25K)");
run("Duplicate...", "title=original");
selectWindow("blobs.gif");

/*
## Pre-process the image  
Clean up noise and background
*/

run("Median...", "radius=5");
run("Subtract Background...", "rolling=50 light sliding");

/*
## Binarize the image
*/
setOption("BlackBackground", true);
run("Convert to Mask");  
  
/*
## Count the particles  
Use Glasbey to check for particle separation  
*/
run("Analyze Particles...", "  show=[Count Masks]");
run("glasbey on dark");

/*
## Display the results as an overlay on top of the original image  
*/
selectWindow("original");
run("Add Image...", "image=[Count Masks of blobs.gif] x=0 y=0 opacity=100 zero");
  
/*
## Auto-congratulation
Because we did a good job.  
<img src="https://i.imgflip.com/1qlmai.jpg" width="300">
*/