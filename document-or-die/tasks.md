A list of tasks and plans for the game.
## Gameplay
- Map (1 person)
- Shop (1 person)
	- Loading dice and items into the shop
	- Description window that pops up when hovering over an item/die
- Battle (2 people)

## Under the Hood
- Dice Data File (1 person)
	- We can save all the info about each die in a read only file, that way we can keep track of what dice the player has by just holding an unique name for each die and loading in the die from the data file when needed
	- Holds the starting sides of each die
- Player Data (1 person)
	- A singleton that holds what die the player currently has, as well as modifications to any of the die
	- Also holds various player stats like money, current level, etc.

## Other
- Title Screen (1 person)
- Character Select (1 person)