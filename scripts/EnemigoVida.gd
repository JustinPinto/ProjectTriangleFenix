extends MarginContainer
@onready var health_bar = $VBoxContainer/HBoxContainer/HealthBar


func set_health(value):
	health_bar.value = value
