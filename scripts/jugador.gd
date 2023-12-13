extends CharacterBody2D
@export var speed = 500
@export var agua_gpu_scene : PackedScene
@export var detergente_gpu_scene: PackedScene


@export var attacking = false 
@export var multiplicadorResbalado = 2
@export var duracion_resbale = 1.5

@onready var sprite_2d = $pivot/Sprite2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
@onready var pivot: Node2D = $pivot
@onready var health_bar = $CanvasLayer/mona_vida

@export var resbalo = false
var oldModulate = self.modulate
var tiempo_resbale = 0
var enemy_inattack_range = false
var enemy_attack_cooldown = true
var taking_damage = false
var arma : Global.armas = Global.armas.NADA
var player_alive = true
var aceleration = 1000
var health = 200:
	set(value):
		health = value
		if (health_bar):
			health_bar.set_health(health)
		

@onready var agua_spawn: Marker2D = $pivot/AguaSpawn
@onready var detergente_spawn = $pivot/detergenteSpawn

@onready var attack_cooldown: Timer = $Attack_cooldown



func _ready() -> void:
	animation_tree.active = true
	attacking = false
	resbalo = false
	health_bar.set_health(health)
	Global.player = self
	
func _physics_process(delta):
	if player_alive:
		var move_input = Input.get_vector("left", "right", "up", "down")
		if resbalo:
			tiempo_resbale += delta
			if tiempo_resbale > duracion_resbale:
				tiempo_resbale = 0
				resbalo = false
				
			var direccion = velocity.normalized()
			velocity = direccion*multiplicadorResbalado*speed
			#Debug.dprint(velocity)
				
		elif not attacking:
			velocity.x = move_toward(velocity.x,speed*move_input.x,aceleration)
			velocity.y = move_toward(velocity.y,speed*move_input.y,aceleration)
			
		elif attacking && arma == Global.armas.DETERGENTE:
			velocity.x = move_toward(velocity.x,speed*move_input.x* 0.1,aceleration)
			velocity.y = move_toward(velocity.y,speed*move_input.y* 0.1,aceleration)
			
		else:	
			velocity.x = move_toward(velocity.x,speed*move_input.x* 0.4,aceleration)
			velocity.y = move_toward(velocity.y,speed*move_input.y* 0.4,aceleration)
		
		enemy_attack()
	
		if health <= 0:
			player_alive = false
			health = 0
			Debug.dprint("Juego terminado :(")
#			self.hide()
		
		if move_input.x != 0 and not attacking: # para que se quede mirando al lado correcta a pesar de frenar
			pivot.scale.x = sign(move_input.x)
			
		# Animation
		
		if not attacking:
#			playback.travel("attack")
#			$Attack_cooldown.start()
#			Global.player_current_attack = true
			if resbalo:
				playback.travel("resbalo")
			
			elif taking_damage:
				playback.travel("daño")
				if !player_alive:
					playback.travel("muerte")
#					playback.travel("muerte2")
					
				
			elif move_input.x != 0 or move_input.y != 0:
				playback.travel("run")		
			else:
				playback.travel("Idle2")
			
		move_and_slide()

	
func tirar_agua():
	var inicio_agua = agua_gpu_scene.instantiate()
	agua_spawn.add_child(inicio_agua)
	
func tirar_detergente(): 	
	var inicio_detergente = detergente_gpu_scene.instantiate()
	detergente_spawn.add_child(inicio_detergente)

func _process(_delta):
	pass

#var duration = 1


## ATAQUE
func _on_hitbox_awa_body_entered(body: Node2D) -> void:
	##llama a la funcion ataque de enemigo
	if body.has_method("enemy") and attacking == true:
		body.take_damage()
		

func player():
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		if resbalo:
			playback.travel("resbalo")
			
		$Attack_cooldown.start()
		if arma == Global.armas.NADA:
			Global.player_current_attack = true
			attacking = true 
			playback.travel("attack_nada")
			# sonido estupido
			
		elif arma == Global.armas.BALDE:
			Global.player_current_attack = true
			attacking = true 
			playback.travel("attack_balde")
			
				
		elif arma == Global.armas.DETERGENTE:
			Global.player_current_attack = true
			attacking = true 
			playback.travel("attack_detergente")
			
		elif arma == Global.armas.ESPONJA:
			Global.player_current_attack = true
			attacking = true 
			playback.travel("attack_esponja")
			
		elif arma == Global.armas.TRAPO:
			attacking = true 
			playback.travel("attack_trapo")
			

func _on_attack_cooldown_timeout() -> void:
	pass
#	attacking = false
#	Global.player_current_attack = false


func _on_area_2d_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true
		
func _on_area_2d_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false
		
func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true:
		
		sprite_2d.modulate = Color(0.8,0.3,0.3)
		taking_damage = true
		health = health - 10
		enemy_attack_cooldown = false
		$enemy_attack_cooldown.start()
		print(health)
		await get_tree().create_timer(0.3).timeout # wait for 1 second
		sprite_2d.modulate = oldModulate
		

	else: 
		taking_damage = false	
		
func _on_enemy_attack_cooldown_timeout():
	enemy_attack_cooldown = true
	
func resbalar():
	resbalo = true
	
	#ver cambio de sprite
	#
