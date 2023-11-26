extends Area2D
var speed = 300

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
#func _physics_process(delta: float) -> void:
##	position += transform.x * delta * speed
#
#	if position.x != 0: #para que se quede mirando al lado correcta a pesar de frenar
#		position.x = sign(position.x)

func _on_body_entered(body: Node2D):
	Debug.dprint("hit")
