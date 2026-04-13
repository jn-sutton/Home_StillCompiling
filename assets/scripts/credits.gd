extends Node2D

@onready var label: Label = $CanvasLayer2/Label
# pixels/second
var scroll_speed = 80  

func _ready():
	# start label below the screen
	label.position.y = get_viewport().size.y
	
func _process(delta):
	label.position.y -= scroll_speed * delta
	
	# once text has fully scrolled off the top, go to main menu
	if label.position.y + label.size.y < 0:
		get_tree().change_scene_to_file("res://assets/scenes/main/main_menu.tscn")
