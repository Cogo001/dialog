extends CharacterBody2D



var SPEED = 300.0
signal dialogue
var pos

func _process(delta):
	#Movimento base
	var movement= Vector2()
	movement.x= Input.get_axis("ui_left","ui_right")
	movement.y= Input.get_axis("ui_up","ui_down")
	movement=movement.normalized()
	
	#RAYCAST 2D
	if movement != Vector2.ZERO :
		$RayCast2D.target_position=movement*64
		$RayCast2D/Area2D.position=$RayCast2D.target_position
	
	
	if Input.is_action_pressed("ui_x"):
		SPEED=750
	else:
		SPEED=300

	velocity= movement * SPEED
	move_and_slide()


func _input(event: InputEvent):
	var collider = $RayCast2D.get_collider()
	
	if Dialogic.current_timeline != null:
		return
	
	if collider != null and Input.is_action_just_released("ui_accept"):
		set_process(false)
		emit_signal("dialogue")
		
