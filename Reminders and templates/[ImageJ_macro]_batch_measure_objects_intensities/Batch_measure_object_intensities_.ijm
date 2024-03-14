dir = getDirectory("Choose Source Directory ");
list = getFileList(dir);
File.makeDirectory(dir);
run("Set Measurements...", "area mean min integrated display nan redirect=None decimal=9");

		 for (i=0; i<list.length; i++){
				if (File.isDirectory(dir+list[i])){
					}
				else{
					path = dir+list[i];
					open(path);
					setBatchMode(true);
					roiManager("reset");
					title = File.nameWithoutExtension ;
					ID_original = getImageID();
					run("Properties...", "channels=1 slices=1 frames=1 unit=µm pixel_width=0.3700004 pixel_height=0.3700004 voxel_depth=10000.0000000");
					run("Duplicate...", " ");
					run("Subtract Background...", "rolling=50");
					setAutoThreshold("Mean dark");
					setOption("BlackBackground", false);
					run("Analyze Particles...", "size=500-Infinity show=Masks exclude add");
					run("Make Binary");
					run("Dilate");
					run("Fill Holes");
					run("Erode");
					run("Analyze Particles...", "size=500-Infinity show=Masks add");
					saveAs("tiff", dir+ title + "_Mask");
					selectImage(ID_original);
					
					for (j=0; j<roiManager("count"); j++){
						roiManager("select", j)
						roiManager("Measure");
					}
					
					roiManager("reset");
					close("*");
					setBatchMode(false);
					Table.save(dir+title+"_results.txt");
					}
			}