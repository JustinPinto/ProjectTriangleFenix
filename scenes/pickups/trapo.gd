extends Node2D

func _on_body_entered(body):
	if body.has_method("player"):
		$borde.visible = true

func _on_body_exited(body):
	if body.has_method("player"):
		$borde.visible = false
		
