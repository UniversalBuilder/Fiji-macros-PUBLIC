
// 1/Set source directory
image_dir = getDirectory("Select image directory ");
image_list = getFileList(image_dir);
File.makeDirectory(image_dir);

// 2/Set up measurements and other parameters
run("Set Measurements...", "area mean min integrated display nan redirect=None decimal=9");

// 3/Iterate over every file in the source directory
		 for (i=0; i<image_list.length; i++){
				if (File.isDirectory(image_dir+image_list[i])){
                    // 3.0/Code to handle folders in source directory
					}
				else{
                    // 3.1/Open next image and enter batch mode
					path = image_dir+image_list[i];
					open(path);
					setBatchMode(true);

                    // 3.2/Code for processing image goes here. Sample code below
					run("Duplicate...", " ");
					setAutoThreshold("Mean dark");
					setOption("BlackBackground", false);
					run("Analyze Particles...", "size=500-Infinity show=Masks exclude add");
					saveAs("tiff", image_dir+ title + "_Mask");
					run("Close");
					selectWindow(title + ".tif");

                    // 3.3/Iterate measurement over each ROIs
					for (j=0; j<roiManager("count"); j++){
						roiManager("select", j)
						roiManager("Measure");
					}

                    // 3.4/Cleanup phase
                    roiManager("reset");
					selectWindow(title + ".tif");
					run("Close");
                    
                    // 3.5/Exit batch mode
					setBatchMode(false);
					}
			}

// 4/Save results and end macro
selectWindow("Results");
saveAs("Measurements", image_dir +"Results");
run("Close");
run("Close All");