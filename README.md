# Minigames App
#### Video Demo

#### Description
This app for IOS is only available for iPhones and it was created as a project for the CS50 Course. The app includes a Tic Tac Toe and Minesweeper

#
### Title Screen 

In my [TitleScreenView file](/FinalProject/Screens/TitleScreenView/TitleScreenView.swift), I created a view with two navigation links that redirect you to a new view of the game you selected. I also included an animation of 4 dots going in a straight line that repeats forever.

### Minesweeper

The Minesweeper game consists of three files, the first file `MinesweeperView`, displays the grid game, a button to toggle into flag mode, and a navigation link to return to the title screen. The second file is `GridGameView`, this code defines a grid interface where users interact with cells by tapping, revealing their content, or placing flags and when the game is over it overlays a custom alert to indicate if you win or lose where you can play again or return to the title screen. The third file, 'GridGameViewModel`, is a model that manages the game logic and state for the grid. For more information about each file, check the code breakdown.


#### [`MinesweeperView`](/FinalProject/Screens/MinewsweeperView/MinewsweeperView.swift) breakdown:
- The `MinesweeperView` struct defines the user interface for the Minesweeper game.
- It manages the state of the flag mode through the `isFlagModeActive` state variable.
- The body of the view is structured as a `VStack`, containing the game grid (`GridGameView`) and a control panel.
- The control panel includes a button to toggle flag mode and a navigation link to return to the title screen.
- The flag mode toggle button switches between flag mode and regular mode based on the `isFlagModeActive` state.

#### [`GridGameView`](/FinalProject/Screens/MinewsweeperView/GridGameView.swift) breakdown:
- The view includes a state object `vM` of type `GridGameViewModel`.
- It accepts a binding `isFlagModeActive` of type `Bool`.
- The body of the view is composed of a `ZStack` containing a `LazyVGrid`, representing a grid layout.
- Each rectangle in the `LazyVGrid` represents a cell in the grid, with visual properties determined by the `GridGameViewModel`.
- Certain cells may contain bombs, depending on conditions specified in the view model.
- The `onTapGesture` modifier handles tap events on cells. In flag mode, tapping puts or removes flags on the cells, otherwise, it processes moves by uncovering cells.
- The view includes an overlay for displaying custom alerts when the game is over.
- The alert presents a title and a button to reset the game or go back to the [`Title Screen`](#title-screen).
- User interaction with the grid is disabled when an alert is active.

#### [`GridGameViewModel`](/FinalProject/Screens/MinewsweeperView/GridGameViewModel.swift) 
- It defines properties such as `columns`, `bombs`, `cells`, `hintsMap`, `showBombs`, `title`, and `isAlertActive` to keep track of game elements and state.
- The `processMove(for:)` method handles player moves, determines game outcomes, and updates the game state accordingly.
- Methods like `alternateBox`, `getSquaresAround`, `createHintsMap`, `determineNumberOfBombs`, `toMatrix`, and `uncoverEmptySpaces` support game logic such as bomb placement, hint generation, and uncovering empty spaces.
- The `resetGame()` method resets the game state for a new game.
- The `Cell` struct represents a single cell in the game grid.
- It contains properties like `index`, `uncover`, `isFlagShown`, `numberOfBombs`, and `numberOrFlag` to manage cell states and display.
- The `numberOrFlag` property determines the content to display in the cell based on its state, it could return either a flag image or a number image depending on the number of bombs.
- The `Int` extension provides a method `getUniqueRandomNumbers` to generate unique random numbers within a range, excluding specified exceptions.

### Tic-Tac-Toe

The Tic Tac Toe game is divided into two files, the first one with the interface and abstract version of how the game works, and the second one which contains the variables and functions to make it work, the `TicTacToeView` provides a visually appealing and interactive interface for playing Tic Tac Toe without having all the code logic invading the space making it more complicated to read and understand, while the `TicTacToeViewModel` provides the core functionality for managing game logic, determining AI moves, and detecting win conditions in the Tic Tac Toe game.

#### [`TicTacToeView`](/FinalProject/Screens/TicTacToeView/TicTacToeView.swift) breakdown:
- The `TicTacToeView` struct defines the user interface for the Tic Tac Toe game.
- It uses a `TicTacToeViewModel` to manage game logic and state.
- The view is structured as a `ZStack` containing a `GeometryReader` and various UI elements.
- The `GeometryReader` adapts the layout to the available space.
- The main UI consists of a grid of cells representing the Tic Tac Toe board.
- Each cell displays X or O symbols based on the game state.
- Tapping on a cell triggers the `processMove` method in the view model to handle player moves.
- A `returnView` component allows users to navigate back to the title screen.
- Alerts are displayed using a custom alert component (`CustomAlerts`) when the game is over or certain conditions are met.

#### [`TicTacToeViewModel`](FinalProject/Screens/TicTacToeView/TicTacToeviewModel.swift) breakdown:
- The `TicTacToeViewModel` class manages the game logic and state for the Tic Tac Toe game.
- It includes properties such as `moves`, `isTaken`, `isBoardDisabled`, `alertItem`, and `isAlertActive` to track game elements and state.
- The `processMove(for:)` method handles player moves and triggers win conditions or draws based on the current game state.
- It alternates between human and computer moves, implementing a simple AI to determine the computer's moves.
- The `determineComputerPosition(moves:)` method calculates the computer's next move, aiming to block the human player or win the game.
- The `checkWinCondition(player:moves:)` method checks if a player has won the game based on their moves.
- The `resetGame()` method resets the game state for a new game.

