extends Area2D

@onready var jugador = Global.player
@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var sprite_2d = $Sprite2D
@onready var playback = animation_tree.get("parameters/playback")

var player_is_near = false

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		body.resbalar()
	Debug.dprint("charco")
	
func _ready():
	animation_tree.active = true	
	
func _process(delta):
	if player_is_near and jugador.arma == Global.armas.TRAPO and Input.is_action_just_pressed("attack"):
		Debug.dprint("charco limpiado")
		queue_free()

func _on_clean_body_entered(body):
	if body.has_method("player"):
		player_is_near = true

func _on_clean_body_exited(body):
	if body.has_method("player"):
		player_is_near = false
