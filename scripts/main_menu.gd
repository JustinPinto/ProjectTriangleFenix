class_name MainMenu
extends Control

@onready var play_button: Button = %Play_button as Button
@onready var exit_button: Button = %Exit_button as Button
@onready var start_level = preload("res://scenes/world.tscn") as PackedScene

func _ready():
	play_button.button_down.connect(on_button_down)
	exit_button.button_down.connect(on_exit_pressed)
	
func on_button_down():
	get_tree().change_scene_to_packed(start_level)
	
func on_exit_pressed():
	get_tree().quit()
