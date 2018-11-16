import java.util.ArrayList;
import java.util.Arrays;

final int blockSize = 100;
boolean stone;
int[][] field;
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
          
void settings(){
  size(8*blockSize, 8*blockSize);
    //size(800, 800);
}

void setup(){
  field = new int[8][8];
  for(int i=0; i<8; ++i){
    for(int j=0; j<8; ++j){
      if((i==3||i==4)&&(j==3||j==4)){
        field[i][j] = ((i+j)%2==0)?1:-1; 
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
  Reverse whiteReverse = new Reverse(field);
  if(whiteReverse.judge(x,y)){
    for(int i=0; i<8; i++){
      field[i] = whiteReverse.getField()[i].clone();
    }
    whiteReverse.turnChange();
    
    // cpu
    int point[] = new int[2];
    Reverse blackReverse = new Reverse(field);
    point = search();
    if(blackReverse.judge(point[0],point[1])){
      for(int i=0; i<8; i++){
        field[i] = blackReverse.getField()[i].clone();
    }
      blackReverse.turnChange();
    }
  }
}

int currentStone(){
  return (stone)?1:-1;  
}

int[] search(){
  int[] point = new int[2];
  int v0 = -100;
  int v1 = -100;
  for(int i=0; i<8; i++){
    for(int j=0; j<8; j++){
      Reverse testReverse = new Reverse(field);
      if(testReverse.judge(i,j)){
        v1 = evaluation(testReverse.getField());
        if(v1>v0){
          point[0]=i;
          point[1]=j;
          println(point[0], point[1]);
        }
      }
      v0 = v1;
    }
  }
  return point;
}

int evaluation(int[][] args){
  int score = 0;
  for(int i=0; i<8; i++){
    for(int j=0; j<8; j++){
      if(args[i][j]==1){
        score+=evaluateField[i][j];
      }
    }
  }
  return score;
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