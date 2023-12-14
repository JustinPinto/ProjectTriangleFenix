extends CharacterBody2D
enum states{SUCIO, MOJADO, ESPUMADO, ESCOBILLADO}

#var mojado = false
#var espumado = false
#var arrugado = false
#var secado = false
var oldModulate = self.modulate
var arma : Global.armas = Global.armas.NADA

var tiempo_mojado = 0
var tiempo_espumado = 0


var state = states.SUCIO
@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")

@export var duracion_mojado = 5
@export var duracion_espumado = 5

@export var speed = 30
@export var charco_scene: PackedScene


@onready var jugador = Global.player
#var arma: Global.armas = Global.armas
@onready var goteando: GPUParticles2D = $goteando
@onready var movimiento_random: Timer = $MovimientoRandom
@onready var charco_spawn: Marker2D = $CharcoSpawn
@onready var espumando = $espumando



var health = 100:
	set(value):
		health = value
		if enemigo_vida:
			enemigo_vida.set_health(health)


@onready var window = $"../Window"
@onready var enemigo_vida = $EnemigoVida
@onready var sprite_2d = $Sprite2D


func _ready():
	animation_tree.active = true
	enemigo_vida.set_health(health)
	Global.enemy_count += 1
	


func _process(delta):

	if state == states.MOJADO:
		tiempo_mojado += delta
		if tiempo_mojado >= duracion_mojado:
			playback.travel("sacudida")
			setSucio()
			
	elif state == states.ESPUMADO:
		tiempo_espumado += delta
		if tiempo_espumado >= duracion_espumado:
			playback.travel("sacudida")
			setSucio()
		
	else:
		espumando.emitting = false
		goteando.emitting = false	


func take_damage() -> void:
	playback.travel("daño")
	
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
		Global.enemy_count -= 1
		Debug.dprint("muerto x.x")	
		
		playback.travel("muerte")
		goteando.emitting = false
		espumando.emitting = false
		await get_tree().create_timer(5.0, false).timeout
		queue_free()



func setSucio() -> void:
	movimiento_random.start()
	goteando.emitting = false
	espumando.emitting = false
	state = states.SUCIO
	sprite_2d.modulate = oldModulate

#Cuando ataca con un balde
func setMojado() -> void:
	if state == states.MOJADO or state == states.SUCIO:
		sprite_2d.modulate = Color(0.2,0.2,0.8)		
		state = states.MOJADO
		Debug.dprint("mojado")
		goteando.emitting = true
		tiempo_mojado = 0
		if not charco_scene:
			return
		await get_tree().create_timer(3.0, false).timeout
		var charco = charco_scene.instantiate()
		get_parent().add_child(charco)
		charco.global_position = charco_spawn.global_position
		

#Cuando ataca con un detergente
func setDetergente() -> void:
	if state == states.MOJADO or state == states.ESPUMADO:
		sprite_2d.modulate = oldModulate
		sprite_2d.modulate = Color(2,3,4)
		state = states.ESPUMADO
		
		Debug.dprint("detergente")
		goteando.emitting = false
		espumando.emitting = true
		
		tiempo_espumado = 0
		if not charco_scene:
			return
		await get_tree().create_timer(3.0, false).timeout
		var charco = charco_scene.instantiate()
		get_parent().add_child(charco)
		charco.global_position = charco_spawn.global_position


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

