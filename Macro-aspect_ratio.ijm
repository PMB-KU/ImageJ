title= getTitle();
dir=getDirectory("current");

run("Line Width...", "line=5");
setForegroundColor(255, 0, 0);

if (isOpen("ROI Manager")) {
	selectWindow("ROI Manager");
	run("Close");
}
run("Select None");
run("Analyze Particles...", "size=0.5-Infinity show=Outlines exclude clear include add stack");

nROIs = roiManager("count");
print(nROIs+" ROIs!");

mask="Drawing of "+title;
selectWindow(mask);
selectWindow("ROI Manager");
run("Set Measurements...", "area redirect=None decimal=3");

for (i = 0; i < nROIs; i++) {
	roiManager("Select", i);
	getStatistics(area);
	run("Fit Rectangle");
	run("Measure");
	setResult("Area", i, area);
	run("Draw", "slice");
}
selectWindow(mask);
saveAs("Tiff",dir+mask);
//close();
res_ratio=dir+"Measurements-Ratio.csv";
saveAs("Results", res_ratio);
print("Ratio saved to" + res_ratio);