Feature: Generate bingo cards 
  
  As a user 
  I would like my bingo cards to be thoughfully generated 
  so that I have a 'fair' chance at winning 
 
Scenario: 
  Given the game data actions 
  When actions include numeric status 
  Then the number is randomly selected 
  
Scenario: 
  Given the game data actions  
  Then the inclusive game actions are not generated contiguously in bingo cards
  
Scenario: 
  Given the number of prizes 
  Then the winners are under the number 