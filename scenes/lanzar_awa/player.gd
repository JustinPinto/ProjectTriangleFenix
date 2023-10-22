extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
#	emitting = false
#	await get_tree().create_timer(lifetime).timeout
#	queue_free()
	pass
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_hitbox_awa_body_entered(body):
	body.take_damage() # o como se llame la función
	# ?
	# cuando pones conectar en la ventana que mandé por discord
	# recomienda el nombre
	# puedes cambiar el nombre si quieres pero por defecto es
	# _on_[nombre_del_nodo]_body_entered
	# doble click o click derecho -> connect

# whatsapp doxeado
