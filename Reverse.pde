class Reverse{
  
  int[][] damiField = new int[8][8];
  
  Reverse(int[][] field){
    for(int i=0; i<8; i++){
      this.damiField[i] = field[i].clone();
    }
  }
  
  int[][] getField(){
    return damiField;
  }
  
  boolean judge(int x, int y){
    boolean puttable = false;
    if(damiField[x][y]==0){
      puttable = checkDirection(x,y,-1,-1) | puttable;
      puttable = checkDirection(x,y,-1,0) | puttable;
      puttable = checkDirection(x,y,-1,1) | puttable;

      puttable = checkDirection(x,y,0,-1) | puttable;
      puttable = checkDirection(x,y,0,1) | puttable;

      puttable = checkDirection(x,y,1,-1) | puttable;
      puttable = checkDirection(x,y,1,0) | puttable;
      puttable = checkDirection(x,y,1,1) | puttable;

      if(puttable){
        damiField[x][y] = currentStone();
      }
    }
    return puttable;
  }

  boolean checkDirection(int x, int y, int directionX, int directionY){
    if(checkBound(x+directionX, y+directionY) && damiField[x+directionX][y+directionY] != currentStone()){
      return checkStones(x, y, directionX, directionY);
    }
    return false;
  }

  boolean checkStones(int x, int y, int directionX, int directionY){
    if(checkBound(x+directionX, y+directionY) && damiField[x+directionX][y+directionY] == currentStone()){
      return true;
    }else if(checkBound(x+directionX, y+directionY) && damiField[x+directionX][y+directionY] == 0){
      return false;
    }else if(checkBound(x+directionX, y+directionY) && checkStones(x+directionX, y+directionY, directionX, directionY)){
      damiField[x+directionX][y+directionY] = currentStone(); // reverse
      return true;
    }else{
      return false;
    }
   }

  boolean checkBound(int x, int y){
    return x>=0 && x<8 && y>=0 && y<8;
  }
  
  void turnChange(){
    stone = !stone;
  }

}