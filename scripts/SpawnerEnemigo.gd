extends Node2D
@onready var timer: Timer = $Timer
@onready var markers: Node2D = $Markers

@export var enemigo_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.connect("timeout", timer_timeout)
	
func timer_timeout() -> void:
	if not enemigo_scene or Global.enemy_count >= Global.max_enemys:
		return
	var enemigo = enemigo_scene.instantiate()
	get_parent().add_child(enemigo)
	var index = randi_range(0,markers.get_children().size()-1)
	enemigo.global_position = markers.get_child(index).global_position

