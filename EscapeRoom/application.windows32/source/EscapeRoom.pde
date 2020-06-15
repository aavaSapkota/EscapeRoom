//December 19,2018
//Aava Sapkota
//Ms.Krasteva
//ISP - Final Project: Escape Room

/*CREDITS: thank you to all who helped me during the process of the program
 - Alan Li: Timer&& charSelect control flow
 - Celest Luo: riddle inputes&& congratulatory window changes
 - Nathan Lu: Main Menu buttons
 - Andy Pham: taught about booleans to change states
 - gameDev CPT: Lessons on collision, states changes
 - Girls CPT: indepth mouse and key inputs
 - Ms.Krasteva: EVERYTHING ELSE
 - Yahoo Images: all downloaded imgaes (excluding the character)
 - wikibooks --> Java Programming --> Preventing null pointer exception
 - Nicole Han - mouseReleased() Paused fuction
 
 */


//Variable dictionary

//general
String state = "Start"; //Game dev --> States and Events lesson
int charSelect; //character selection
int level; // the level you are on
String startLevel; //starting level
boolean menuPressed = false;//if menu is pressed
//Fonts
PFont headingFont, bodyFont, subtextFont;
PFont TIMER_FONT;

//User Input Variables
char riddle_1, riddle_2, riddle_3;
String riddle1_Final, riddle2_Final, riddle3_Final;


//Background Images:
PImage goldenKey;
PImage goldenKey1;
PImage masks;

//Character images
//Level Select
PImage character1; 
PImage character2; 
PImage character3; 
PImage character4;
//Game Images:
//Character1   
PImage charRight, charLeft, charFront, charBack, charView; //character views

//Splash Screen Movement variables
//Movement
int ballXVel = 850;    //ball X movement
int ballYVel = 505;    //ball Y movement
int clawsUYVel = 0;  //Upper claw (upward)
int clawsDYVel = 0;  //Lower claw (downward)
int buttonYVel = 515;  //button movement

//Character Movement variables:
//Movement
int charX1Pos = 150; //Taught by Game Dev CPT
int charY1Pos = 350;
int charX2Pos = 100; 
int charY2Pos = 100;
int charX3Pos = 600; 
int charY3Pos = 350;
int charX4Pos = 350; 
int charY4Pos = 350;
int charXVel =0;  //character X movement
int charYVel = 0; //character Y movement

//Timer
int start;
int timer = millis()-start; //Alan Li
int minutes=0;
int secs;
boolean running = true;
int prevSecs; //Alan Li

//Conditions 
boolean gamePaused = false; //if game is paused
//Clues --> Dereck from CPT
boolean clue1_1 = true;
boolean clue1_2 = true;
boolean clue1_3 = true;
boolean hintFinal = true;
boolean clue1 = false;
boolean clue2 = false;
boolean clue3 = false;
boolean riddle = true;
boolean riddle1 = false;
boolean riddle2 = false;
boolean hint = false;
//Keys
//Level one (room 1)
boolean key1 = false;
boolean key1Pressed = false;
boolean keyToDoor1 = false; //Celeste Luo
//Level two (room 2)
boolean key2 = false;
boolean key2Pressed=false;
boolean keyToDoor2 = false;
//Level three (room 3)
boolean key3 = false;
boolean key3Pressed = false;
boolean keyToDoor3 = false;
//Boss Level (room 4)
boolean keyFinal = false;
boolean keyFinalPressed = false;
boolean keyToDoorFinal = false;

boolean charSELECTION = false;
int counter1=0; //Celeste Luo
int counter2=0;
int counter3=0;
int counter4_1=0;
int counter4_2=0;
int counter4_3=0;

//SCORE VARIABLES:
float score1, score2, score3, score4;

//Congrats variables
boolean congratsPressed;

void setup() {
  size(800, 550);
  start = millis(); //Alan Li
  frameRate(120);
}

void draw() { 
  if (!state.equals("goodbye")) {
    if (state.equals("Start")) {
      splashScreen();
    }

    //To main menu
    if (state.equals("title")|| clawsUYVel<=0&&clawsDYVel>=550) { 
      title();
      if (key == ' ') {
        state = "mainMenu";
      }
    } 
    display();
  } else {
    goodbye();
  }
} 

//Display 
void display() {
  
  //To main Menu
  if (state.equals("mainMenu")) {
    mainMenu();
  } else if (state.equals("instructions")) {
    instructions();
  }

  //Character Select Window
  if ("characterSelect".equals(state)&&charSELECTION ==true) {
    characterSelect();
    //Character Images:
    if (charSelect == 1) {
      charRight = loadImage("character1 right view.png");
      charLeft = loadImage("character1 left view.png");
      charFront = loadImage("character1 Front view.png");
      charBack = loadImage("character1 back view.png");
    } else if (charSelect == 2) {
      charRight = loadImage("character2 right view.png");
      charLeft = loadImage("character2 left view.png");
      charFront = loadImage("character2 front view.png");
      charBack = loadImage("character2 back view.png");
    } else if (charSelect == 3) {
      charRight = loadImage("character3 right view.png");
      charLeft = loadImage("character3 left view.png");
      charFront = loadImage("character3 front view.png");
      charBack = loadImage("character3 back view.png");
    } else if (charSelect == 4) {
      charRight = loadImage("character4 right view.png");
      charLeft = loadImage("character4 left view.png");
      charFront = loadImage("character4 front view.png");
      charBack = loadImage("character4 back view.png");
    }
  }

  //From Character Select to game
  if (charSelect>0) {
    //Character Movement
    if (keyPressed== true) {
      if (key == CODED) {
        if (keyCode == UP) {
          charYVel = -10;   
        } else if (keyCode == DOWN) {
          charYVel = 10;
        } else if (keyCode == RIGHT) {
          charXVel = 10;
        } else if (keyCode == LEFT) {
          charXVel = -10;
        }
      }
    }
    
    //Level Excecution
    if (level == 1&&keyToDoor1 == false&&gamePaused!=true) { //To level 1
      state = "LevelOne";
      running = true;
      room1Graphics();
      room1Game();
      if (clue1_1 == true) {  //taught by Derceck from CPT
        clue1_1();
      }
    } else if (level == 2&&keyToDoor2 == false&&gamePaused!=true) { //To level 2
      state = "LevelTwo";
      running = true;
      room2Graphics();
      room2Game();
      if (clue1_2 == true) {
        clue1_2();
      }
    } else if (level == 3&&keyToDoor3 == false&&gamePaused!=true) { //To level 3
      state = "LevelThree";
      running = true;
      room3Graphics();
      room3Game();
      if (clue1_3 == true) {
        clue1_3();
      }
    } else if (level == 4&&keyToDoorFinal==false&&gamePaused!=true) { //To boss level
      state = "LevelBoss";
      running = true;
      roomBossGraphics();
      roomBossGame();
      if (hintFinal == true) {
        hintFinal();
      }
    }
  }

  //Opening clue windows
  if (state.equals("clue2_1")&&clue1==true) {
    clue2_1();
  } else if (state.equals("clue3_1")&&clue2==true) {
    clue3_1();
  } else if (state.equals("riddle_1")&&clue3==true) {
    riddle_1();
  } else if (state.equals("clue2_2")&&clue1==true) {
    clue2_2();
  } else if (state.equals("clue3_2")&&clue2==true) {
    clue3_2();
  } else if (state.equals("riddle_2")&&clue3==true) {
    riddle_2();
  } else if (state.equals("clue2_3")&&clue1==true) {
    clue2_3();
  } else if (state.equals("clue3_3")&&clue2==true) {
    clue3_3();
  } else if (state.equals("riddle_3")&&clue3==true) {
    riddle_3();
  } else if (state.equals("riddle1_final")) {
    riddle1_final();
  } else if (state.equals("riddle2_final")&&riddle1==true) {
    riddle2_final();
  } else if (state.equals("riddle3_final")&&riddle2 ==true) {
    riddle3_final();
  }

  //Congraulatory Messages
  if (state.equals("congrats1")) {
    congratulatoryMessage1();
  } else if (state.equals("congrats2")) {
    congratulatoryMessage2();
  } else if (state.equals("congrats3")) {
    congratulatoryMessage3();
  } else if (state.equals("congratsFinal")) {
    congratulatoryMessageFinal();
  }


  //Pause state
  if (state.equals("paused")&&gamePaused == true) {
    pause();
  }

//To Congratulations message
  if (congratsPressed == true) {
    state = "congratsFinal";
  }

}

void mouseClicked() {
  //LOCAL VARIABLE DECLARATIONS
  //Main menu button Collisions
  int instructionXRadi = 290+210;
  int insturctionYRadi = 220+50;
  int startGameXRadi = 290+210;
  int startGameYRadi = 305+50;
  int exitXRadi = 340+100;
  int exitYRadi = 390+50;

  //Main Menu buttons
  if (state.equals("mainMenu")) { //Nathan Lu
    //mainMenu();
    if ((mouseX>=290&&mouseX<=instructionXRadi)&&(mouseY>=220&&mouseY<=insturctionYRadi)) {
      //To instructions
      state = "instructions";
    } else if ((mouseX>=290&&mouseX<=startGameXRadi)&&(mouseY>=305&&mouseY<=startGameYRadi)) {
      //To Level Selection
      state = "levelSelection";
    } else if ((mouseX>=340&&mouseX<=exitXRadi)&&(mouseY>=390&&mouseY<=exitYRadi)) {
      //Exit game
      state = "goodbye";
    }
  } 

  //Return to main menu from instructions
  if (state.equals("instructions")) {
    //Arrow range
    if (mouseX>=100&&mouseX<=280&&mouseY>=390&&mouseY<=450) {
      state = "mainMenu";
    }
  } 

  //Game Pause
  if (state.equals("LevelOne")) {
    if (mouseX>=10&&mouseX<=100&&mouseY>=10&&mouseY<=100) {
      state = "paused";
      gamePaused = true;
      running = false;
    }
  } else if (state.equals("LevelTwo")) {
    if (mouseX>=10&&mouseX<=100&&mouseY>=10&&mouseY<=100) {
      state = "paused";
      gamePaused = true;
      running = false;
    }
  } else if (state.equals("LevelThree")) {
    if (mouseX>=10&&mouseX<=100&&mouseY>=10&&mouseY<=100) {
      state = "paused";
      gamePaused = true;
      running = false;
    }
  } else if (state.equals("LevelBoss")) {
    if (mouseX>=10&&mouseX<=100&&mouseY>=450&&mouseY<=540) {
      state = "paused";
      gamePaused = true;
      running = false;
    }
  }

  //Paused buttons:
  if (state.equals("paused")) {
    if (mouseX>=300&&mouseX<=590&&mouseY>=330&&mouseY<=360) {
      running = true;
      gamePaused = false;
    } else if (mouseX>=300&mouseX<=590&&mouseY>=380&&mouseY<=410) {
      state = "mainMenu";
      gamePaused = false;
      menuPressed = true;
      charSelect = 0;
    }
  }


  //Go to main Menu from Congrats window
  if (state.equals("congrats1")||state.equals("congrats2")||state.equals("congrats3")||state.equals("congratsFinal")) {
    if (mouseX>=330&&mouseX<=480&&mouseY>=320&&mouseY<=360) {
      state = "mainMenu";
    }
  }

  //NextLevel from congratulatory message
  if (state.equals("congrats1")||state.equals("congrats2")||state.equals("congrats3")) {
    if (mouseX >= 330&&mouseX<=480&&mouseY>=380&&mouseY<= 420) {
      level++;
      clue2 = false;
      clue3 = false;
    }
    //Play again
  } else if (state.equals("congratsFinal")) {
    if (mouseX >= 330&&mouseX<=480&&mouseY>=380&&mouseY<= 420) {
      state = "levelSelection";
    }
  }
}

