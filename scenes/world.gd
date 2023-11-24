extends Node2D

@onready var popup = $Window

func _ready():
	pass
	
func _on_window_close_requested():
	popup.hide()


