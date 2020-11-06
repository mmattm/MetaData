class EventObject {
  Date datetime;
  float lat;
  float lon;
  String address;
  Walker walker = new Walker();

  EventObject(Date _datetime, float _lat, float _lon) {
    // Constructor
    datetime = _datetime;
    lat = _lat;
    lon = _lon;

    JSONObject json;

    json = loadJSONObject("https://nominatim.openstreetmap.org/reverse?format=json&lat="+lat+"&lon="+lon+"&zoom=18&addressdetails=1");
    //println("geocode Event " + json); 
    JSONObject val = json.getJSONObject("address"); 
    address = val.getString("city");
    println(val);
    if (address == null) 
      address = val.getString("village");
    if (address == null) 
      address = val.getString("town");
      
    println(address);
  }

  void update() {
    walker.walk();
  }

  void display() {
    //float size = map(this.datetime.getTime(), starting, ending, 1, 1000);
    SimpleDateFormat formatter = new SimpleDateFormat("dd/MM 'at' hh:mm");  
    String strDate = formatter.format(this.datetime);  
    walker.display(address, strDate);
  }
}
