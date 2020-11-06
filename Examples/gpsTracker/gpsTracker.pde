String projectName = "lockdown";
String date = "2/11/2020"; // Date de début

// https://airtable.com/api
String baseID = ""; // ID de la base
String tableName = ""; // Nom du tableau Airtable
String apiKey = ""; // Clé API

PGraphics canvas;

void setup() {
  size(1440, 720);
  background(0);
  loadUI();
  fetch();
  canvas = createGraphics(width, height);
}

void draw() {
  background(0);

  canvas.beginDraw();
  canvas.background(0);

  //Parcourir les enregistrements et dessiner la dataviz
  for (int i = 0; i < selectedEvents.size(); i++) {

    // Afficher la répartition des évènements
    if (grid) {
      float pos = map(selectedEvents.get(i).datetime.getTime(), starting, ending, 0, width);
      canvas.stroke(255, 0, 0);
      canvas.line(pos, 0, pos, height);
    }

    selectedEvents.get(i).update();
    selectedEvents.get(i).display();
  }

  // Afficher les lignes entre les objets
  for (int i = 0; i < selectedEvents.size(); i++) {
    PVector next;
    PVector current = selectedEvents.get(i).walker.position;
    next = i<selectedEvents.size()-1 ? selectedEvents.get(i+1).walker.position : selectedEvents.get(0).walker.position;
    canvas.stroke(255);
    canvas.line(current.x, current.y, next.x, next.y);
  }
  canvas.endDraw();

  image(canvas, 0, 0);

  //debug();
  updateUI();
}
