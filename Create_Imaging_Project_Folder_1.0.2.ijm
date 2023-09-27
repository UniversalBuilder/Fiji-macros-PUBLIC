//version 1.0.2 (27/09/2023)

// Définir les noms des sous-dossiers
subFolders = newArray("1_Raw_images", "2_Processed_images", "3_Results", "4_Scripts");

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
Dialog.show();


// Récupérer les informations du client et du projet
prenom = Dialog.getString();
nom = Dialog.getString();
date = Dialog.getString();
type = Dialog.getChoice();

if (nom!="" && prenom!="" && date!="") {

  // Construire le nom du dossier principal à partir des informations
  //mainFolder = type + "_" + prenom + "_" + nom + "_" + date;
  mainFolder = date + "-" + prenom + "_" + nom + "_" + type;

  // Demander à l'utilisateur de choisir l'emplacement du dossier principal
 
  mainPath = getDirectory("Choose the main folder location");
  
 

  // Vérifier si l'utilisateur a choisi un emplacement valide
  if ( File.isDirectory(mainPath)) {
    // Créer le dossier principal
    mainDir = mainPath + mainFolder;
    File.makeDirectory(mainDir);

    // Créer les sous-dossiers
    for (i = 0; i < lengthOf(subFolders); i++) {
      subDir = mainDir + File.separator + subFolders[i];
      File.makeDirectory(subDir);
    }

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
