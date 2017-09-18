(() => {
  const DOM_ELEMENTS = {
    form: document.getElementById("game_form"),
    squares: document.getElementsByClassName("square"),
    gameMoves: document.getElementById("moves"),
    move: document.getElementById("move")
  }


  squares()
    .filter(excludeSquares(gameMoves()))
    .forEach(activateSquare);

  function squares() {
    return Array.from(DOM_ELEMENTS.squares);
  }

  function excludeSquares(gameMoves) {
    return (square) => gameMoves.indexOf(getSquareNumber(square)) == -1;
  }

  function gameMoves() {
    return (
      DOM_ELEMENTS
        .gameMoves
        .value
        .split(",")
        .map(move => parseInt(move)));
  }

  function activateSquare(square) {
    square.addEventListener("click", makeMove(getSquareNumber(square)));
  }

  function makeMove(square_number) {
    return () => {
      DOM_ELEMENTS.move.value = square_number;
      DOM_ELEMENTS.form.submit();
    }
  }

  function getSquareNumber(square) {
    const [number] = square.id.match(/\d+$/);
    return parseInt(number);
  }
})();
