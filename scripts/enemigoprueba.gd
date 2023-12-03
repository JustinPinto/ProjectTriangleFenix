extends CharacterBody2D
var mojado = false
var espumado = false
var arrugado = false
var secado = false
var oldModulate = self.modulate
var arma : Global.armas = Global.armas.NADA
@export var speed = 10000

@onready var jugador = Global.player
#var arma: Global.armas = Global.armas




var health = 400:
	set(value):
		health = value
		if enemigo_vida:
			enemigo_vida.set_health(health)


@onready var window = $"../Window"
@onready var enemigo_vida = $EnemigoVida
@onready var sprite_2d = $Sprite2D

func _ready():
	enemigo_vida.set_health(health)

func take_damage() -> void:
	if jugador.arma == Global.armas.NADA:
		pass
		# sonido estupido
			
	elif jugador.arma == Global.armas.BALDE:
		Debug.dprint("ataque con balde!")
		Debug.dprint(health)
		setMojado()
		
		if mojado == true:
			health -= 20
		else: health -=10		
					
	elif jugador.arma == Global.armas.DETERGENTE:
		Debug.dprint("ataque con detergente!")
		Debug.dprint(health)
		setDetergente()
		
		if espumado == true:
			health -= 30	
		else: health -=10	
				
	elif jugador.arma == Global.armas.ESPONJA:
		Debug.dprint("ataque con esponja!")
		Debug.dprint(health)
		
		setEscobilla()
		
		if arrugado == true:
			health -= 40
		else: health -= 10
			
	elif jugador.arma == Global.armas.TRAPO:
		pass
		
	if health <= 0:
		secado = true
		queue_free()
		Debug.dprint("muerto x.x")	





#Cuando ataca con un balde
func setMojado() -> void:
	if (mojado == false and espumado == false and arrugado == false || mojado == true):
		sprite_2d.modulate = Color(0.1,0,0.4)		
		mojado = true
		$Timer.start()
		Debug.dprint("mojado")
	else:
		pass
		
	

#Cuando ataca con un detergente
func setDetergente() -> void:
	if (mojado == true and espumado == false and arrugado == false || espumado == true):
		sprite_2d.modulate = oldModulate
		sprite_2d.modulate = Color(204,255,204)
		espumado = true
		mojado = false
		$Timer.start()
		Debug.dprint("detergente")


#Cuando ataca con una esponja
func setEscobilla() -> void:
	if (mojado == false and espumado == true and arrugado == false || arrugado == true):
		sprite_2d.modulate = oldModulate
		sprite_2d.modulate = Color(5,2,1)
		arrugado = true
		espumado = false
		$Timer.start()
		Debug.dprint("arrugado")
		





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

