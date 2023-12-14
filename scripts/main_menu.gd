class_name MainMenu
extends Control

@onready var play_button: Button = %Play_button as Button
@onready var h2p_button: Button = %H2P_button as Button
@onready var credits_button: Button = %Credits_button as Button
@onready var exit_button: Button = %Exit_button as Button
@onready var start_level = preload("res://scenes/world.tscn") as PackedScene

func _ready():
	play_button.button_down.connect(on_play_down)
	h2p_button.button_down.connect(on_h2p_down)
	credits_button.button_down.connect(on_credits_pressed)
	exit_button.button_down.connect(on_exit_pressed)

func on_h2p_down():
	get_tree().change_scene_to_file("res://scenes/como_jugar.tscn")

func on_credits_pressed():
	get_tree().change_scene_to_file("res://scenes/creditos.tscn")
	
func on_play_down():
	get_tree().change_scene_to_packed(start_level)
	
func on_exit_pressed():
	get_tree().quit()
