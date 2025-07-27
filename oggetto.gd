extends StaticBody2D


signal finished

#Inizia il dialogo
func _on_character_body_2d_dialogue():
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.start('prova')
	get_viewport().set_input_as_handled()
	
#Finisci dialogo
func _on_timeline_ended():
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	emit_signal("finished")
	
