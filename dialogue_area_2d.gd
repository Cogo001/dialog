extends Area2D

const DialogueSystemPreload=preload("res://dialogue_avanzato/dialogue_system.tscn")

#variable look in direction 23:15 
@export var  activate_instant:bool
@export var  only_activate_once:bool
@export var  override_dialogue_position:bool
@export var override_position:Vector2 
@export var dialogue :Array[DE] 


#var dialogue_top_pos:Vector2=Vector2(160,48)
#var dialogue_bottom_pos:Vector2=Vector2(160,192)

var pos:Vector2=Vector2(42.0,489.0)  #true position

var player_body_in:bool =false
var has_activated_already:bool=false
var desired_dialogue_pos :Vector2

var player_node:CharacterBody2D=null

var dialogue_open: bool = false 
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in get_tree().get_nodes_in_group("player"):
		player_node=i


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if !player_node:
		for i in get_tree().get_nodes_in_group("player"):
			player_node=i
		return
	
	if !activate_instant and player_body_in:
		if only_activate_once and has_activated_already:
			#set_process(false)# remove
			return
			
		if Input.is_action_just_pressed("ui_z") and !dialogue_open:
			_activate_dialogue()
			#player_body_in=false #remove

func _activate_dialogue()->void:
	player_node.can_move=false
	dialogue_open=true
	
	var new_dialogue=DialogueSystemPreload.instantiate()
	#new_dialogue.global_position=dialogue_bottom_pos
	new_dialogue.get_node("Panel").position=pos
	new_dialogue.dialogue=dialogue
	new_dialogue.connect("dialogue_closed", Callable(self, "_on_dialogue_closed"))#
	get_parent().add_child(new_dialogue)
	
	
	if only_activate_once:
		has_activated_already = true
	

func _on_body_entered(body):
	if only_activate_once and has_activated_already:
		return
	if body.is_in_group("player"):
		player_body_in=true
		if activate_instant:
			_activate_dialogue()


func _on_body_exited(body):
	if body.is_in_group("player"):
		player_body_in=false

#control new
func _on_dialogue_closed():
	dialogue_open = false
	player_node.can_move = true
