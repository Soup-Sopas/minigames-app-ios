# Minigames App
#### Video Demo: 
#### Description: This app for IOS is only available for iPhones and it was created as a project for the CS50 Course. The app includes a Tic Tac Toe and Minesweeper

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
