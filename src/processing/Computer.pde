class Computer extends Solver {
  /**
   * If game can be won, piece is placed in winning location. If opponent has two-in-a-row, piece is placed third location, to prevent human winning. Otherwise, random location is picked.
   * @param the current board state
   * @return a location of where to put the computer's piece, using above algorithm
   */
  int[] calculate(char[][] board) {
    if (board[0][0]==0 && board[1][1]!=0 && board[1][1]==board[2][2]) {
      return new int[]{0, 0};
    }
    if (board[1][1]==0 && board[0][0]!=0 && board[0][0]==board[2][2]) {
      return new int[]{1, 1};
    }
    if (board[2][2]==0 && board[0][0]!=0 && board[0][0]==board[1][1]) {
      return new int[]{2, 2};
    }
    if (board[2][0]==0 && board[1][1]!=0 && board[1][1]==board[0][2]) {
      return new int[]{2, 0};
    }
    if (board[1][1]==0 && board[0][2]!=0 && board[0][2]==board[2][0]) {
      return new int[]{1, 1};
    }
    if (board[0][0]==0 && board[0][1]!=0 && board[0][1]==board[0][2]) {
      return new int[]{0, 0};
    }
    for (int i=0; i<3; i++) {
      //lines 42 to 50 are for columns
      if (board[i][0]==0 && board[i][1]!=0 && board[i][1]==board[i][2]) {
        return new int[]{i, 0};
      }
      if (board[i][1]==0 && board[i][0]!=0 && board[i][0]==board[i][2]) {
        return new int[]{i, 1};
      }
      if (board[i][2]==0 && board[i][0]!=0 && board[i][0]==board[i][1]) {
        return new int[]{i, 2};
      }
      //lines 52 to 60 are for rows
      if (board[0][i]==0 && board[1][i]!=0 && board[1][i]==board[2][i]) {
        return new int[]{0, i};
      }
      if (board[1][i]==0 && board[0][i]!=0 && board[0][i]==board[2][i]) {
        return new int[]{1, i};
      }
      if (board[2][i]==0 && board[0][i]!=0 && board[0][i]==board[1][i]) {
        return new int[]{2, i};
      }
    }
    int x, y;
    do {
      x = int(random(3));
      y = int(random(3));
    } while (board[y][x]!=0);
    //return new int[]{y,x};
    return new int[]{x, y}; //normal
  }
}
