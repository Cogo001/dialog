extends CanvasLayer


@export var dialogPath=""
@export var textSpeed=0.05

var dialog : Array = []
var phraseNum:int = 0
var finished=false


@onready var background=$PanelContainer
@onready var label=$PanelContainer/Label


func _ready():
	$Timer.wait_time=textSpeed
	dialog=getDialog()
	assert(dialog,"Dialog not found")
	nextPhrase()
	
func _process(delta):
	#$Indicator.visible=finished
	if Input.is_action_just_pressed("ui_accept"):
		if finished:
			nextPhrase()
		else:
			label.visible_characters=len(label.text)
	

func getDialog() -> Array:
	var f=FileAccess.open(dialogPath,FileAccess.READ)
	#print("f",f)
	assert(f.file_exists(dialogPath),"File path does not exist")
	
	f.open(dialogPath,f.READ)
	#print("f2",f)
	var json=f.get_as_text()
	#print("json",json)
	var json_object =JSON.new()
	#print("json object",json_object)
	json_object.parse(json)
	var output=json_object.data
	#print("output",output)
	
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return[]
	
	
func nextPhrase():
	if phraseNum>=len (dialog):
		queue_free()
		return
	finished=false
	
	label.bbcode_text=dialog[phraseNum]["Text"]
	label.visible_characters=0
	while label.visible_characters < len(label.text):
		label.visible_characters += 1
		$Timer.start()
		await $Timer.timeout
		
	finished =true
	phraseNum +=1
	return
