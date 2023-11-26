extends Node2D

@export var jugador : PackedScene

var player_is_near = false

func _process(delta):
	if player_is_near and Input.is_action_just_pressed("interact"):
		Debug.dprint("objeto recogido")

func _on_body_entered(body):
	if body.has_method("player"):
		$borde.visible = true
		player_is_near = true

func _on_body_exited(body):
	if body.has_method("player"):
		$borde.visible = false
		player_is_near = false
