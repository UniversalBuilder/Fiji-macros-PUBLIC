start = getTime();
run("HeLa Cells (48-bit RGB)");
run("Benchmark");
finish = getTime();
duration = finish-start;
IJ.log("Time : " +duration + " ms");