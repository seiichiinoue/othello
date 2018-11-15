class Search{
	
	int[][] searchField = new int[8][8];
	
	Search(int[][] field){
		for(int i=0; i<8; i++){
			tihs.searchField[i] = field[i].clone()
		}
		this.searchField = field;
	}
	
	boolean judge(int x, int y){
	  boolean puttable = false;
	  if(searchField[x][y]==0){
	    puttable = checkDirection(x,y,-1,-1) | puttable;
	    puttable = checkDirection(x,y,-1,0) | puttable;
	    puttable = checkDirection(x,y,-1,1) | puttable;

	    puttable = checkDirection(x,y,0,-1) | puttable;
	    puttable = checkDirection(x,y,0,1) | puttable;

	    puttable = checkDirection(x,y,1,-1) | puttable;
	    puttable = checkDirection(x,y,1,0) | puttable;
	    puttable = checkDirection(x,y,1,1) | puttable;

	    if(puttable){
	      searchField[x][y] = currentStone();
	    }
	  }
	  return puttable;
	}

	boolean checkDirection(int x, int y, int directionX, int directionY){
	  if(checkBound(x+directionX, y+directionY) && searchField[x+directionX][y+directionY] != currentStone()){
	    return checkStones(x, y, directionX, directionY);
	  }
	  return false;
	}

	boolean checkStones(int x, int y, int directionX, int directionY){
	  if(checkBound(x+directionX, y+directionY) && searchField[x+directionX][y+directionY] == currentStone()){
	    return true;
	  }else if(checkBound(x+directionX, y+directionY) && searchField[x+directionX][y+directionY] == 0){
	    return false;
	  }else if(checkBound(x+directionX, y+directionY) && checkStones(x+directionX, y+directionY, directionX, directionY)){
	    searchField[x+directionX][y+directionY] = currentStone(); // reverse
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

}