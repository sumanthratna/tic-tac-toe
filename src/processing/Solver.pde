abstract class Solver {
  int[][] values;
  abstract int[] calculate(char[][] board); //abstract method
  final char COMP = 'O';
  Solver() {
    values = new int[3][3];
  }
  /**
   * @return -10 for loss, 0 for tie, 10 for win
   */
  int outcome(char[][] board, final int x, final int y) {
    if (board[y][x]!='\u0000') {
      return -1; //already piece there, return
    }
    board[y][x] = COMP;
    int out = 0;
    if (board[0][0]==board[1][1] && board[1][1]==board[2][2] && board[0][0]==board[2][2]) {
      out = (board[1][1]==COMP ? 10:-10);
    } else if (board[2][0]==board[1][1] && board[1][1]==board[0][2] && board[2][0]==board[0][2]) {
      out = (board[1][1]==COMP ? 10:-10);
    } else if (board[0][x]==board[1][x] && board[1][x]==board[2][x] && board[0][x]==board[2][x]) {
      out = (board[1][x]==COMP ? 10:-10);
    } else if (board[y][0]==board[y][1] && board[y][1]==board[y][2] && board[y][0]==board[y][2]) {
      out = (board[y][1]==COMP ? 10:-10);
    }
    board[y][x] = '\u0000';
    return out;
  }
}
