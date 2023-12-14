extends Control

class_name H2P

@onready var play_button: Button = %Play_button as Button

func _ready() -> void:
	pass
	
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