void mouseReleased() {
  //Level Select button collisions
  int level1XRadi = 330+140;
  int level1YRadi = 200+50;
  int level2XRadi = 330+140;
  int level2YRadi = 270+50;
  int level3XRadi = 330+140;
  int level3YRadi = 340+50;
  int level4XRadi = 307+190;
  int level4YRadi = 410+50;

  //From Level Selection to Character Selection
  if (state.equals("levelSelection")) {
    levelSelection();
    //Reseting variables
    start = millis();
    timer = 0;
    minutes = 0;
    charSelect = 0;
    level = 0;
    keyToDoor1 = false;
    keyToDoor2 = false;
    keyToDoor3 = false;
    keyToDoorFinal = false;
    key1= false;
    key2= false; 
    key3 = false;
    keyFinal = false;
    riddle1 = false;
    riddle2 = false;
    charX1Pos = 150; 
    charY1Pos = 350;
    charX2Pos = 100; 
    charY2Pos = 100;
    charX3Pos = 600; 
    charY3Pos = 350;
    charX4Pos = 350; 
    charY4Pos = 350;
    counter4_1 = 0; 
    counter4_2 = 0;
    counter4_3 = 0;
    
    //level One
    if (mouseX>=330&&mouseX<=level1XRadi&&mouseY>=200&&mouseY<=level1YRadi) {
      startLevel = "LevelOne";      
      level = 1; 
      state = "characterSelect";
      charSELECTION = true;
      //level Two
    } else if (mouseX>=330&&mouseX<=level2XRadi&&mouseY>=270&&mouseY<=level2YRadi) {
      startLevel = "levelTwo";
      level = 2;     
      state = "characterSelect";
      clue2 = false;
      clue3 = false;
      charSELECTION = true;
      //level Three
    } else if (mouseX>=330&&mouseX<=level3XRadi&&mouseY>=340&&mouseY<=level3YRadi) {
      startLevel = "levelThree";
      level = 3;
      state = "characterSelect";
      clue2 = false;
      clue3 = false;
      charSELECTION = true;
      //Boss Level
    } else if (mouseX>=307&&mouseX<=level4XRadi&&mouseY>=410&&mouseY<=level4YRadi) {
      startLevel = "levelBoss";
      level = 4;
      state = "characterSelect";
      clue2 = false;
      clue3 = false;
      charSELECTION = true;
    }
  }
}

void keyPressed() {

  if (state.equals("LevelOne")) { //Taught by Dereck C from CPT
    if (key==' ') {
      clue1_1 = false;
    }
  } else if (state.equals("LevelTwo")) {
    if (key == ' ') {
      clue1_2 = false;
    }
  } else if (state.equals("LevelThree")) {
    if (key == ' ') {
      clue1_3 = false;
    }
  } else if ( state.equals("LevelBoss")) {
    if (key == ' ') {
      hintFinal = false;
    }
  }
}

void keyReleased() {

  if (state.equals("LevelOne")||state.equals("LevelTwo")||state.equals("LevelThree")||state.equals("LevelBoss")) {  
    charXVel = 0;
    charYVel = 0;
  }
}



//User Input
void userInput() {
  if (state.equals("riddle_1")) {
    riddle_1 = getChar("Enter the letter that coresponds with the answer");
  } else if (state.equals("riddle_2")) {
    riddle_2 = getChar("Enter the letter that coresponds with the answer");
  } else if (state.equals("riddle_3")) {
    riddle_3 = getChar("Enter the letter that coresponds with the answer");
  } else if (state.equals("riddle1_final")) {
    riddle1_Final = getString("Enter your answer as one word");
  } else if (state.equals("riddle2_final")) {
    riddle2_Final = getString("Enter your answer as one word");
  } else if (state.equals("riddle3_final")) {
    riddle3_Final = getString("Enter your answer as one word");
  }
}

