# Minigames App
#### Video Demo: 
#### Description: This app for IOS is only available for iPhones and it was created as a project for the CS50 Course. The app includes a Tic Tac Toe and Minesweeper

#
### Title Screen 

In my [TitleScreenView file](/FinalProject/Screens/TitleScreenView/TitleScreenView.swift), I created a view with two navigation links that redirect you to a new view of the game you selected. I also included an animation of 4 dots going in a straight line that repeats forever.

### Minesweeper

With the [MinesweeperView file](/FinalProject/Screens/MinewsweeperView/MinewsweeperView.swift) I display the grid of the game, a button to toggle a flag mode, and another button to go back to the title screen. In this file I initialize a state bool variable `isFlagModeActive` with false so if you press the button it should change it to true and pass the value to another file named [GridGameView](/FinalProject/Screens/MinewsweeperView/GridGameView.swift) that contains the grid view, where all the game logic is used because the [GridGameViewModel file](/FinalProject/Screens/MinewsweeperView/GridGameViewModel.swift) it contains the functions and variables of the game.



