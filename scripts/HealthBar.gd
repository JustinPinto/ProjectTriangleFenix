extends ProgressBar

@onready var health_bar = $VBoxContainer/HBoxContainer/TextureProgressBar

func set_health(value):
	health_bar.value = value
