//version 1.0.4 (17/04/2024)

// Définir les noms des sous-dossiers
subFolders = newArray("0_Project_description", "1_Raw_images", "2_Processed_images", "3_Results", "4_Scripts");

// Définir le contenu des fichiers README.txt pour chaque sous-dossier
readmeContents = newArray(
  "Place in this folder any relevant documents, PDFs, articles, email exchanges, forms, or meeting notes allowing us to comprehend what the project is about and what is expected by the user.",
  "Place all raw images here.",
  "This folder is for storing all processed images.",
  "All results should be placed in this folder.",
  "Store all scripts used in this project in this folder."
);

// Définir les tags du projet
projectTags = newArray("Consulting", "Script or Automating", "Tutorial", "Long-term", "Multi-modal", "Review");

// Projects tags default settings
projectTagsDefaults = newArray(false, false, false, false, false, false);

// get current date as a string in the dd-mm-yyyy format
getDateAndTime(year, month, dayOfWeek, dayOfMonth, hour, minute, second, msec);
strmonth = "";
month += 1;
if(month < 10) {
	strmonth = "0"+d2s(month,0);
}
else strmonth = d2s(month,0);
currentdate = d2s(year,0)+ "." + strmonth + "." + d2s(dayOfMonth,0);

// Construire un dialogue pour demander les informations du client et du projet
Dialog.create("Info about the user and the project");
Dialog.addString("User first name: ", "");
Dialog.addString("User last name :", "");
Dialog.addString("Project date (aaaa.mm.jj): ", currentdate);
Dialog.addChoice("Project type: ", newArray("IMARIS", "FIJI", "QUPATH", "CELLPROFILER", "MULTI", "OTHER", "HRM-HUYGENS"), "IMARIS");
Dialog.addMessage("PROJECT TAGS");
Dialog.addCheckboxGroup(6, 1, projectTags, projectTagsDefaults);
Dialog.show();

// Récupérer les informations du client et du projet
prenom = Dialog.getString();
nom = Dialog.getString();
date = Dialog.getString();
type = Dialog.getChoice();
tags = newArray(6);
for (i=0; i<6; i++)
     tags[i] = Dialog.getCheckbox();

if (nom!="" && prenom!="" && date!="") {

  // Construire le nom du dossier principal à partir des informations
  mainFolder = date + "-" + prenom + "_" + nom + "_" + type;

  // Demander à l'utilisateur de choisir l'emplacement du dossier principal
  mainPath = getDirectory("Choose the main folder location");

  // Vérifier si l'utilisateur a choisi un emplacement valide
  if ( File.isDirectory(mainPath)) {
    // Créer le dossier principal
    mainDir = mainPath + mainFolder;
    File.makeDirectory(mainDir);

    // Créer les sous-dossiers et les fichiers README.txt
    for (i = 0; i < lengthOf(subFolders); i++) {
      subDir = mainDir + File.separator + subFolders[i];
      File.makeDirectory(subDir);
      File.saveString(readmeContents[i], subDir + File.separator + "README.txt");
    }

    // Créer le fichier JSON pour les tags du projet
    tagsJson = "{ \"tags\": [";
    //for (i = 0; i < lengthOf(tags); i++) {
    for (i = 0; i < lengthOf(tags); i++) {    	
      if (tags[i]) {
        tagsJson += "\"" + projectTags[i] + "\", ";
      }
    }
    // Remove the last comma and space, and close the JSON array
    tagsJson = tagsJson.substring(0, tagsJson.length() - 2) + "] }";
    File.saveString(tagsJson, mainDir + File.separator + "tags.json");

    // Afficher un message de confirmation
    showMessage("Folder " + mainFolder + " has been created successfully at " + mainPath);
  } else {
    // Afficher un message d'erreur
    showMessage("Path invalid");
  }
} else {
  // Afficher un message d'annulation
  showMessage("Fields have not been filled correctly");
}