//MAIN PROCEDURES
void title() {
  //Variable Initilizations & Declarations
  PFont titleFont = loadFont("Georgia-Bold-60.vlw"); //local font 
  PFont continueFont = loadFont("Ebrima-30.vlw");
  headingFont = loadFont("Verdana-Bold-40.vlw");
  goldenKey = loadImage("bgKey.jpg"); // key in the background of opening, main menu etc.
  goldenKey1 = loadImage("bgKey1.jpg");
  masks = loadImage("mask.jpg"); //masks in the background of opening, main menu etc.

  background(60);

  rectMode(CORNER);
  //GRAPHICS
  //text
  noStroke();
  fill(255);
  rect(180, 120, 450, 250);
  //heading
  fill(#9D1E1E);
  stroke(#9D1E1E);
  strokeWeight(10);
  textFont(headingFont);
  text("ESCAPE ROOM", 240, 180);
  line(240, 190, 560, 190);
  //title
  textFont(titleFont);
  fill(0);
  text("-SPIES", 220, 250);
  text("EDITION-", 300, 330);
  //continue
  fill(255);
  textFont(continueFont);
  text("Press the spacebar to continue", 210, 410);

  //mask
  image(masks, 450, 200, 140, 70);

  //top side
  image(goldenKey, 50, 50, width/10, height/20);
  image(goldenKey, 200, 50, width/10, height/20);
  pushMatrix();
  translate(380, 100);
  rotate(radians(270));
  image(goldenKey, 0, 0, width/10, height/20);
  popMatrix();
  image(goldenKey1, 500, 50, width/10, height/20);
  image(goldenKey1, 680, 50, width/10, height/20);
  //right side
  image(goldenKey1, 680, 210, width/10, height/20);
  image(goldenKey1, 680, 330, width/10, height/20);
  //bottom side
  image(goldenKey1, 680, 460, width/10, height/20);
  image(goldenKey1, 500, 460, width/10, height/20);
  pushMatrix();
  translate(410, 440);
  rotate(radians(90));
  image(goldenKey, 0, 0, width/10, height/20);
  popMatrix();
  image(goldenKey, 200, 460, width/10, height/20);
  image(goldenKey, 50, 460, width/10, height/20);
  //left side
  image(goldenKey, 50, 210, width/10, height/20);
  image(goldenKey, 50, 330, width/10, height/20);

  //EVENTS
}

//Main Menu
void mainMenu() {  
  bodyFont = loadFont("YuGothic-Regular-35.vlw");
  headingFont = loadFont("Verdana-Bold-40.vlw");
  rectMode(CORNER);


  //GRAPHICS
  mainBackground();

  //TEXT
  noStroke();
  fill(255);
  rect(180, 120, 450, 250);
  //heading
  fill(#9D1E1E);
  stroke(#9D1E1E);
  strokeWeight(10);
  textFont(headingFont);
  text("~Main Menu~", 250, 180);
  line(280, 190, 530, 190);
  //body/options
  stroke(0);
  strokeWeight(5);
  textFont(bodyFont);
  //Instructions
  noFill();
  rect(290, 220, 210, 50);
  fill(0);
  text("Instructions", 300, 260);
  //Start Game
  noFill();
  rect(290, 305, 210, 50);
  fill(0);
  text("Start Game", 300, 345);
  //Exit
  noFill();
  rect(340, 390, 100, 50);
  fill(0);
  text("Exit", 360, 430); 
  //masks
  image(masks, 550, 100, 100, 50);
  image(masks, 170, 100, 100, 50);
}   

//How to Play
void instructions() {
  bodyFont = loadFont("Candara-Bold-25.vlw");
  headingFont = loadFont("Verdana-Bold-40.vlw");

  //GRAPHICS
  mainBackground();
  rect(130, 80, 570, 400);

  //TEXT
  noStroke();
  fill(255);
  rect(180, 120, 450, 250);
  //heading
  fill(#9D1E1E);
  stroke(#9D1E1E);
  strokeWeight(5);
  textFont(headingFont);
  text("~How to Play~", 235, 170);
  line(280, 180, 530, 180);
  //body
  fill(0);
  textFont(bodyFont); 
  text("You will enter multiple rooms all with one hint to", 150, 215);
  text("start you off and find the other two clues leading ", 150, 245);
  text("to a riddle. Once you find all the clues, click and ", 160, 275);
  text("drag the key to the door to unlock the door. ", 160, 305);
  text("Use the arrow keys to move your character  ", 165, 335);
  text("around and find the clues.", 280, 365);
  text("Good Luck!", 330, 395);

  //arrow
  noStroke();
  triangle(150, 420, 180, 410, 180, 430);
  stroke(30);
  line(180, 420, 230, 420);
  textFont(headingFont);
  textSize(20);
  text("Back ", 240, 425);

  //masks
  image(masks, 550, 100, 80, 40);
  image(masks, 170, 100, 80, 40);
}

//Level Selection
void levelSelection() {
  bodyFont = loadFont("YuGothic-Regular-35.vlw");
  headingFont = loadFont("Verdana-Bold-40.vlw");

  //GRAPHICS:
  //background
  mainBackground();

  //TEXT
  //heading
  fill(#9D1E1E);
  stroke(#9D1E1E);
  strokeWeight(5);
  textFont(headingFont);
  text("~Level Select~", 235, 170);
  line(280, 180, 530, 180);
  //masks
  image(masks, 550, 100, 80, 40);
  image(masks, 170, 100, 80, 40);

  textFont(bodyFont);
  stroke(0);
  //Level 1
  noFill();
  rect(330, 200, 140, 50);
  fill(0);
  text("Level 1", 340, 240);
  //Level 2
  noFill();
  rect(330, 270, 140, 50);
  fill(0);
  text("Level 2", 340, 310);
  //Level 3
  noFill();
  rect(330, 340, 140, 50);
  fill(0);
  text("Level 3", 340, 380);
  //Boss Level
  noFill();
  rect(307, 410, 190, 50);
  fill(0);
  text("Boss Level", 313, 450);
}

//Character Selection
void characterSelect() {
  //Local Variable Declartions and initializations
  headingFont = loadFont("SegoeUI-Semibold-30.vlw");
  character1 = loadImage("character 1.jpg"); 
  character2 = loadImage("character 2.jpg"); 
  character3 = loadImage("character 3.jpg"); 
  character4 = loadImage("character 4.jpg");
  //Character Select button Collision 
  int character1XRadi = 200;
  int character2XRadi = 200+200;
  int character3XRadi = 400+200;
  int character4XRadi = 600+200;

  //GRAPHICS
  //background
  stroke(0);
  strokeWeight(10);
  //character 1
  fill(#FAC997);
  rect(0, 0, 200, 550);
  //character 2
  fill(#FFF1A2);
  rect(200, 0, 200, 550);
  //character3
  fill(#6CE378);
  rect(400, 0, 200, 550);
  //character 4
  fill(#EF92F5);
  rect(600, 0, 200, 550);
  //Instructions box
  fill(255);
  rect(200, 0, 400, 50);

  //Characters
  image(character1, 20, 170, 160, 170);
  image(character2, 220, 170, 160, 170);
  image(character3, 420, 170, 160, 170);
  image(character4, 620, 170, 160, 170);

  //TEXT
  //heading
  textFont(headingFont);
  textSize(30);
  fill(0);
  text("Choose your character", 250, 35);
  if (mousePressed == true) {
    if (mouseX>=0&&mouseX<=character1XRadi&&mouseY>=0&&mouseY<=550) { //Select Character 1
      charSelect = 1;
    } else if (mouseX>=200&&mouseX<=character2XRadi&&mouseY>=0&&mouseY<=550) { //Select Character 2
      charSelect = 2;
    } else if (mouseX>=400&&mouseX<=character3XRadi&&mouseY>=0&&mouseY<=550) { //Select Charcter 3
      charSelect = 3;
    } else if (mouseX>=600&&mouseX<=character4XRadi&&mouseY>=0&&mouseY<=550) { //Select Character 4
      charSelect = 4;
    }
  }
}

//End Credits
void goodbye() {
  goldenKey = loadImage("bgKey.jpg"); // key in the background of opening, main menu etc.
  goldenKey1 = loadImage("bgKey1.jpg");
  bodyFont = loadFont("Candara-Bold-25.vlw");//Text Font

  //GRAPHICS:
  //background
  background(60);
  noStroke();
  fill(255);
  rect(160, 80, 500, 400);

  //keys
  //left side
  noFill();
  pushMatrix();
  translate(30, 200);
  rotate(radians(270));
  image(goldenKey, 0, 0, width/10, height/20);
  popMatrix();
  pushMatrix();
  translate(30, 350);
  rotate(radians(270));
  image(goldenKey, 0, 0, width/10, height/20);
  popMatrix();
  pushMatrix();
  translate(30, 500);
  rotate(radians(270));
  image(goldenKey, 0, 0, width/10, height/20);
  popMatrix();
  //right side
  pushMatrix();
  translate(740, 200);
  rotate(radians(270));
  image(goldenKey1, 0, 0, width/10, height/20);
  popMatrix();
  pushMatrix();
  translate(740, 350);
  rotate(radians(270));
  image(goldenKey1, 0, 0, width/10, height/20);
  popMatrix();
  pushMatrix();
  translate(740, 500);
  rotate(radians(270));
  image(goldenKey1, 0, 0, width/10, height/20);
  popMatrix();

  //TEXT
  //heading
  fill(#9D1E1E);
  stroke(#9D1E1E);
  strokeWeight(5);
  textFont(headingFont);
  text("Credits", 325, 150);
  line(310, 160, 500, 160);
  //masks
  image(masks, 550, 100, 80, 40);
  image(masks, 170, 100, 80, 40);
  //body
  fill(0);
  textFont(bodyFont); 
  textSize(30);
  text("Program Written by Aava Sapkota", 190, 220);
  text("Images Provided by Yahoo Images", 190, 270);
  text("Programing Lanuage:", 270, 325);
  text("Processing 3.4", 320, 360);
  text("THANK YOU FOR PLAYING", 260, 420);
}


//SplashScreen ***********************************************************************************************************************************
void splashScreen() {
  title();
  strokeWeight(4);
  ballXVel-=5;

  //GRAPHICS
  //claws 
  //Upper claw
  fill(100);
  stroke(0);
  beginShape();
  vertex(0, 275+clawsUYVel);
  vertex(100, 275+clawsUYVel);
  vertex(100, 225+clawsUYVel);
  vertex(200, 225+clawsUYVel);
  vertex(200, 275+clawsUYVel);
  vertex(300, 275+clawsUYVel);
  vertex(300, 225+clawsUYVel);
  vertex(400, 225+clawsUYVel);
  vertex(400, 275+clawsUYVel);
  vertex(500, 275+clawsUYVel);
  vertex(500, 225+clawsUYVel);
  vertex(600, 225+clawsUYVel);
  vertex(600, 275+clawsUYVel);
  vertex(700, 275+clawsUYVel);
  vertex(700, 225+clawsUYVel);
  vertex(800, 225+clawsUYVel);
  vertex(800, 0);
  vertex(0, 0);
  endShape(CLOSE);
  //Bottom claw
  beginShape();
  vertex(0, 275+clawsDYVel);
  vertex(100, 275+clawsDYVel);
  vertex(100, 225+clawsDYVel);
  vertex(200, 225+clawsDYVel);
  vertex(200, 275+clawsDYVel);
  vertex(300, 275+clawsDYVel);
  vertex(300, 225+clawsDYVel);
  vertex(400, 225+clawsDYVel);
  vertex(400, 275+clawsDYVel);
  vertex(500, 275+clawsDYVel);
  vertex(500, 225+clawsDYVel);
  vertex(600, 225+clawsDYVel);
  vertex(600, 275+clawsDYVel);
  vertex(700, 275+clawsDYVel);
  vertex(700, 225+clawsDYVel);
  vertex(800, 225+clawsDYVel);
  vertex(800, 550);
  vertex(0, 550);
  endShape(CLOSE);

  //ANIMATIONS
  //button
  fill(#DE3333);
  //button and ball speeds 
  if ((ballXVel<=470&&ballXVel>=415)) {
    buttonYVel += 5;
    ballXVel -= abs(ballXVel/200); //Justin S
  } else if (ballXVel>=500) {
    ballXVel-=5;
  } else if (ballXVel<=500) {
    ballXVel -= abs(ballXVel/10000);
  }
  //button pressed
  if (buttonYVel>=height) {
    clawsUYVel-=5; 
    clawsDYVel+=5;
  }

  //GRAPHICS (CONT)
  //ball
  ellipse(ballXVel+50, ballYVel, 75, 75);

  //button
  rect(425, buttonYVel, 60, 25); 
  rect(410, 540, 90, 10);

  if (ballXVel<=100) {
    state = "title";
  }
}


//LEVEL ONE ***************************************************************************************************************************************************
void room1Graphics() {
  //Local Image variables
  PImage couch = loadImage("couch.png");
  PImage carpet = loadImage("carpet.jpg");
  PImage playingCards = loadImage("cards_PNG8490.png");
  PImage singleCard = loadImage("playing-card-back.jpg");
  PImage tableChairs = loadImage("tableAndChairs.png");

  TIMER_FONT = loadFont("DialogInput.bold-48.vlw");

  //GRAPHICS
  fill(255);
  stroke(0);
  strokeWeight(2);
  rectMode(CORNER);
  background(200);

  //Walls
  fill(#AA3737);
  //left wall
  quad(0, 0, 100, 150, 100, 470, 0, 550);
  //right wall
  quad(800, 0, 700, 150, 700, 470, 800, 550);
  fill(#FA9930);
  //top wall
  quad(0, 0, 800, 0, 700, 150, 100, 150);
  fill(#83C169);
  //bottom wall
  quad(800, 550, 700, 470, 100, 470, 0, 550);

  //Carpet
  image(carpet, 120, 180, 560, 260);

  //Couch
  pushMatrix();
  translate(70, 390);
  rotate(radians(270));
  image(couch, 0, 0, 220, 180);
  popMatrix();

  //Door
  fill(#FA9930);
  quad(100, 380, 100, 460, 30, 480, 30, 360);
  fill(#27A4C9);
  //door knob
  ellipse(70, 390, 20, 15);


  //Plant
  //bush
  fill(#4DBC37);
  beginShape();
  vertex(615, 100);
  vertex(595, 90);
  vertex(600, 55);
  vertex(630, 60);
  vertex(640, 30);
  vertex(670, 45);
  vertex(675, 70);
  vertex(695, 65);
  vertex(705, 90);
  vertex(685, 100);
  endShape(CLOSE);

  //table
  fill(#D86E5E);
  ellipse(650, 140, 90, 60);
  //legs
  strokeWeight(5);
  line(605, 140, 605, 200);
  line(650, 170, 650, 200);
  line(695, 140, 695, 190);
  //pot
  strokeWeight(2);
  fill(#C62F18);
  quad(615, 100, 685, 100, 670, 150, 630, 150);

  //Coffe table
  fill(#AA3737);
  rect(280, 230, 170, 100, 15);
  //remote
  fill(0);
  rect(290, 250, 70, 25, 5);
  //buttons
  fill(#FF0808);
  ellipse(352, 257, 7, 7);
  fill(#E5C453);
  rect(332, 253, 6, 8, 3);
  rect(332, 263, 6, 8, 3);
  rect(325, 253, 6, 8, 3);
  rect(325, 263, 6, 8, 3);
  rect(318, 253, 6, 8, 3);
  rect(318, 263, 6, 8, 3);
  rect(311, 253, 6, 8, 3);
  rect(311, 263, 6, 8, 3);
  fill(#9FC2FA);
  rect(300, 255, 10, 5, 3);
  rect(300, 263, 10, 5, 3);
  stroke(#83E884);
  strokeWeight(2);
  point(297, 253);
  //playing cards
  image(playingCards, 315, 280, 45, 35);
  image(singleCard, 370, 280, 20, 30);

  //table and chairs
  pushMatrix();
  translate(700, 500);
  rotate(radians(180));
  image(tableChairs, 0, 0, 200, 200);
  popMatrix();

  //TV
  fill(0);
  stroke(0);
  quad(705, 200, 780, 180, 780, 450, 705, 440);
  fill(100);
  quad(710, 220, 770, 200, 770, 430, 710, 420);

  rectMode(CORNER);
  stroke(0);
  //Picture
  //frame
  fill(#7E4242);
  quad(90, 30, 200, 30, 180, 130, 110, 130);
  fill(#79BBFF);
  quad(100, 40, 190, 40, 170, 120, 120, 120);
  //tree
  fill(#AA3737);
  rect(135, 80, 20, 30);
  fill(#E3B235);
  quad(115, 100, 175, 100, 170, 120, 120, 120);
  fill(#2FB930);
  triangle(110, 50, 180, 50, 145, 90);

  //Clock
  fill(#6B9AE5);
  ellipse(500, 80, 100, 110);
  fill(#E5C453);
  ellipse(500, 80, 70, 80);
  //hands of clock
  fill(0);
  triangle(500, 42, 505, 57, 495, 57);
  line(500, 60, 500, 90);
  triangle(525, 79, 513, 78, 516, 88);
  line(517, 81, 500, 90);

  //Bookshelf
  fill(#A73524);
  rect(300, 480, 190, 70); 
  quad(300, 480, 490, 480, 450, 420, 340, 420);
  fill(#D1796B);
  quad(320, 470, 470, 470, 460, 455, 330, 455);  //top shelf
  quad(330, 450, 460, 450, 452, 440, 337, 440);  //middle shelf
  quad(340, 435, 450, 435, 445, 425, 345, 425);  //bottom shelf
  //books
  //top self
  fill(#30B92F);
  quad(360, 470, 380, 470, 380, 455, 360, 455);
  fill(#E3D130);
  quad(380, 470, 400, 470, 397, 455, 383, 455);
  fill(#3864CE);
  quad(420, 470, 440, 470, 440, 455, 420, 455);
  //middle shelf
  fill(#92AEF5);
  quad(350, 450, 380, 450, 375, 440, 355, 440); 
  fill(#2EF079);
  quad(400, 450, 420, 450, 415, 440, 405, 440);
  //bottom shelf
  fill(#E3D130);
  quad(405, 435, 430, 435, 425, 425, 410, 425);


  //Pause button
  noStroke();
  fill(#151AEA);
  ellipse(40, 40, 50, 50);
  fill(255);
  rect(30, 30, 5, 20);
  rect(45, 30, 5, 20);

  //Timer
  rectMode(CORNER);
  stroke(0);
  strokeWeight(3);
  fill(0);
  rect(110, 450, 150, 75, 10);
  fill(#E88175);
  rect(130, 460, 110, 60, 10);
}

void room1Game() { //Taught by Game Dev CPT
  charView = charRight;

//character views
if (keyPressed== true) {
      if (key == CODED) {
        if (keyCode == UP) {
          charView = charBack;
        } else if (keyCode == DOWN) {
          charView = charFront;
        } else if (keyCode == RIGHT) {
          charView = charRight;
        } else if (keyCode == LEFT) {
          charView = charLeft;
        }
      }
    }

  //Timer
  prevSecs = millis();
  secs=timer/1000;
  timer = millis()-start; //Alan Li


  //Character Movement
  charX1Pos += charXVel;
  charY1Pos += charYVel;

  //Character Movement
  image(charView, charX1Pos, charY1Pos, 100, 100);

  //EVENTS
  //Boundries
  if (charX1Pos<=100||charY1Pos<=150||(charY1Pos+170)>=470||(charX1Pos+100)>=700) {
    charXVel = 0;
    charYVel = 0;
  }
  //Clue collisions
  if (charX1Pos>=450&&charX1Pos<=550&&charY1Pos>=50&&charY1Pos<=150) {
    state = "clue2_1";     
    charYVel = 0;
    charXVel = 0;
  } else if (charX1Pos>=110&&charX1Pos<=180&&charY1Pos>=50&&charY1Pos<= 180) {
    state = "clue3_1";
    charYVel = 0;
    charXVel = 0;
  } else if (charX1Pos>=300&&charX1Pos<=400&&charY1Pos+100>=420&&charY1Pos+100<=500) {
    state = "riddle_1";
    charYVel = 0;
    charXVel = 0;
  }

  //Key appears 
  if (key1==true) {
    if (mouseX<=(300+width/10)&& mouseX>=300&&mouseY<=(280+height/20)&&mouseY>=280) {
      key1Pressed = true;
    }
  } else {
    key1Pressed = false;
  }

  if (key1Pressed == true) {
    image(goldenKey1, mouseX, mouseY, width/10, height/20);
    if (mouseX<=100&&mouseX>=30&& mouseY<=480&&mouseY>=360) {
      state = "congrats1";
      keyToDoor1 = true;
    }
  } else if (key1Pressed == false) {
    image(goldenKey1, 300, 280, width/10, height/20);
  }

  //TIMER -->Alan Li
  fill(0);
  textSize(35);
  if (running==true) {
    timer+=(millis()-prevSecs);
  } else {
    timer+=0;
  }

  if (secs>=59) {
    minutes = secs/60;
  }

  if (secs>=60) {
    secs%=60;
  }

  if (secs<10) {
    text(minutes+":", 140, 510);
    text("0"+secs, 180, 510);
  } else {
    text(minutes+":", 140, 510);
    text(secs, 180, 510);
  }
}

//LEVEL TWO****************************************************************************************
void room2Graphics() {
  //Local Image Variables
  PImage flooring = loadImage("tileFlooring.jpg"); //Image originally from gograph.com, found on Yahoo Images
  PImage tablesChairs = loadImage("stoolTable.png");
  PImage faucet = loadImage("faucet.png");

  //GRAPHICS
  fill(255);
  stroke(0);
  strokeWeight(2);
  rectMode(CORNER);

  //Flooring
  image(flooring, 100, 110, 200, 180);
  image(flooring, 300, 110, 200, 180);
  image(flooring, 500, 110, 200, 180);
  image(flooring, 100, 290, 200, 180);
  image(flooring, 300, 290, 200, 180);
  image(flooring, 500, 290, 200, 180);

  //Walls
  //left wall
  fill(#F2C718);
  quad(0, 0, 100, 110, 100, 470, 0, 550);
  //right wall
  quad(800, 0, 700, 110, 700, 470, 800, 550);
  //top wall
  fill(#D15B5B);
  quad(0, 0, 800, 0, 700, 110, 100, 110);
  //bottom wall
  fill(#73ABF2);
  quad(800, 550, 700, 470, 100, 470, 0, 550);

  //Door
  fill(#FFAC27);
  quad(120, 110, 90, 20, 210, 20, 180, 110);
  //door knob
  fill(#73ABF2);
  ellipse(175, 70, 15, 20);

  //Couter top
  fill(210);
  rect(270, 70, 350, 150); //top view
  fill(100);
  quad(270, 70, 250, 110, 250, 250, 270, 220); //side view
  quad(270, 220, 620, 220, 600, 250, 250, 250); //front view
  line(520, 250, 540, 220);

  //Kichen Mat
  fill(#F7B548);
  rect(270, 260, 180, 70, 10);
  //Pantry
  fill(#C47C39);
  rect(290, 430, 200, 80);
  fill(#F5B4B4);
  quad(290, 430, 490, 430, 460, 400, 320, 400);
  line(390, 430, 390, 400);
  //handles
  fill(#77C658);
  quad(365, 425, 380, 425, 377, 405, 368, 405);
  quad(400, 425, 415, 425, 412, 405, 403, 405);

  //Table and chairs
  image(tablesChairs, 200, 400, 75, 75);
  image(tablesChairs, 220, 320, 75, 75);
  image(tablesChairs, 100, 275, 75, 75);
  image(tablesChairs, 100, 300, 180, 180);

  //Stove
  fill(170);
  rect(620, 70, 120, 150); //top view
  quad(620, 220, 600, 250, 700, 250, 740, 220); //front view
  //stove top
  fill(210);
  ellipse(655, 105, 40, 40);
  ellipse(705, 105, 40, 40);
  ellipse(655, 160, 40, 40);
  ellipse(705, 160, 40, 40);
  fill(170);
  ellipse(655, 105, 20, 20);
  ellipse(705, 105, 20, 20);
  ellipse(655, 160, 20, 20);
  ellipse(705, 160, 20, 20);
  //heat controls
  fill(210);
  ellipse(640, 200, 15, 15);
  ellipse(665, 200, 15, 15);
  ellipse(693, 200, 15, 15);
  ellipse(720, 200, 15, 15);
  fill(170);
  ellipse(640, 200, 5, 5);
  ellipse(665, 200, 5, 5);
  ellipse(693, 200, 5, 5);
  ellipse(720, 200, 5, 5);

  //Sink
  fill(200);
  rect(300, 100, 100, 100);
  fill(170);
  rect(315, 115, 70, 70);
  line(300, 100, 315, 115);
  line(400, 100, 385, 115);
  line(400, 200, 385, 185);
  line(300, 200, 315, 185);
  //drain
  fill(210);
  ellipse(350, 150, 15, 15);
  fill(170);
  ellipse(350, 150, 5, 5);
  //faucet
  pushMatrix();
  translate(325, 20);
  rotate(radians(10));
  image(faucet, 0, 0, 70, 80);
  popMatrix();

  //Fridge
  fill(190);
  rect(500, 500, 190, 50);
  fill(210);
  quad(500, 500, 690, 500, 660, 420, 530, 420);//bottom component
  quad(500, 500, 690, 500, 675, 460, 515, 460);//top component
  //handles
  fill(170);
  quad(525, 490, 535, 490, 532, 470, 529, 470);  
  quad(545, 450, 555, 450, 552, 430, 549, 430);

  //Timer
  rectMode(CORNER);
  noStroke();
  fill(0);
  rect(110, 450, 150, 75, 10);
  fill(#E88175);
  rect(130, 460, 110, 60, 10);

  //Pause button
  noStroke();
  fill(#151AEA);
  ellipse(40, 40, 50, 50);
  fill(255);
  rect(30, 30, 5, 20);
  rect(45, 30, 5, 20);
}

void room2Game() {
  charView = charFront;
  
  if (keyPressed== true) {
      if (key == CODED) {
        if (keyCode == UP) {
          charView = charBack;
        } else if (keyCode == DOWN) {
          charView = charFront;
        } else if (keyCode == RIGHT) {
          charView = charRight;
        } else if (keyCode == LEFT) {
          charView = charLeft;
        }
      }
    }

  //TIMER
  secs=timer/1000;
  timer = millis()-start; //Alan Li
  prevSecs = millis();

  //Character Movement
  charX2Pos += charXVel;
  charY2Pos += charYVel;

  //Character Movement
  image(charView, charX2Pos, charY2Pos, 100, 100);

  //EVENTS
  //Boundries
  if (charX2Pos<=100||charY2Pos<=110||(charY2Pos+70)>=470||(charX2Pos+100)>=700) {
    charXVel = 0;
    charYVel = 0;
  }
  //Clue collisions
  if (charX2Pos>=600&&charX2Pos<=740&&charY2Pos>=150&&charY2Pos<=250) {//stove
    state = "clue2_2";
    charYVel = 0;
    charYVel = 0;
  } else if (charX2Pos>=300&&charX2Pos<=380&&charY2Pos>=150&&charY2Pos<=230) {//sink
    state = "clue3_2";
    charXVel = 0;
    charYVel = 0;
  } else if (charX2Pos>=530&&charX2Pos<=660&&charY2Pos+100<=420&&charY2Pos+100>=350) {//fridge
    state = "riddle_2";
    charYVel = 0;
    charXVel = 0;
  }

  //Key appears 
  if (key2==true) {
    if (mouseX<=(500+width/10)&& mouseX>=500&&mouseY<=(170+height/20)&&mouseY>=170) {
      key2Pressed = true;
    }
  } else {
    key2Pressed = false;
  }

  if (key2Pressed == true) {
    image(goldenKey1, mouseX, mouseY, width/10, height/20);
    if (mouseX<=210&&mouseX>=90&& mouseY<=110&&mouseY>=20) {
      state = "congrats2";
      keyToDoor2 = true;
    }
  } else if (key2Pressed == false) {
    image(goldenKey1, 500, 170, width/10, height/20);
  }

  //TIMER -->Alan Li
  fill(0);
  textSize(35);
  if (running==true) {
    timer+=(millis()-prevSecs);
  } else {
    timer+=0;
  }

  if (secs>=59) {
    minutes = secs/60;
  }

  if (secs>=60) {
    secs%=60;
  }

  if (secs<10) {
    text(minutes+":", 140, 510);
    text("0"+secs, 180, 510);
  } else {
    text(minutes+":", 140, 510);
    text(secs, 180, 510);
  }
}

//LEVEL THREE ***************************************************************
void room3Graphics() {
  //Local image variable declaration
  PImage hardwoodFloor = loadImage("hardwoodFloor.jpg");
  PImage roundTableChairs = loadImage("roundTables and chairs.png");
  PImage map = loadImage("Map.png");
  PImage diagram = loadImage("blackboard_Diagram.jpg");
  PFont yearFont = loadFont("ArialMT-48.vlw");

  //GRAPHICS
  strokeWeight(3);
  stroke(0);
  rectMode(CORNER);
  //Flooring
  image(hardwoodFloor, 100, 120, 600, 350);

  //Walls
  fill(#967AB7);
  quad(0, 0, 100, 120, 100, 470, 0, 550);//left wall
  quad(800, 0, 700, 120, 700, 470, 800, 550); //right wall
  fill(#91BC85);    
  quad(800, 550, 700, 470, 100, 470, 0, 550); //bottom wall
  quad(0, 0, 800, 0, 700, 120, 100, 120); //top wall


  //Door
  fill(#FA9B1E);
  quad(700, 450, 700, 380, 780, 360, 780, 470);
  //knob
  fill(#73ABF2);
  ellipse(730, 440, 20, 10);

  //Round table and chairs
  image(roundTableChairs, 260, 180, 270, 260);

  //Map
  image(map, 325, 270, 140, 70);
  //markers
  strokeWeight(1);
  fill(#F54F4F);
  rect(350, 280, 5, 10);
  fill(#6A7DF0);
  rect(360, 310, 5, 10);
  fill(#F06A9B);
  rect(390, 280, 5, 10);
  fill(#4D7AD3);
  rect(400, 300, 5, 10);
  fill(#4DD364);
  rect(430, 290, 5, 10);
  fill(#EA152E);
  rect(440, 320, 5, 10);

  //Drawer
  fill(#C6350C);
  strokeWeight(3);
  quad(650, 100, 620, 160, 620, 250, 650, 190);
  fill(#E38970);
  rect(650, 100, 80, 90);
  quad(650, 190, 620, 250, 700, 250, 730, 190);
  line(635, 130, 635, 215);
  strokeWeight(7);
  line(635, 160, 635, 180);

  //Chalk Board
  strokeWeight(3);
  fill(#0B4E50);
  quad(20, 70, 90, 130, 90, 460, 20, 510);
  //diagram 
  image(diagram, 30, 300, 50, 50);
  stroke(255);
  line(70, 360, 70, 390); //bottom description
  triangle(68, 365, 72, 365, 70, 360);
  line(60, 400, 60, 430);
  line(66, 400, 66, 415);
  line(70, 400, 70, 430);
  line(77, 400, 77, 430); 
  line(40, 290, 40, 250);//top left description
  triangle(38, 285, 42, 285, 40, 290);
  line(30, 240, 30, 200);
  line(36, 240, 36, 200);
  line(42, 240, 42, 220);
  line(49, 240, 49, 200);
  line(70, 280, 70, 240);//top right description
  triangle(68, 275, 72, 275, 70, 280);
  line(65, 230, 65, 190);
  line(71, 230, 71, 190);
  line(78, 230, 78, 200);
  //side description
  line(20, 140, 90, 180);
  line(40, 140, 40, 100);
  line(50, 142, 52, 110);
  line(65, 150, 70, 125);
  line(72, 152, 74, 130);

  //Blueprints
  stroke(0);
  fill(#4581DE);
  quad(370, 20, 660, 20, 620, 100, 400, 100);
  //plan diagrams
  stroke(255);
  quad(390, 30, 460, 30, 450, 60, 400, 60);
  quad(560, 50, 630, 50, 620, 80, 570, 80);
  fill(255);
  quad(400, 40, 410, 70, 430, 70, 435, 40);
  quad(630, 40, 615, 70, 595, 70, 595, 45);
  //arrows
  strokeWeight(2);
  line(460, 45, 480, 45); //top arrow facing left
  triangle(465, 42, 465, 48, 460, 45);
  line(455, 70, 475, 70); //bottom arrow facing left
  triangle(455, 67, 455, 73, 450, 70);
  line(555, 75, 535, 80); //arrow facing right
  triangle(550, 73, 552, 79, 555, 75);
  //descriptions
  strokeWeight(3);
  //top description
  line(490, 33, 525, 33);
  line(490, 40, 525, 40);
  line(490, 47, 517, 47);
  line(490, 54, 525, 54);
  //bottom description
  line(495, 70, 525, 70);
  line(495, 75, 525, 75);
  line(500, 80, 517, 80);
  line(495, 88, 525, 88);

  //Calendar
  stroke(0);
  fill(#CB5252);
  quad(120, 25, 350, 25, 320, 110, 150, 110);
  fill(#ADD1FF);
  quad(150, 50, 320, 50, 300, 100, 170, 100);
  //verticle lines
  line(165, 50, 185, 100);
  line(185, 50, 205, 100);
  line(205, 50, 215, 100);
  line(225, 50, 230, 100);
  line(245, 50, 240, 100);
  line(265, 50, 255, 100);
  line(285, 50, 270, 100);
  line(305, 50, 285, 100);
  //horrizontal
  line(155, 65, 315, 65);
  line(160, 77, 310, 77);
  line(165, 89, 305, 89);
  //specific date
  noFill();
  stroke(#F70710);
  ellipse(280, 85, 15, 10);
  //year
  textFont(yearFont);
  textSize(20);
  fill(0);
  text("12,019", 140, 43);

  //Timer
  stroke(0);
  fill(0);
  rect(110, 450, 150, 75, 10);
  fill(#E88175);
  rect(130, 460, 110, 60, 10);

  //Pause button
  noStroke();
  fill(#151AEA);
  ellipse(40, 40, 50, 50);
  fill(255);
  rect(30, 30, 5, 20);
  rect(45, 30, 5, 20);
}

void room3Game() {
  charView = charLeft;
  
  //character Views
  if (keyPressed== true) {
      if (key == CODED) {
        if (keyCode == UP) {
          charView = charBack;
        } else if (keyCode == DOWN) {
          charView = charFront;
        } else if (keyCode == RIGHT) {
          charView = charRight;
        } else if (keyCode == LEFT) {
          charView = charLeft;
        }
      }
    }

  //TIMER
  secs=timer/1000;
  timer = millis()-start; //Alan Li
  prevSecs = millis();

  //Character Movement
  charX3Pos += charXVel;
  charY3Pos += charYVel;


  //Character Movement
  image(charView, charX3Pos, charY3Pos, 100, 100);

  //EVENTS
  //Boundries
  if (charX3Pos<=100||charY3Pos<=100||(charY3Pos+70)>=470||(charX3Pos+100)>=700) {
    charXVel = 0;
    charYVel = 0;
  }
  //Clue collisions
  if (charX3Pos>=300&&charX3Pos<=450&&charY3Pos>=200&&charY3Pos<=360) {
    state = "clue2_3";
    charXVel = 0;
    charYVel = 0;
  } else if (charX3Pos>=400&&charX3Pos<=620&&charY3Pos>=100&&charY3Pos<=130) {
    state = "clue3_3";
    charXVel = 0;
    charYVel = 0;
  } else if (charX3Pos>=150&&charX3Pos<=320&&charY3Pos>=50&&charY3Pos<=140) {
    state = "riddle_3";
    charXVel = 0;
    charYVel = 0;
  }

  //Key appears 
  if (key3==true) {
    if (mouseX<=(650+width/10)&& mouseX>=650&&mouseY<=(150+height/20)&&mouseY>=150) {
      key3Pressed = true;
    }
  } else {
    key3Pressed = false;
  }

  if (key3Pressed == true) {
    image(goldenKey, mouseX, mouseY, width/10, height/20);
    if (mouseX<=780&&mouseX>=700&& mouseY<=470&&mouseY>=360) {
      state = "congrats2";
      keyToDoor3 = true;
    }
  } else if (key3Pressed == false) {
    image(goldenKey, 650, 150, width/10, height/20);
  }

  //TIMER -->Alan Li
  fill(0);
  textSize(35);
  if (running==true) {
    timer+=(millis()-prevSecs);
  } else {
    timer+=0;
  }

  if (secs>=59) {
    minutes = secs/60;
  }

  if (secs>=60) {
    secs%=60;
  }

  if (secs<10) {
    text(minutes+":", 140, 510);
    text("0"+secs, 180, 510);
  } else {
    text(minutes+":", 140, 510);
    text(secs, 180, 510);
  }
}

//Final Level ***************************************************************
void roomBossGraphics() {
  PFont sideTextFont = loadFont("Bahnschrift-48.vlw");

  //GRAPHICS
  stroke(0);
  background(#F5A802);
  fill(#E86E5B);
  rect(180, 0, 440, 250); 
  fill(#40C400);
  quad(0, 550, 800, 550, 620, 250, 180, 250);

  //Door 1 (left)
  fill(#934C46);
  rect(210, 10, 110, 230);
  //door knob
  fill(#FADF7E);
  stroke(0);
  ellipse(300, 120, 15, 20);
  //Door 2 (right)
  fill(#2AD8CB);
  rect(480, 10, 110, 230);
  //door knob
  fill(#FADF7E);
  stroke(0);
  ellipse(570, 120, 15, 20);
  //Final Door(middle)
  fill(#7E9AFA);
  stroke(255);
  rect(350, 10, 110, 230);  
  strokeWeight(5);
  line(350, 170, 380, 240);
  line(350, 130, 400, 240);
  line(350, 90, 420, 240);
  line(350, 50, 440, 240);
  line(350, 10, 460, 240);
  line(370, 10, 460, 200);
  line(390, 10, 460, 170);
  line(410, 10, 460, 130);
  line(430, 10, 460, 90);
  //door knob
  fill(#FADF7E);
  stroke(0);
  ellipse(440, 120, 15, 20);

  //Pause button
  noStroke();
  fill(#151AEA);
  ellipse(40, 500, 50, 50);
  fill(255);
  rect(30, 490, 5, 20);
  rect(45, 490, 5, 20);

  //Timer
  stroke(0);
  fill(0);
  rect(110, 450, 150, 75, 10);
  fill(#E88175);
  rect(130, 460, 110, 60, 10);

  //Wall Text
  textFont(sideTextFont);
  textSize(80);
  text("F", 10, 70);
  text("I", 20, 150);
  text("N", 10, 230);
  text("A", 15, 325);
  text("L", 10, 420);
  text("R", 730, 70);
  text("O", 730, 150);
  text("O", 730, 230);
  text("M", 730, 320);
}

void roomBossGame() {
  charView = charBack;
  
  //character Views
  if (keyPressed== true) {
      if (key == CODED) {
        if (keyCode == UP) {
          charView = charBack;
        } else if (keyCode == DOWN) {
          charView = charFront;
        } else if (keyCode == RIGHT) {
          charView = charRight;
        } else if (keyCode == LEFT) {
          charView = charLeft;
        }
      }
    }

  //TIMER
  secs=timer/1000;
  timer = millis()-start; //Alan Li
  prevSecs = millis();

  //Character Movement
  charX4Pos += charXVel;
  charY4Pos += charYVel;

//HELP 
  image(charView, charX4Pos, charY4Pos, 100, 100);

  //EVENTS
  //Boundries
  if (charX4Pos<=0||charY4Pos<=0||(charY4Pos+70)>=550||(charX4Pos+100)>=800) {
    charX4Pos = 350;
    charY4Pos = 300;
  }

  //Clue collisions
  if (charX4Pos>=210&&charX4Pos<=320&&charY4Pos>=100&&charY4Pos<=260) {
    state = "riddle1_final";
    charYVel = 0;
    charXVel = 0;
  } else if (charX4Pos>=480&&charX4Pos<=590&&charY4Pos>=100&&charY4Pos<=260) {
    state = "riddle2_final";
    charYVel = 0;
    charXVel = 0;
  } else if (charX4Pos>=350&&charX4Pos<=460&&charY4Pos>=100&&charY4Pos<=260) {
    state = "riddle3_final";
    charYVel = 0;
    charXVel = 0;
  }

  //Key appears 
  if (keyFinal==true) {
    if (mouseX<=(650+width/10)&& mouseX>=650&&mouseY<=(150+height/20)&&mouseY>=150) {
      keyFinalPressed = true;
    }
  } else {
    keyFinalPressed = false;
  }

  if (keyFinalPressed == true) {
    image(goldenKey, mouseX, mouseY, width/10, height/20);
    if (mouseX<=460&&mouseX>=350&& mouseY<=240&&mouseY>=10) {
      state = "congratsFinal";
      keyToDoorFinal = true;
    }
  } else if (keyFinalPressed == false) {
    image(goldenKey, 650, 150, width/10, height/20);
  }


  //TIMER -->Alan Li
  fill(0);
  textSize(35);
  if (running==true) {
    timer+=(millis()-prevSecs);
  } else {
    timer+=0;
  }

  if (secs>=59) {
    minutes = secs/60;
  }

  if (secs>=60) {
    secs%=60;
  }

  if (secs<10) {
    text(minutes+":", 140, 510);
    text("0"+secs, 180, 510);
  } else {
    text(minutes+":", 140, 510);
    text(secs, 180, 510);
  }
}



//CLUES************************************************************************************************************************************************
//Room 1 clue1
void clue1_1() {
  headingFont = loadFont("Consolas-Bold-55.vlw");
  bodyFont = loadFont("MongolianBaiti-48.vlw");
  subtextFont = loadFont("SegoeUI-Semibold-30.vlw");
  clue1 = true;

  //GRAPHICS
  stroke(0);
  strokeWeight(2);
  rectMode(CORNER);
  fill(100, 100);
  rect(0, 0, 800, 550);
  fill(255);
  rect(200, 125, 400, 300);
  fill(0);
  rect(200, 125, 400, 75);

  //Text
  //heading
  fill(255);
  textFont(headingFont);
  text("CLUE #1", 300, 180);

  //body(message)
  fill(0);
  textFont(bodyFont);
  textSize(40);
  text("What was once", 270, 250);
  text("measured by the ", 260, 290);
  text("sun, now uses hands.", 230, 330);

  //subtext
  textFont(subtextFont);
  textSize(25);
  text("Press the space bar to continue", 215, 380);
  textSize(20);
  text("Use the arrow keys to move around", 230, 400);
}

//Room 1 clue 2-----------------------------------------------------------------------------------------
void clue2_1() {
  headingFont = loadFont("Consolas-Bold-55.vlw");
  bodyFont = loadFont("MongolianBaiti-48.vlw");
  subtextFont = loadFont("SegoeUI-Semibold-30.vlw");
  clue2 = true;

  //GRAPHICS
  stroke(0);
  strokeWeight(2);
  rectMode(CORNER);
  fill(100, 100);
  rect(0, 0, 800, 550);
  fill(255);
  rect(200, 125, 400, 300);
  fill(0);
  rect(200, 125, 400, 75);

  //Text
  //heading
  fill(255);
  textFont(headingFont);
  text("CLUE #2", 300, 180);

  //body(message)
  fill(0);
  textFont(bodyFont);
  textSize(40);
  text("Creativity forever", 260, 250);
  text("displayed on ", 290, 290);
  text("canvas.", 340, 330);

  //subtext
  textFont(subtextFont);
  textSize(25);
  text("Move character away from ", 215, 380); 
  text("object to continue", 270, 400);
}

//Room 1 clue 3-----------------------------------------------------------------------------------------
void clue3_1() {
  headingFont = loadFont("Consolas-Bold-55.vlw");
  bodyFont = loadFont("MongolianBaiti-48.vlw");
  subtextFont = loadFont("SegoeUI-Semibold-30.vlw");
  clue3 = true;

  //GRAPHICS
  stroke(0);
  strokeWeight(2);
  rectMode(CORNER);
  fill(100, 100);
  rect(0, 0, 800, 550);
  fill(100, 100);
  rect(0, 0, 800, 550);
  fill(255);
  rect(200, 125, 400, 300);
  fill(0);
  rect(200, 125, 400, 75);

  //Text
  //heading
  fill(255);
  textFont(headingFont);
  text("CLUE #3", 300, 180);

  //body(message)
  fill(0);
  textFont(bodyFont);
  textSize(40);
  text("The pages of ", 300, 250);
  text("knowledge meeting", 250, 290);
  text("wood.", 340, 330);

  //subtext
  textFont(subtextFont);
  textSize(25);
  text("Move character away from", 215, 380);
  text("object to continue", 270, 400);
}

//Room 2 clue 1-----------------------------------------------------------------------------------------
void clue1_2() {
  headingFont = loadFont("Consolas-Bold-55.vlw");
  bodyFont = loadFont("MongolianBaiti-48.vlw");
  subtextFont = loadFont("SegoeUI-Semibold-30.vlw");
  clue1 = true;

  //GRAPHICS
  stroke(0);
  strokeWeight(2);
  rectMode(CORNER);
  fill(100, 100);
  rect(0, 0, 800, 550);
  fill(100, 100);
  rect(0, 0, 800, 550);
  fill(255);
  rect(200, 125, 400, 300);
  fill(0);
  rect(200, 125, 400, 75);

  //Text
  //heading
  fill(255);
  textFont(headingFont);
  text("CLUE #1", 300, 180);

  //body(message)
  fill(0);
  textFont(bodyFont);
  textSize(40);
  text("A combustion site", 260, 280);

  //subtext
  textFont(subtextFont);
  textSize(25);
  text("Press the space bar to continue", 225, 380);
  textSize(20);
  text("Use the arrow keys to move around", 230, 400);
}

//Room 2 clue 2-----------------------------------------------------------------------------------------
void clue2_2() {
  headingFont = loadFont("Consolas-Bold-55.vlw");
  bodyFont = loadFont("MongolianBaiti-48.vlw");
  subtextFont = loadFont("SegoeUI-Semibold-30.vlw");
  clue2 = true;

  //GRAPHICS
  stroke(0);
  strokeWeight(2);
  rectMode(CORNER);
  fill(100, 100);
  rect(0, 0, 800, 550);
  fill(100, 100);
  rect(0, 0, 800, 550);
  fill(255);
  rect(200, 125, 400, 300);
  fill(0);
  rect(200, 125, 400, 75);

  //Text
  //heading
  fill(255);
  textFont(headingFont);
  text("CLUE #2", 300, 180);

  //body(message)
  fill(0);
  textFont(bodyFont);
  textSize(40);
  text("Where fats and ", 280, 270);
  text("oils shouldn't go.", 270, 310);

  //subtext
  textFont(subtextFont);
  textSize(25);
  text("Move character away from", 215, 380);
  text("object to continue", 270, 400);
}
//Room 2 clue 3-----------------------------------------------------------------------------------------
void clue3_2() {
  headingFont = loadFont("Consolas-Bold-55.vlw");
  bodyFont = loadFont("MongolianBaiti-48.vlw");
  subtextFont = loadFont("SegoeUI-Semibold-30.vlw");
  clue3 = true;

  //GRAPHICS
  stroke(0);
  strokeWeight(2);
  rectMode(CORNER);
  fill(100, 100);
  rect(0, 0, 800, 550);
  fill(100, 100);
  rect(0, 0, 800, 550);
  fill(255);
  rect(200, 125, 400, 300);
  fill(0);
  rect(200, 125, 400, 75);

  //Text
  //heading
  fill(255);
  textFont(headingFont);
  text("CLUE #3", 300, 180);

  //body(message)
  fill(0);
  textFont(bodyFont);
  textSize(40);
  text("Water forms a", 280, 250);
  text("crystal formation", 260, 290);
  text("as it frezzes.", 300, 330);

  //subtext
  textFont(subtextFont);
  textSize(25);
  text("Move character away from", 215, 380);
  text("object to continue", 270, 400);
}

//Room 3 clue 1-----------------------------------------------------------------------------------------
void clue1_3() {
  headingFont = loadFont("Consolas-Bold-55.vlw");
  bodyFont = loadFont("MongolianBaiti-48.vlw");
  subtextFont = loadFont("SegoeUI-Semibold-30.vlw");
  clue1 = true;

  //GRAPHICS
  stroke(0);
  strokeWeight(2);
  rectMode(CORNER);
  fill(100, 100);
  rect(0, 0, 800, 550);
  fill(100, 100);
  rect(0, 0, 800, 550);
  fill(255);
  rect(200, 125, 400, 300);
  fill(0);
  rect(200, 125, 400, 75);

  //Text
  //heading
  fill(255);
  textFont(headingFont);
  text("CLUE #1", 300, 180);

  //body(message)
  fill(0);
  textFont(bodyFont);
  textSize(40);
  text("A state or nation.", 270, 280);

  //subtext
  textFont(subtextFont);
  textSize(25);
  text("Press space bar to continue", 230, 380);
  textSize(20);
  text("Use the arrow keys to move around", 230, 400);
}

//Room 3 clue 2-----------------------------------------------------------------------------------------
void clue2_3() {
  headingFont = loadFont("Consolas-Bold-55.vlw");
  bodyFont = loadFont("MongolianBaiti-48.vlw");
  subtextFont = loadFont("SegoeUI-Semibold-30.vlw");
  clue2 = true;

  //GRAPHICS
  stroke(0);
  strokeWeight(2);
  rectMode(CORNER);
  fill(100, 100);
  rect(0, 0, 800, 550);
  fill(100, 100);
  rect(0, 0, 800, 550);
  fill(255);
  rect(200, 125, 400, 300);
  fill(0);
  rect(200, 125, 400, 75);

  //Text
  //heading
  fill(255);
  textFont(headingFont);
  text("CLUE #2", 300, 180);

  //body(message)
  fill(0);
  textFont(bodyFont);
  textSize(40);
  text("Plans of the future", 260, 290);

  //subtext
  textFont(subtextFont);
  textSize(25);
  text("Move character away from", 215, 380);
  text("object to continue", 270, 400);
}

//Room 3 clue 3-----------------------------------------------------------------------------------------
void clue3_3() {
  headingFont = loadFont("Consolas-Bold-55.vlw");
  bodyFont = loadFont("MongolianBaiti-48.vlw");
  subtextFont = loadFont("SegoeUI-Semibold-30.vlw");
  clue3 = true;

  //GRAPHICS
  stroke(0);
  strokeWeight(2);
  rectMode(CORNER);
  fill(100, 100);
  rect(0, 0, 800, 550);
  fill(100, 100);
  rect(0, 0, 800, 550);
  fill(255);
  rect(200, 125, 400, 300);
  fill(0);
  rect(200, 125, 400, 75);

  //Text
  //heading
  fill(255);
  textFont(headingFont);
  text("CLUE #3", 300, 180);

  //body(message)
  fill(0);
  textFont(bodyFont);
  textSize(40);
  text("Human Existance", 260, 280);

  //subtext
  textFont(subtextFont);
  textSize(25);
  text("Move character away from", 215, 380);
  text("object to continue", 270, 400);
}

void hintFinal() {
  headingFont = loadFont("Consolas-Bold-55.vlw");
  bodyFont = loadFont("MongolianBaiti-48.vlw");
  subtextFont = loadFont("SegoeUI-Semibold-30.vlw");
  hint = true;

  //GRAPHICS
  stroke(0);
  strokeWeight(2);
  rectMode(CORNER);
  fill(100, 100);
  rect(0, 0, 800, 550);
  fill(100, 100);
  rect(0, 0, 800, 550);
  fill(255);
  rect(200, 125, 400, 300);
  fill(0);
  rect(200, 125, 400, 75);

  //Text
  //heading
  fill(255);
  textFont(headingFont);
  text("HINT", 330, 180);

  //body(message)
  fill(0);
  textFont(bodyFont);
  textSize(40);
  text("left, right, middle", 270, 280);
  textSize(25);
  text("Once the final door is activated", 240, 320); 
  text("use the key open it and win the game!", 220, 340);

  //subtext
  textFont(subtextFont);
  textSize(25);
  text("Press space bar to continue", 235, 380);
  textSize(20);
  text("Use the arrow keys to move around", 230, 400);
}


//RIDDLES *********************************************************************************************************************************
void riddle_1() {
  headingFont = loadFont("Consolas-Bold-55.vlw");
  bodyFont = loadFont("MongolianBaiti-48.vlw");
  subtextFont = loadFont("SegoeUI-Semibold-30.vlw");

  //GRAPHICS
  //stroke(0);
  //strokeWeight(2);
  //rectMode(CORNER);
  fill(100, 100);
  rect(0, 0, 800, 550);
  fill(255);
  rect(175, 100, 425, 300);
  fill(0);
  rect(175, 100, 425, 75);

  //TEXT
  //heading
  fill(255);
  textFont(headingFont);
  text("RIDDLE", 260, 160);

  //Body 
  textFont(bodyFont);
  fill(0);
  textSize(40);
  text("When did the first tv", 220, 220);
  text("go on sale?", 300, 260);
  //Options
  textSize(30);
  text("a) 1928", 320, 310);
  text("b) 1926", 320, 340);
  text("c) 1915", 320, 370);

  //User Input and answer check
  counter1++;
  if (counter1>3) {  //CELESTE Luo
    if (riddle_1 == 'a') {
      key1 = true;
      state = "LevelOne";
      correct();
    } else if (counter1==4) {//Celeste Luo
      userInput();
    } else {
      if (keyPressed == true) {//Celeste Luo
        if (key == ' ') {
          state = "riddle_1";
          userInput();
        }
      } else {
        errorTrap();
      }
    }
  }
}

//Room2 riddle -----------------------------------------------------------------------------------------
void riddle_2() {
  headingFont = loadFont("Consolas-Bold-55.vlw");
  bodyFont = loadFont("MongolianBaiti-48.vlw");
  subtextFont = loadFont("SegoeUI-Semibold-30.vlw");

  //GRAPHICS
  stroke(0);
  strokeWeight(2);
  rectMode(CORNER);
  fill(100, 100);
  rect(0, 0, 800, 550);
  fill(255);
  rect(175, 100, 425, 300);
  fill(0);
  rect(175, 100, 425, 75);

  //TEXT
  //heading
  fill(255);
  textFont(headingFont);
  text("RIDDLE", 260, 160);

  //Body 
  textFont(bodyFont);
  fill(0);
  textSize(40);
  text("How much freshwater", 210, 220);
  text("is trapped underground?", 200, 260);
  //Options
  textSize(30);
  text("a) 35%", 320, 310);
  text("b) 30%", 320, 340);
  text("c) 25%", 320, 370);
  
  //EVENTS
  //user Input and answer check
  counter2++;
  if (counter2>3) {  //CELESTE Luo
    if (riddle_2 == 'b') {
      key2 = true;
      state = "LevelTwo";
      correctFinal();
    } else if (counter2==4) {//Celeste Luo
      userInput();
    } else {      
      if (keyPressed == true) {//Celeste Luo
        if (key == ' ') {
          userInput();
        }
      } else {
        errorTrap();
      }
    }
  }
}

//Room3 riddle -----------------------------------------------------------------------------------------
void riddle_3() {
  headingFont = loadFont("Consolas-Bold-55.vlw");
  bodyFont = loadFont("MongolianBaiti-48.vlw");
  subtextFont = loadFont("SegoeUI-Semibold-30.vlw");


  //GRAPHICS
  stroke(0);
  strokeWeight(2);
  rectMode(CORNER);
  fill(100, 100);
  rect(0, 0, 800, 550);
  fill(255);
  rect(175, 100, 425, 300);
  fill(0);
  rect(175, 100, 425, 75);

  //TEXT
  //heading
  fill(255);
  textFont(headingFont);
  text("RIDDLE", 290, 160);

  //Body 
  textFont(bodyFont);
  fill(0);
  textSize(40);
  text("What does GPS", 260, 220);
  text("stand for.", 320, 260);
  //Options
  textSize(30);
  text("a) Global polar standard", 240, 310);
  text("b) Global positioning system", 240, 340);
  text("c) Gross Product Sum", 240, 370);


  //EVENTS
  //user Input and answer check
  counter3++;
  if (counter3>3) {  //CELESTE Luo
    if (riddle_3 == 'b') {
      key3 = true;
      state = "LevelThree";
      correctFinal();
    } else if (counter3==4) {//Celeste Luo
      userInput();
    } else {      
      if (keyPressed == true) {//Celeste Luo
        if (key == ' ') {
          userInput();
        }
      } else {
        errorTrap();
      }
    }
  }
}

//Final Riddles: **************************************************************************************
void riddle1_final() {
  headingFont = loadFont("Consolas-Bold-55.vlw");
  bodyFont = loadFont("MongolianBaiti-48.vlw");
  subtextFont = loadFont("SegoeUI-Semibold-30.vlw");

  //GRAPHICS
  stroke(0);
  strokeWeight(2);
  rectMode(CORNER);
  fill(100, 100);
  rect(0, 0, 800, 550);
  fill(255);
  rect(130, 100, 510, 350);
  fill(0);
  rect(130, 100, 510, 75);

  //TEXT
  //heading
  fill(255);
  textFont(headingFont);
  text("RIDDLE #1", 260, 160);

  //Body 
  textFont(bodyFont);
  fill(0);
  textSize(35);
  text("Sally's mother has 6 ", 250, 240);
  text("children, January, Febuary, ", 200, 280);
  text("March, April and May.", 220, 320);
  text("What is the name of the 6th child?", 150, 360);

  //EVENTS
  //user Input and answer check
  counter4_1++;
  if (counter4_1>7) {  //CELESTE Luo
    if (counter4_1==8) {//Celeste Luo
      userInput();
    }else if ("Sally".equals(riddle1_Final)||"sally".equals(riddle1_Final)) { //SOURCE: wikibooks --> Java Programming --> Preventing null pointer exception
      state = "levelBoss";
      riddle1 = true;
      correct();
    } else { 
      if (keyPressed == true) {//Celeste Luo
        if (key == ' ') {
          userInput();
        }
      } else {
        errorTrap();
      }
    }
  }
}

void riddle2_final() {
  headingFont = loadFont("Consolas-Bold-55.vlw");
  bodyFont = loadFont("MongolianBaiti-48.vlw");
  subtextFont = loadFont("SegoeUI-Semibold-30.vlw");

  //GRAPHICS
  stroke(0);
  strokeWeight(2);
  rectMode(CORNER);
  fill(100, 100);
  rect(0, 0, 800, 550);
  fill(255);
  rect(130, 100, 510, 350);
  fill(0);
  rect(130, 100, 510, 75);

  //TEXT
  //heading
  fill(255);
  textFont(headingFont);
  text("RIDDLE #2", 260, 160);

  //Body 
  textFont(bodyFont);
  fill(0);
  textSize(35);
  text("A cowboy takes his horse", 210, 220);
  text("to the next town over on", 220, 260);
  text("Saturday and stays there ", 220, 300);
  text("for 3 days, and returns on Friday.", 160, 340);
  text("What was the name of the horse", 180, 380);


  //EVENTS
  //user Input and answer check
  counter4_2++;
  if (counter4_2>7) {  //CELESTE Luo
    if (counter4_2==8) {//Celeste Luo
      userInput();
    }else if ("Friday".equals(riddle2_Final)||"friday".equals(riddle2_Final)) { //SOURCE: wikibooks --> Java Programming --> Preventing null pointer exception
      state = "levelBoss";
      riddle2 = true;
      correct();
    } else { 
      if (keyPressed == true) {//Celeste Luo
        if (key == ' ') {
          userInput();
        }
      } else {
        errorTrap();
      }
    }
  }
}

void riddle3_final() {
  headingFont = loadFont("Consolas-Bold-55.vlw");
  bodyFont = loadFont("MongolianBaiti-48.vlw");
  subtextFont = loadFont("SegoeUI-Semibold-30.vlw");

  //GRAPHICS
  stroke(0);
  strokeWeight(2);
  rectMode(CORNER);
  fill(100, 100);
  rect(0, 0, 800, 550);
  fill(255);
  rect(100, 80, 575, 370);
  fill(0);
  rect(100, 80, 575, 75);

  //TEXT
  //heading
  fill(255);
  textFont(headingFont);
  text("RIDDLE #3", 260, 140);

  //Body 
  textFont(bodyFont);
  fill(0);
  textSize(30);
  text("It was a warm sunny day in front of the ", 150, 200);
  text("wilmington's spherical house. The parents", 135, 230);
  text("had gone out for errands, the childen were", 130, 260);
  text("playing in the yard, the maid was cleaning", 130, 290);
  text("the corners of the house and the butler was", 125, 320);
  text("doing the dishes. That afternoon the children", 120, 350);
  text("were killed. Who killed the children?", 160, 380);

  //EVENTS
  //user Input and answer check
  counter4_3++;
  if (counter4_3>7) {  //CELESTE Luo
    if (counter4_3==8) {//Celeste Luo
      userInput();
    }else if ("maid".equals(riddle3_Final)||"Maid".equals(riddle3_Final)) { //SOURCE: wikibooks --> Java Programming --> Preventing null pointer exception
      level = 4;
      state = "levelBoss";
      keyFinal = true;
      correctFinal();
    } else {  
      if (keyPressed == true) {//Celeste Luo
        if (key == ' ') {
          userInput();
        }
      } else {
        errorTrap();
      }
    }
  }
}

void correctFinal() {  
  headingFont = loadFont("Consolas-Bold-55.vlw");
  bodyFont = loadFont("MongolianBaiti-48.vlw");
  subtextFont = loadFont("SegoeUI-Semibold-30.vlw");
  
  stroke(0);
  fill(255);
  rect(200, 150, 400, 260);
  fill(0);
  rect(200, 150, 400, 55);
  textSize(40);
  fill(#4ED68A);
  text("Correct!", 330, 195);
  
  //main text:
  fill(0);
  textFont(bodyFont);
  textSize(25);
  text("The Final Door has been activated!", 220, 240);
  text("Click and drag the key to the door", 225, 270);
  text("to complete the level!", 300, 300);
  
  //subtext
  fill(0);
  textFont(subtextFont);
  textSize(25);
  text("Move character away from", 245, 350);
  text("object to continue", 305, 380);
  
}
    
void correct() {  
  headingFont = loadFont("Consolas-Bold-55.vlw");
  bodyFont = loadFont("MongolianBaiti-48.vlw");
  subtextFont = loadFont("SegoeUI-Semibold-30.vlw");
  
  stroke(0);
  fill(255);
  rect(200, 150, 400, 260);
  fill(0);
  rect(200, 150, 400, 55);
  textSize(40);
  fill(#4ED68A);
  text("Correct!", 330, 195);
  
  //main text:
  fill(0);
  textFont(bodyFont);
  textSize(25);
  text("This door has been activated!", 250, 260);
  text("Move on to the next door",260, 290); 
  text("(remember the hint)", 280, 320);
  
  //subtext
  fill(0);
  textFont(subtextFont);
  textSize(25);
  text("Move character away from", 245, 350);
  text("object to continue", 305, 380);
  
}

//CONGRATULATORY MESSAGES:********************************************************************************************************************************
//Room 1
void congratulatoryMessage1() {
  //PFont and PImage Variables 
  headingFont = loadFont("Consolas-Bold-55.vlw");
  bodyFont = loadFont("MongolianBaiti-48.vlw");
  subtextFont = loadFont("SegoeUI-Semibold-30.vlw");
  goldenKey = loadImage("bgKey.jpg"); // key in the background of opening, main menu etc.
  goldenKey1 = loadImage("bgKey1.jpg");
  masks = loadImage("mask.jpg"); //masks in the background of opening, main menu etc.
  //Variables Inititalizations
  score1 = 1000-((minutes*60)+(secs*0.6));


  //Graphics
  //background
  background(60);
  noStroke();
  fill(255);
  rect(160, 110, 500, 340);
  //top side
  image(goldenKey, 50, 30, width/10, height/20);
  image(goldenKey, 250, 30, width/10, height/20);
  image(goldenKey, 450, 30, width/10, height/20);
  image(goldenKey, 650, 30, width/10, height/20);
  //rightSide
  pushMatrix();
  translate(750, 170);
  rotate(radians(270));
  image(goldenKey1, 0, 0, width/10, height/20);
  popMatrix();
  pushMatrix();
  translate(750, 320);
  rotate(radians(270));
  image(goldenKey1, 0, 0, width/10, height/20);
  popMatrix();
  pushMatrix();
  translate(750, 470);
  rotate(radians(270));
  image(goldenKey1, 0, 0, width/10, height/20);
  popMatrix();
  //bottom side
  image(goldenKey1, 50, 500, width/10, height/20);
  image(goldenKey1, 250, 500, width/10, height/20);
  image(goldenKey1, 450, 500, width/10, height/20);
  image(goldenKey1, 650, 500, width/10, height/20);
  //Left Side
  pushMatrix();
  translate(50, 170);
  rotate(radians(270));
  image(goldenKey, 0, 0, width/10, height/20);
  popMatrix();
  pushMatrix();
  translate(50, 320);
  rotate(radians(270));
  image(goldenKey, 0, 0, width/10, height/20);
  popMatrix();
  pushMatrix();
  translate(50, 470);
  rotate(radians(270));
  image(goldenKey, 0, 0, width/10, height/20);
  popMatrix();

  //TEXT
  //heading
  fill(#9D1E1E);
  stroke(#9D1E1E);
  strokeWeight(5);
  textFont(headingFont);
  textSize(40);
  text("Congratulations", 250, 180);
  line(250, 190, 570, 190);
  textSize(30);
  text("YOU PASSED ROOM 1", 265, 220);
  //masks
  image(masks, 565, 120, 80, 40);
  image(masks, 170, 120, 80, 40);

  //Score
  textFont(subtextFont);
  fill(0);
  text("Score: "+score1, 320, 270);  
  text("Timer: "+minutes+":"+secs, 315, 300);
  //buttons
  textSize(25);
  text("Main Menu", 340, 350);
  text("Next Level", 345, 410);
  noFill();
  stroke(0);
  //Main Menu
  rect(330, 320, 150, 40);
  //Next Level
  rect(330, 380, 150, 40);
}
//Room 2---------------------------------------------------------------------------------------------------
void congratulatoryMessage2() {
  //PFont and PImage Variabels
  headingFont = loadFont("Consolas-Bold-55.vlw");
  bodyFont = loadFont("MongolianBaiti-48.vlw");
  subtextFont = loadFont("SegoeUI-Semibold-30.vlw");
  goldenKey = loadImage("bgKey.jpg"); // key in the background of opening, main menu etc.
  goldenKey1 = loadImage("bgKey1.jpg");
  masks = loadImage("mask.jpg"); //masks in the background of opening, main menu etc.
  //Variable Initilizations
  score2 = 1000-((minutes*60)+(secs*0.6));

  //Graphics
  //background
  background(60);
  noStroke();
  fill(255);
  rect(160, 110, 500, 340);
  //top side
  image(goldenKey, 50, 30, width/10, height/20);
  image(goldenKey, 250, 30, width/10, height/20);
  image(goldenKey, 450, 30, width/10, height/20);
  image(goldenKey, 650, 30, width/10, height/20);
  //rightSide
  pushMatrix();
  translate(750, 170);
  rotate(radians(270));
  image(goldenKey1, 0, 0, width/10, height/20);
  popMatrix();
  pushMatrix();
  translate(750, 320);
  rotate(radians(270));
  image(goldenKey1, 0, 0, width/10, height/20);
  popMatrix();
  pushMatrix();
  translate(750, 470);
  rotate(radians(270));
  image(goldenKey1, 0, 0, width/10, height/20);
  popMatrix();
  //bottom side
  image(goldenKey1, 50, 500, width/10, height/20);
  image(goldenKey1, 250, 500, width/10, height/20);
  image(goldenKey1, 450, 500, width/10, height/20);
  image(goldenKey1, 650, 500, width/10, height/20);
  //Left Side
  pushMatrix();
  translate(50, 170);
  rotate(radians(270));
  image(goldenKey, 0, 0, width/10, height/20);
  popMatrix();
  pushMatrix();
  translate(50, 320);
  rotate(radians(270));
  image(goldenKey, 0, 0, width/10, height/20);
  popMatrix();
  pushMatrix();
  translate(50, 470);
  rotate(radians(270));
  image(goldenKey, 0, 0, width/10, height/20);
  popMatrix();

  //TEXT
  //heading
  fill(#9D1E1E);
  stroke(#9D1E1E);
  strokeWeight(5);
  textFont(headingFont);
  textSize(40);
  text("Congratulations", 250, 180);
  line(250, 190, 570, 190);
  textSize(30);
  text("YOU PASSED ROOM 2", 265, 220);
  //masks
  image(masks, 565, 120, 80, 40);
  image(masks, 170, 120, 80, 40);

  //Score
  textFont(subtextFont);
  fill(0);
  text("Score: "+score2, 320, 270);  
  text("Timer: "+minutes+":"+secs, 315, 300);
  //buttons
  textSize(25);
  text("Main Menu", 340, 350);
  text("Next Level", 345, 410);
  noFill();
  stroke(0);
  rect(330, 320, 150, 40);
  rect(330, 380, 150, 40);
}
//Room 3 ----------------------------------------------------------------------------------------------------
void congratulatoryMessage3() {
  //PFont and PImage Variables
  headingFont = loadFont("Consolas-Bold-55.vlw");
  bodyFont = loadFont("MongolianBaiti-48.vlw");
  subtextFont = loadFont("SegoeUI-Semibold-30.vlw");
  goldenKey = loadImage("bgKey.jpg"); // key in the background of opening, main menu etc.
  goldenKey1 = loadImage("bgKey1.jpg");
  masks = loadImage("mask.jpg"); //masks in the background of opening, main menu etc.
  //Variables initializations
  score3 = 1000-((minutes*60)+(secs*0.6));

  //Graphics
  //background
  background(60);
  noStroke();
  fill(255);
  rect(160, 110, 500, 340);
  //top side
  image(goldenKey, 50, 30, width/10, height/20);
  image(goldenKey, 250, 30, width/10, height/20);
  image(goldenKey, 450, 30, width/10, height/20);
  image(goldenKey, 650, 30, width/10, height/20);
  //rightSide
  pushMatrix();
  translate(750, 170);
  rotate(radians(270));
  image(goldenKey1, 0, 0, width/10, height/20);
  popMatrix();
  pushMatrix();
  translate(750, 320);
  rotate(radians(270));
  image(goldenKey1, 0, 0, width/10, height/20);
  popMatrix();
  pushMatrix();
  translate(750, 470);
  rotate(radians(270));
  image(goldenKey1, 0, 0, width/10, height/20);
  popMatrix();
  //bottom side
  image(goldenKey1, 50, 500, width/10, height/20);
  image(goldenKey1, 250, 500, width/10, height/20);
  image(goldenKey1, 450, 500, width/10, height/20);
  image(goldenKey1, 650, 500, width/10, height/20);
  //Left Side
  pushMatrix();
  translate(50, 170);
  rotate(radians(270));
  image(goldenKey, 0, 0, width/10, height/20);
  popMatrix();
  pushMatrix();
  translate(50, 320);
  rotate(radians(270));
  image(goldenKey, 0, 0, width/10, height/20);
  popMatrix();
  pushMatrix();
  translate(50, 470);
  rotate(radians(270));
  image(goldenKey, 0, 0, width/10, height/20);
  popMatrix();

  //TEXT
  //heading
  fill(#9D1E1E);
  stroke(#9D1E1E);
  strokeWeight(5);
  textFont(headingFont);
  textSize(40);
  text("Congratulations", 250, 180);
  line(250, 190, 570, 190);
  textSize(30);
  text("YOU PASSED ROOM 3", 265, 220);
  //masks
  image(masks, 565, 120, 80, 40);
  image(masks, 170, 120, 80, 40);

  //Score
  textFont(subtextFont);
  fill(0);
  text("Score: "+score3, 320, 270);  
  text("Timer: "+minutes+":"+secs, 315, 300);
  //buttons
  textSize(25);
  text("Main Menu", 340, 350);
  text("Next Level", 345, 410);
  noFill();
  stroke(0);
  rect(330, 320, 150, 40);
  rect(330, 380, 150, 40);
}
//Boss Room ----------------------------------------------------------------------------------------------------------
void congratulatoryMessageFinal() {
  //PFont and PImage Variables
  headingFont = loadFont("Consolas-Bold-55.vlw");
  bodyFont = loadFont("MongolianBaiti-48.vlw");
  subtextFont = loadFont("SegoeUI-Semibold-30.vlw");
  goldenKey = loadImage("bgKey.jpg"); // key in the background of opening, main menu etc.
  goldenKey1 = loadImage("bgKey1.jpg");
  masks = loadImage("mask.jpg"); //masks in the background of opening, main menu etc.
  //Variable Initialization:
  score4 = 1000-((minutes*60)+(secs*0.6));
  //Local Variables
  float scoreFinal = score1+score2+score3+score4;


  //Graphics
  //background
  background(60);
  noStroke();
  fill(255);
  rect(160, 110, 500, 340);
  //top side
  image(goldenKey, 50, 30, width/10, height/20);
  image(goldenKey, 250, 30, width/10, height/20);
  image(goldenKey, 450, 30, width/10, height/20);
  image(goldenKey, 650, 30, width/10, height/20);
  //rightSide
  pushMatrix();
  translate(750, 170);
  rotate(radians(270));
  image(goldenKey1, 0, 0, width/10, height/20);
  popMatrix();
  pushMatrix();
  translate(750, 320);
  rotate(radians(270));
  image(goldenKey1, 0, 0, width/10, height/20);
  popMatrix();
  pushMatrix();
  translate(750, 470);
  rotate(radians(270));
  image(goldenKey1, 0, 0, width/10, height/20);
  popMatrix();
  //bottom side
  image(goldenKey1, 50, 500, width/10, height/20);
  image(goldenKey1, 250, 500, width/10, height/20);
  image(goldenKey1, 450, 500, width/10, height/20);
  image(goldenKey1, 650, 500, width/10, height/20);
  //Left Side
  pushMatrix();
  translate(50, 170);
  rotate(radians(270));
  image(goldenKey, 0, 0, width/10, height/20);
  popMatrix();
  pushMatrix();
  translate(50, 320);
  rotate(radians(270));
  image(goldenKey, 0, 0, width/10, height/20);
  popMatrix();
  pushMatrix();
  translate(50, 470);
  rotate(radians(270));
  image(goldenKey, 0, 0, width/10, height/20);
  popMatrix();

  //TEXT
  //heading
  fill(#9D1E1E);
  stroke(#9D1E1E);
  strokeWeight(5);
  textFont(headingFont);
  textSize(40);
  text("Congratulations", 250, 180);
  line(250, 190, 570, 190);
  textSize(25);
  text("YOU PASSED THE FINAL ROOM", 240, 220);
  //masks
  image(masks, 565, 120, 80, 40);
  image(masks, 170, 120, 80, 40);

  //Score
  textFont(subtextFont);
  fill(0);
  text("Score: "+scoreFinal, 320, 270);  
  text("Timer: "+minutes+":"+secs, 315, 300);
  //buttons
  textSize(25);
  text("Main Menu", 340, 350);
  text("Play Again", 345, 410);
  noFill();
  stroke(0);
  rect(330, 320, 150, 40);
  rect(330, 380, 150, 40);
}


//ERROR TRAP*******************************************************************************************************************************
void errorTrap() {
  //Font variable Initializations
  headingFont = loadFont("Consolas-Bold-55.vlw");
  bodyFont = loadFont("MongolianBaiti-48.vlw");
  subtextFont = loadFont("SegoeUI-Semibold-30.vlw");

  //GRAPHICS
  stroke(0);
  strokeWeight(2);
  rectMode(CORNER);
  fill(100, 100);
  rect(0, 0, 800, 550);
  fill(255);
  rect(200, 125, 400, 300);
  fill(0);
  rect(200, 125, 400, 75);
  //crossed out circles
  //left
  noFill();
  strokeWeight(10);
  stroke(#D14141);
  ellipse(275, 165, 50, 50);
  line(260, 150, 290, 180);
  //right
  ellipse(525, 165, 50, 50);
  line(510, 150, 540, 180);
  //TEXT
  //heading
  fill(255);
  textFont(headingFont);
  text("ERROR", 325, 180);
  //body(message)
  fill(0);
  textFont(bodyFont);
  textSize(40);
  text("The value you have", 240, 250);
  text("enterd is not correct.", 250, 290);
  text("Please Try again", 260, 330);
  //subtext
  textFont(subtextFont);
  textSize(25);
  text("Press Enter to view the options", 225, 380);
  textSize(20);
  text("and hold the space bar to try again", 245, 410);
}

//PAUSE BUTTON*********************************************************************************************
void pause() {
  bodyFont = loadFont("Consolas-Bold-55.vlw");

  background(60);
  noStroke();
  fill(255);
  rectMode(CENTER);
  rect(400, 275, 500, 300);
  //GRAPHICS
  //top side
  image(goldenKey, 50, 50, width/10, height/20);
  image(goldenKey, 200, 50, width/10, height/20);
  pushMatrix();
  translate(380, 100);
  rotate(radians(270));
  image(goldenKey, 0, 0, width/10, height/20);
  popMatrix();
  image(goldenKey1, 500, 50, width/10, height/20);
  image(goldenKey1, 680, 50, width/10, height/20);
  //right side
  image(goldenKey1, 680, 210, width/10, height/20);
  image(goldenKey1, 680, 330, width/10, height/20);
  //bottom side
  image(goldenKey1, 680, 460, width/10, height/20);
  image(goldenKey1, 500, 460, width/10, height/20);
  pushMatrix();
  translate(410, 440);
  rotate(radians(90));
  image(goldenKey, 0, 0, width/10, height/20);
  popMatrix();
  image(goldenKey, 200, 460, width/10, height/20);
  image(goldenKey, 50, 460, width/10, height/20);
  //left side
  image(goldenKey, 50, 210, width/10, height/20);
  image(goldenKey, 50, 330, width/10, height/20);
  //mask
  image(masks, 300, 140, 200, 100);
  //TEXT
  fill(0);
  textFont(bodyFont);
  text("PAUSED", 300, 300);
  //buttons
  textFont(bodyFont);
  textSize(30);
  stroke(0);
  strokeWeight(3);
  //Return to game
  noFill();
  rect(390, 330, 200, 30);
  fill(0);
  text("Resume Game", 300, 340);
  //Return to main menu
  noFill();
  rect(390, 380, 170, 30);
  fill(0);
  text("Main Menu", 320, 390);
}

//Main Background *************************************************************************************************************
void mainBackground() {
  goldenKey = loadImage("bgKey.jpg"); // key in the background of opening, main menu etc.
  goldenKey1 = loadImage("bgKey1.jpg");
  masks = loadImage("mask.jpg"); //masks in the background of opening, main menu etc.

  background(60);
  noStroke();
  fill(255);
  rect(160, 80, 500, 400);

  //background

  for (int i = 0; i<=601; i+=200) {
    //top side
    image(goldenKey, 50+i, 30, width/10, height/20);
    image(goldenKey, 50+i, 30, width/10, height/20);
    image(goldenKey, 50+i, 30, width/10, height/20);
    image(goldenKey, 50+i, 30, width/10, height/20);
  }
  //rightSide
    pushMatrix();
    translate(750, 170);
    rotate(radians(270));
    image(goldenKey1, 0, 0, width/10, height/20);
    popMatrix();
    pushMatrix();
    translate(750, 320);
    rotate(radians(270));
    image(goldenKey1, 0, 0, width/10, height/20);
    popMatrix();
    pushMatrix();
    translate(750, 470);
    rotate(radians(270));
    image(goldenKey1, 0, 0, width/10, height/20);
    popMatrix();
    
  for(int i = 0; i<=601; i+=200) {
  //bottom side
    image(goldenKey1, 50+i, 500, width/10, height/20);
    image(goldenKey1, 50+i, 500, width/10, height/20);
    image(goldenKey1, 50+i, 500, width/10, height/20);
    image(goldenKey1, 50+i, 500, width/10, height/20);
  }
//Left Side
  pushMatrix();
  translate(50, 170);
  rotate(radians(270));
  image(goldenKey, 0, 0, width/10, height/20);
  popMatrix();
  pushMatrix();
  translate(50, 320);
  rotate(radians(270));
  image(goldenKey, 0, 0, width/10, height/20);
  popMatrix();
  pushMatrix();
  translate(50, 470);
  rotate(radians(270));
  image(goldenKey, 0, 0, width/10, height/20);
  popMatrix();
}
