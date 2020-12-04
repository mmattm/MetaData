String projectName = "meta datas";

String date = "4/11/2020"; // Date de début

// https://airtable.com/api
String baseID = ""; // ID de la base
String tableName = ""; // Nom du tableau Airtable
String apiKey = ""; // Clé API

boolean scanSerial = true;
boolean threshold = false;

void setup() {
  size(1280, 720);
  background(0);
  loadUI();
  setupMatrix();
  fetch();
}

void draw() {
  background(0);
 // debug();
  
  updateUI();
  updateMatrix();
}
