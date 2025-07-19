extends Node
# All possible battle states
enum BATTLE_STATES {
 PLAYER,    # When it's time for the player's turn
 ENEMY,    # When it's time for the enemy's turn
 WIN,    # When the player wins
 LOSE    # When the player loses
}
var current_state    # The current state of the battlevar player_team = Array()    # All players on the player's team
var player_turn_order = Array()    # A queue of players. player_turn_order[0] is always the next player to govar enemy_team = Array()    # All enemies on the enemy's team
var enemy_turn_order = Array()    # A queue of enemies. enemy_turn_order[0] is always the next player to go# When the battle is initialized
func _ready():
 _handle_states(BATTLE_STATES.PLAYER)    # New idea: In this new function, we will set the state and handle it that way
 
 # Initialize players and enemies into the array
 for i in range(0, 4):
  # initialize each player here
  pass
 
 for i in range(0, 4):
  # initialize each enemy here
  pass# Handle the battle by checking what state the battle is in
func _handle_states(new_state):
 current_state = new_state
 
 match current_state:
  BATTLE_STATES.PLAYER:
   # Insert player code here
   #player_turn_order = player_team.duplicate()    # Simple concept. On each player turn, duplicate the player 
				 # array and send it into the player_turn_order
   pass
  BATTLE_STATES.ENEMY:
   # Insert enemy code here
   #enemy_turn_order = enemy_team.duplicate()    # Simple concept. On each enemy turn, duplicate the enemy 
			   # array and send it into the enemy_turn_order
   pass
  BATTLE_STATES.WIN:
   # Insert code on player win
   pass
  BATTLE_STATES.LOSE:
   # Insert code on player lose
   pass# Do this on a player's turn
func _handle_player_turn():
 # If there are more players to go
 if player_turn_order.size() > 0:
  #player_turn_order[0]._attack_entity(enemy_team[2])    # Attack enemy at index 2 with the current player
  player_turn_order.pop_front()    # Remove that player from the queue of players
 else:
  _handle_states(BATTLE_STATES.ENEMY)    # If there is nobody left, switch the state to "ENEMY"
 
# Do this on an enemy's turn
func _handle_enemy_turn():
 # While there are more enemies still able to go
 while enemy_turn_order.size() > 0:
  #nemy_turn_order[0]._attack_entity(player_team[1])    # Have the current enemy attack a player at index 1
  enemy_turn_order.pop_front()    # Remove that enemy from the queue
 
 _handle_states(BATTLE_STATES.PLAYER)    # Once there is nobody left, switch to state "PLAYER"
