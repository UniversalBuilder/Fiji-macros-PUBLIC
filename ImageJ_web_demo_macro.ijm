run("HeLa Cells (48-bit RGB)");
run("Split Channels");
selectWindow("C3-hela-cells.tif");
setAutoThreshold("Default dark");
//run("Threshold...");
setAutoThreshold("Moments dark");
setAutoThreshold("Minimum dark");
setOption("BlackBackground", false);
run("Convert to Mask");
run("Fill Holes");
run("Analyze Particles...", "size=10-Infinity clear add");

