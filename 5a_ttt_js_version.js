/*
    1___2___3
a|  a1, a2, a3   rowz
b|  b1, b2, b3
c|  c1, c2, c3


verticalWins =  [[ 'a1', 'b1', 'c1'],
                 [ 'a2', 'b2', 'c2'],
                 [ 'a3', 'b3', 'c3']]

horizontalWins =  [[ 'a1', 'a2', 'a3'],
                   [ 'b1', 'b2', 'b3'],
                   [ 'c1', 'c2', 'c3']]

*/

function boardHash() {
  var board = {};
}

/*
 I'd like to store my board as a... HASH, or, maybe
 an array of pairs?

 An array of PAIRS (i.e. an association list) is just
 like a slow hash table.  An array of ARRAYS would be a valid choice, though:

 arrayOfPairs =  [['a1', 'X']...]

 arrayOfArrays = [['X', 'X', ''], ['O', 'X', 'O']...]

 */
function createBoard() {
  var board = [];

  var nCells = 5; // default 3 for now
  var alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"];

  for (var i=0; i<nCells; i++) {
    board.push([alphabet[i] + i.toString()]);
  }
  return board;
}

createBoard();





