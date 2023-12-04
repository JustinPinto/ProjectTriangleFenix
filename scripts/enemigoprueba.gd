extends CharacterBody2D
enum states{SUCIO, MOJADO, ESPUMADO, ESCOBILLADO, SECADO}

#var mojado = false
#var espumado = false
#var arrugado = false
#var secado = false
var oldModulate = self.modulate
var arma : Global.armas = Global.armas.NADA
var tiempo_mojado = 0
var state = states.SUCIO
@export var duracion_mojado = 3
@export var speed = 30

@onready var jugador = Global.player
#var arma: Global.armas = Global.armas
@onready var goteando: GPUParticles2D = $goteando
@onready var movimiento_random: Timer = $MovimientoRandom

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
	


func _process(delta):
	
	
	if state == states.MOJADO:
		tiempo_mojado += delta
		if tiempo_mojado >= duracion_mojado:
			setSucio()
	
	else:
		goteando.emitting = false

func take_damage() -> void:
	if jugador.arma == Global.armas.NADA:
		pass
		# sonido estupido
			
	elif jugador.arma == Global.armas.BALDE:
		Debug.dprint("ataque con balde!")
		Debug.dprint(health)
		setMojado()
		
		if state == states.MOJADO:
			health -= 20
		else: health -=10		
					
	elif jugador.arma == Global.armas.DETERGENTE:
		Debug.dprint("ataque con detergente!")
		Debug.dprint(health)
		setDetergente()
		
		if state == states.ESPUMADO:
			health -= 30	
		else: health -=10	
				
	elif jugador.arma == Global.armas.ESPONJA:
		Debug.dprint("ataque con esponja!")
		Debug.dprint(health)
		
		setEscobilla()
		
		if state == states.ESCOBILLADO:
			health -= 40
		else: health -= 10
			
	elif jugador.arma == Global.armas.TRAPO:
		pass
		
	if health <= 0:
		Debug.dprint("muerto x.x")	
		queue_free()



func setSucio() -> void:
	movimiento_random.start()
	goteando.emitting = false
	state = states.SUCIO
	sprite_2d.modulate = oldModulate

#Cuando ataca con un balde
func setMojado() -> void:
	if state == states.MOJADO or state == states.SUCIO:
		sprite_2d.modulate = Color(0.1,0,0.4)		
		state = states.MOJADO
		Debug.dprint("mojado")
		goteando.emitting = true
		tiempo_mojado = 0

#Cuando ataca con un detergente
func setDetergente() -> void:
	if state == states.MOJADO or state == states.ESPUMADO:
		sprite_2d.modulate = oldModulate
		sprite_2d.modulate = Color(204,255,204)
		state = states.ESPUMADO
		Debug.dprint("detergente")


#Cuando ataca con una esponja
func setEscobilla() -> void:
	if state == states.ESCOBILLADO or state == states.ESPUMADO:
		sprite_2d.modulate = oldModulate
		sprite_2d.modulate = Color(5,2,1)
		state == states.ESCOBILLADO

		Debug.dprint("arrugado")
	
func enemy():
	pass

func _on_timer_timeout():
	if state == states.SUCIO:
		var direccion = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()
		velocity = direccion*speed
	else: 
		movimiento_random.stop()
	
func _physics_process(delta):
	if state != states.SUCIO:
		var direccion = global_position.direction_to(Global.player.global_position)
		velocity = direccion*speed
	move_and_slide()

