extends Area2D

const DialogueSystemPreload=preload("res://dialogue_avanzato/dialogue_system.tscn")

#variable look in direction 23:15 
@export var  activate_instant:bool
@export var  only_activate_once:bool
@export var  override_dialogue_position:bool
@export var override_position:Vector2 
@export var dialogue :Array[DE] 

var dialogue_top_pos:Vector2=Vector2(160,48)
var dialogue_bottom_pos:Vector2=Vector2(160,192)

var player_body_in:bool =false
var has_activated_already:bool=false
var desired_dialogue_pos :Vector2

var player_node:CharacterBody2D=null


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
			set_process(false)
			return
			
		if Input.is_action_just_pressed("ui_accept"):
			_activate_dialogue()
			player_body_in=false

func _activate_dialogue()->void:
	player_node.can_move=false
	
	var new_dialogue=DialogueSystemPreload.instantiate()
	if override_dialogue_position:
		desired_dialogue_pos=override_position
	else:
		if player_node.global_position.y >get_viewport().get_camera_2d().get_screen_center_position().y:
			desired_dialogue_pos=dialogue_top_pos
		else:
			desired_dialogue_pos=dialogue_bottom_pos
	new_dialogue.global_position=dialogue_bottom_pos
	new_dialogue.dialogue=dialogue
	get_parent().add_child(new_dialogue)

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
