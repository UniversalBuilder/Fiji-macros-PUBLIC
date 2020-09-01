
IJ.log("Initialize started...");
Initialize();
IJ.log("Initialize done.");
IJ.log("Detecting nuclei with Stardist2D...");
DetectNuclei("Nuclei");
IJ.log("Nuclei detected.");

function DetectNuclei(channel) {
	selectWindow(channel);
	run("Command From Macro", "command=[de.csbdresden.stardist.StarDist2D], args=['input':"+channel+", 'modelChoice':'Versatile (fluorescent nuclei)', 'normalizeInput':'true', 'percentileBottom':'1.0', 'percentileTop':'99.8', 'probThresh':'0.479071', 'nmsThresh':'0.3', 'outputType':'Both', 'nTiles':'1', 'excludeBoundary':'2', 'roiPosition':'Automatic', 'verbose':'false', 'showCsbdeepProgress':'false', 'showProbAndDist':'false'], process=[false]");
	selectWindow(channel);
	roiManager("Show All without labels");
}


function Initialize() {
	//Step 0: cleanup and sanity check
	roiManager("reset");
	run("Clear Results");
	run("Set Scale...", "distance=0 known=0 pixel=1 unit=pixel");

	//Step1: Getting image information
	ImageTitle = getTitle();
	run("Split Channels");
	Channel_1 = ImageTitle+" (red)";
	Channel_2 = ImageTitle+" (green)";
	Channel_3 = ImageTitle+" (blue)";
	selectWindow(Channel_1);
	rename("MR");
	selectWindow(Channel_2);
	rename("NCC");
	selectWindow(Channel_3);
	rename("Nuclei");
	}

function MeasureBand() {

	
	//Step4: Retrieve the nuclear envelope's boundaries and save them in the ROI-Manager
	numberOfNuclei = roiManager("count");
	for(i=0; i<numberOfNuclei; i++){
		roiManager("Select", i);
		run("Enlarge...", "enlarge=-10");
		run("Make Band...", "band=20");
		roiManager("Update"); //original nucleus-ROI is replaced by nuclear envelope ROI
	}
	
	//Step5: Measurements
	run("Set Measurements...", "area mean min display redirect=None decimal=3");
	selectWindow("signal");
	for(i=0; i<numberOfNuclei; i++){
		roiManager("Select", i);
		run("Measure");
		setResult("Image Name", i, ImageTitle);
	}
	updateResults;
	
	/* Alternative
	roiManager("Deselect"); // deselect all ROIs
	roiManager("Measure"); // measures all ROIs if none selected
	*/
	
	
	res_file_title = "Results_for_"+ImageTitle+".csv"; // .tsv works also
	saveAs('results', res_dir+res_file_title);
	print('results for '+ImageTitle+' saved in '+res_dir+res_file_title);
	
	//Step 6 cleanup
	run("Close All");
}