String projectName = "meta datas"; // Nom du projet
String date = "3/11/2020"; // Date de début

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
  for (int i = 0; i < events.size(); i++) {
  }
  int margin = 200;
  float n = int(ceil(sqrt(events.size())));
  float ecart_w = (width-margin) / n-1;
  float ecart_h = (height-margin) / n-1;

  int count = 0;


  SimpleDateFormat formatter = new SimpleDateFormat("dd/MM 'at' hh:mm");  


  for (int i = 0; i < n; i ++) {
    for (int a = 0; a < n; a ++) {

      if (count < selectedEvents.size()) {
        float dist = (float)distance(46.5372404, 6.5881771, selectedEvents.get(count).lat, selectedEvents.get(count).lon, "K");
        canvas.pushMatrix();
        canvas.translate(margin + ecart_w * a, margin + ecart_h * i);
        canvas.noStroke();
        canvas.circle(noise(count+ frameCount*0.05)*20, noise(count + frameCount*0.05, 100)*20, dist);
        canvas.fill(255);

        canvas.text(round(dist) + "km", 60, 0);
        String strDate = formatter.format(selectedEvents.get(count).datetime); 
        canvas.text(strDate, 60, 20);
        canvas.popMatrix();
      }

      count++;
    }
  }

  canvas.endDraw();
  image(canvas, 0, 0);

  //debug();
  updateUI();
}
