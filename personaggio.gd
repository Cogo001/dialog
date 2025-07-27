extends CharacterBody2D



var SPEED = 300.0
var can_move:bool=true  #dialogue

func  _ready():
	add_to_group("player")


func _process(delta):
	if !can_move:
		return #annulla quallo che ce sotto
	
	#Movimento base
	var movement= Vector2()
	movement.x= Input.get_axis("ui_left","ui_right")
	movement.y= Input.get_axis("ui_up","ui_down")
	movement=movement.normalized()
	

	
	
	if Input.is_action_pressed("ui_x"):
		SPEED=750
	else:
		SPEED=300

	velocity= movement * SPEED
	move_and_slide()
