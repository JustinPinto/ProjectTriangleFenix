extends CharacterBody2D
var mojado = false
var espumado = false
var arrugado = false
var secado = false
var oldModulate = self.modulate

@export var speed = 10





var health = 100:
	set(value):
		health = value
		if enemigo_vida:
			enemigo_vida.set_health(health)


@onready var window = $"../Window"
@onready var enemigo_vida = $EnemigoVida
@onready var sprite_2d = $Sprite2D

func _ready():
	enemigo_vida.set_health(health)



func take_damage():
	##daño por estado
	if mojado == true:
		health -= 20
	elif espumado == true:
		health -= 30
	elif arrugado == true:
		health -= 40	
	else:
		health -= 10
	
	if health <= 0:
		secado = true
		queue_free()
		Debug.dprint("muerto x.x")
	Debug.dprint(health)
	
	
	


func setMojado() -> void:
	if (mojado == false and espumado == false and arrugado == false || mojado == true):
		$Timer.start()
		sprite_2d.modulate = Color(0.1,0,0.4)
		mojado = true
		Debug.dprint("mojado")
	else:
		pass
		
	


func setDetergente() -> void:
	if (mojado == true and espumado == false and arrugado == false || espumado == true):
		espumado = true
		mojado = false
		Debug.dprint("detergente")
		sprite_2d.modulate = Color(204,255,204)

func setEscobilla() -> void:
	if (mojado == false and espumado == true and arrugado == false || arrugado == true):
		arrugado = true
		espumado = false
		Debug.dprint("arrugado")
		sprite_2d.modulate = Color(54,77,0)





	

func enemy():
	pass


func _on_timer_timeout():
	if not mojado:
		var direccion = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()
		velocity = direccion*speed
	else: 
		$Timer.stop()
	
func _physics_process(delta):
	if mojado:
		var direccion = global_position.direction_to(Global.player.global_position)
		velocity = direccion*speed
	move_and_slide()

