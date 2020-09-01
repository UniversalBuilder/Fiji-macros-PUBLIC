#@ UpdateService updateService

from ij import IJ
from ij.plugin.frame import RoiManager
from ij import WindowManager as wm

RM = RoiManager()        # we create an instance of the RoiManager class
rm = RM.getRoiManager()  # "activate" the RoiManager otherwise it can behave strangely 

if not updateService.getUpdateSite("StarDist").isActive():
    print "StarDist plugin required ! Please activate the StarDist update site."
    
def Initialize():
	#Step 0: cleanup and sanity check
	rm.runCommand("reset");
	IJ.run("Clear Results");
	IJ.run("Set Scale...", "distance=0 known=0 pixel=1 unit=pixel");

	#Step1: Getting image information
	ImageTitle = wm.getCurrentImage().getTitle();
	IJ.run("Split Channels");
	Channel_1 = ImageTitle+" (red)";
	Channel_2 = ImageTitle+" (green)";
	Channel_3 = ImageTitle+" (blue)";
	wm.getImage(Channel_1).setTitle("MR");
	wm.getImage(Channel_2).setTitle("NCC");
	wm.getImage(Channel_3).setTitle("Nuclei");

def DetectNuclei(channel):
	wm.getImage(channel);
	IJ.run("Command From Macro", "command=[de.csbdresden.stardist.StarDist2D], args=['input':"+channel+", 'modelChoice':'Versatile (fluorescent nuclei)', 'normalizeInput':'true', 'percentileBottom':'1.0', 'percentileTop':'99.8', 'probThresh':'0.479071', 'nmsThresh':'0.3', 'outputType':'Both', 'nTiles':'1', 'excludeBoundary':'2', 'roiPosition':'Automatic', 'verbose':'false', 'showCsbdeepProgress':'false', 'showProbAndDist':'false'], process=[false]");
	wm.getImage(channel);
	rm.runCommand("Show All without labels");

IJ.log("Initialize started...");
Initialize();
IJ.log("Initialize done.");
IJ.log("Detecting nuclei with Stardist2D...");
DetectNuclei("Nuclei");
IJ.log("Nuclei detected.");



