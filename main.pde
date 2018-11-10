import java.util.ArrayList;
import java.util.Arrays;

final int blockSize = 100;
boolean stone;
int[][] field;
int[][] currentField = new int[8][8];
int[][] damiField = new int[8][8];
int[][] evaluateField = { //evaluation function
                          {30,-12,0,-1,-1,0,-12,30},
                          {-12,-15,-3,-3,-3,-3,-15,-12},
                          {0,-3,0,-1,-1,0,-3,0},
                          {-1,-3,-1,-1,-1,-1,-3,-1},
                          {-1,-3,-1,-1,-1,-1,-3,-1},
                          {0,-3,0,-1,-1,0,-3,0},
                          {-12,-15,-3,-3,-3,-3,-15,-12},
                          {30,-12,0,-1,-1,0,-12,30}
                        };  
                        
void setup(){
  //size(8*blockSize, 8*blockSize);
  size(800, 800);
  field = new int[8][8];
  for(int i=0; i<8; ++i){
    for(int j=0; j<8; ++j){
      if((i==3||i==4)&&(j==3||j==4)){
        field[i][j] = ((i+j)%2==0)?1:-1; // initial stones, ?1:-1 mean if(.)==TRUE then return 1, else return -1
      }else{
        field[i][j] = 0;
      }
    }
  }
}

void draw(){
  // draw field
  background(0, 160, 0);
  stroke(0);
  for(int i=1; i<8; ++i){
    line(i*blockSize,0,i*blockSize,height);
    line(0, i*blockSize, width, i*blockSize);
  }
  noStroke();
  fill(0);
  ellipse(blockSize*2,blockSize*2,10,10);
  ellipse(blockSize*6,blockSize*2,10,10);
  ellipse(blockSize*2,blockSize*6,10,10);
  ellipse(blockSize*6,blockSize*6,10,10);
  
  // draw stones
  noStroke();
  for(int i=0;i<8; i++){
    for(int j=0; j<8; j++){
      if(field[i][j]==1){
        fill(0);
        ellipse(blockSize*i+blockSize*0.5,blockSize*j+blockSize*0.5,blockSize*0.8,blockSize*0.8);
      }
      if(field[i][j]==-1){
        fill(255);
        ellipse(blockSize*i+blockSize*0.5,blockSize*j+blockSize*0.5,blockSize*0.8,blockSize*0.8);
      }
    }
  }
}

void mouseReleased(){
  int x = mouseX / blockSize;
  int y = mouseY / blockSize;

  // player
  for(int i=0; i<field.length; i++){
    currentField[i] = field[i].clone();
  }
  judge(x,y);
  for(int i=0; i<field.length; i++){
    field[i] = currentField[i].clone();
  }  // update field
  drawField(field);
  stone = !stone;
  
  // cpu
  cpu();
  for(int i=0; i<field.length; i++){
    field[i] = damiField[i].clone();
  }
  drawField(field);
  stone = !stone;
}

boolean judge(int x, int y){
  boolean puttable = false;
  if(currentField[x][y]==0){
    puttable = checkDirection(x,y,-1,-1) | puttable;
    puttable = checkDirection(x,y,-1,0) | puttable;
    puttable = checkDirection(x,y,-1,1) | puttable;

    puttable = checkDirection(x,y,0,-1) | puttable;
    puttable = checkDirection(x,y,0,1) | puttable;

    puttable = checkDirection(x,y,1,-1) | puttable;
    puttable = checkDirection(x,y,1,0) | puttable;
    puttable = checkDirection(x,y,1,1) | puttable;

    if(puttable){
      currentField[x][y] = currentStone();
    }
  }
  return puttable;
}

boolean checkDirection(int x, int y, int directionX, int directionY){
  if(checkBound(x+directionX, y+directionY) && currentField[x+directionX][y+directionY] != currentStone()){
    return checkStones(x, y, directionX, directionY);
  }
  return false;
}

boolean checkStones(int x, int y, int directionX, int directionY){
  if(checkBound(x+directionX, y+directionY) && currentField[x+directionX][y+directionY] == currentStone()){
    return true;
  }else if(checkBound(x+directionX, y+directionY) && currentField[x+directionX][y+directionY] == 0){
    return false;
  }else if(checkBound(x+directionX, y+directionY) && checkStones(x+directionX, y+directionY, directionX, directionY)){
    currentField[x+directionX][y+directionY] = currentStone(); // reverse
    return true;
  }else{
    return false;
  }
 }

boolean checkBound(int x, int y){
  return x>=0 && x<8 && y>=0 && y<8;
}

int currentStone(){
  return (stone)?1:-1;  
}

// for console; display current status of field
void drawField(int[][] args){
  for(int i=0; i<8; i++){
    for(int j=0; j<8; j++){
      if(args[j][i]==0){
        print("□");
      }else{
        print((args[i][j]==1)?"○":"●"); // cz background color of console is black, so b n w is reversed
      }
    }
    println("");
  }
  println("");
}

void cpu(){
  int value = -100;
  int currentValue = -100;
  boolean bool = false;
  for(int i=0; i<8; i++){
    for(int j=0; j<8; j++){
      bool = judge(i,j);  // changed "currentField"
      drawField(currentField);
      currentValue = evaluation();
      if(value<currentValue && bool != false){
        // damiField = currentField
        for(int k=0; k<field.length; k++){
          damiField[k] = currentField[k].clone();
        }
        value = currentValue;
      }
      // currentField = field; reset field
      for(int l=0; l<field.length; l++){
        currentField[l] = field[l].clone();
      }
    }
  }
}

int evaluation(){
  int score = 0;
  for(int i=0; i<8; i++){
    for(int j=0; j<8; j++){
      if(currentField[j][i]==1){
        score+=evaluateField[i][j];
      }
    }
  }
  return score;
}


