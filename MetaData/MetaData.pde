String projectName = "meta datas"; // Nom du projet
String date = "14/10/2020"; // Date de début

// https://airtable.com/api
String baseID = ""; // ID de la base
String tableName = ""; // Nom du tableau Airtable
String apiKey = ""; // Clé API

PGraphics canvas;

void setup() {
  size(1440, 720);
  background(0);
  fetch();
  loadUI();
  canvas = createGraphics(width, height);
}

void draw() {
  background(0);

  canvas.beginDraw();
  canvas.background(0);
  //Parcourir les enregistrements 
  for (int i = 0; i < selectedEvents.size(); i++) {
  }
  canvas.endDraw();
  image(canvas, 0, 0);

  //debug();
  updateUI();
}
