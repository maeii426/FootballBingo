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
  
  
# Add owner scenario feature 
# As an owner
# I would like my winners to be under certain number
# so that I can give out available amount of prizes 