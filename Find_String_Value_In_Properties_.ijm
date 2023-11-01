//Yannick Krempp
//01/11/2023 - Yay habby BD to me.

//getting the coordinates (for instance) of one image from the info panel
run("Show Info...");
searchedStr = "Coordinate origin: ";
searchedLength = searchedStr.length;
str = getInfo("window.contents");
title = getInfo("window.title");
i1 = indexOf(str, searchedStr); //get the index of the key to the value to search for
i2 = indexOf(str, "\n", i1); // one key-value per line, so we detect the end by finding the next new line character
strCoords = substring(str, i1+searchedLength+1, i2);// length+1 because of the leading space character before the value
close(title);
//print("The coordinates are:"+strCoords); //a quick check to verify we have the right value

//applying the coordinates to another image (example code)
waitForUser("open a new image");
run("Properties...", "origin="+strCoords);