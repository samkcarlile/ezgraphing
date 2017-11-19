import javax.script.*;

//PUT YOUR NAME IN BETWEEN THE " " on the line below
String name = "mynamehere";
Graph graph = new Graph();
Colors colors = new Colors();

void setup()
{
  size(800, 600, P3D);
  //change the three numbers below to alter the background color
  background(255,255,255);
  
  // *** DEFINE FUNCTIONS BELOW HERE *** //
  graph.defineFunction("basic parabola", "y=pow(x,2)+2x-3");
  graph.defineFunction("more complex", "y=pow(x,2)");
  // *** DEFINE FUNCTIONS ABOVE HERE *** //
}

void draw()
{
  frameRate(1);
  translate(width/2, height/2, 0);
  rotateX(PI);
  //set to false to hide grid
  showGrid(true); 
  
  // *** DRAW FUNCTIONS BELOW HERE *** //
  graph.plotFunction("basic parabola", 0, 500);
  // *** DRAW FUNCTIONS ABOVE HERE *** //
  
}

// ************DO NOT EDIT BELOW THIS LINE. YOU'LL DESTROY THE MAGIC.************ //

// Graph class
public class Graph {
  
  HashMap<String, Function> funcs;
  ScriptEngineManager mgr; 
  ScriptEngine engine;
  
  public Graph() {
    funcs = new HashMap<String, Function>();
    mgr = new ScriptEngineManager();
    engine = mgr.getEngineByName("JavaScript");
  }
  
  //Defines a new function
  void defineFunction(String fName, String fString) {
    funcs.put(fName, new Function(fString, this));
  }
  
  //Draws the given function
  void drawFunction(String fName, float xMin, float xMax) {
    Function f = funcs.get(fName);
    //beginShape();
    for (float x = xMin; x <= xMax; x++) {
      float y = (float) f.exec(x);
      vertex(x,y);
    }
    //endShape();
  }
  void plotFunction(String fName, float xMin, float xMax) {
    Function f = funcs.get(fName);
    for (float x = xMin; x <= xMax; x++) {
      float y = (float) f.exec(x);
      point(x,y);
    }
  }
}
//Function class
public class Function {
  public String func;
  public Graph graph;
  public boolean drawn;
  
  public Function(String f, Graph g) {
    this.func = f;
    this.graph = g;
    this.drawn = false;
  }
  
  public String getFuncString(double x) {
    // Replace the x with the number and cut out y= from the start of the String.
    String newF = this.func.substring(2).replaceAll("x",x + "");
    // Replace the math functions shorthand.
    newF = newF.replaceAll("abs", "Math.abs").replaceAll("pow", "Math.pow").replaceAll("log","Math.log10").replaceAll("sqrt", "Math.sqrt");
    return newF;
  }
  
  double exec(double x) {
    Double y = null;
    try {
      String funcString = this.getFuncString(x);
      y = (Double) graph.engine.eval(funcString);
    } catch (Exception e) {
      e.printStackTrace();
    }
    return y;
  }
}

// Colors!!! Yay!!!
public class Colors {
  
  final color IVORY = color(255,255,240);
  final color BEIGE = color(245,245,220);
  final color WHEAT = color(245,222,179);
  final color TAN = color(210,180,140);
  final color KHAKI = color(195,176,145);
  final color SIVLER = color(192,192,192);
  final color GRAY = color(128,128,128);
  final color CHARCOAL = color(70,70,70);
  final color NAVY_BLUE = color(0,0,128);
  final color ROYAL_BLUE = color(8,76,158);
  final color MEDIUM_BLUE = color(0,0,205);
  final color AZURE = color(0,127,255);
  final color CYAN = color(0,255,255);
  final color AQUAMARINE = color(127,255,212);
  final color TEAL = color(0,128,128);
  final color FOREST_GREEN = color(34,139,34);
  final color OLIVE = color(128,128,0);
  final color CHARTREUSE = color(127,255,0);
  final color LIME = color(191,255,0);
  final color GOLDEN = color(255,215,0);
  final color GOLDENROD = color(218,165,32);
  final color CORAL = color(255,127,80);
  final color SALMON = color(250,128,114);
  final color HOT_PINK = color(252,15,192);
  final color FUCHSIA = color(255,119,255);
  final color PUCE = color(204,136,153);
  final color MAUVE = color(224, 176, 255);
  final color LAVENDER = color(181,126,220);
  final color PLUM = color(132, 49, 121);
  final color INDIGO = color(75,0,130);
  final color MAROON = color(126,0,0);
  final color CRIMSON = color(220,20,60);

  public Colors() {
    
  }
}

void showGrid(boolean isOn)
{
  if (isOn)
  {
    stroke(0);
    line(-width/2, 0, width/2, 0);
    line(0, -height/2, 0, height/2);
    for (int x=-width/2; x<width/2; x+= 20)
      line(x, 5, x, -5);
    for (int y=-height/2; y<height/2; y+=20)
      line(5, y, -5, y);
  }
}

void mouseClicked()
{
  println("File Saved");
  save(name+".jpg");
}


