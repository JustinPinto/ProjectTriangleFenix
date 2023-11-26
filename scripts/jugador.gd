extends CharacterBody2D
@export var speed = 500
var aceleration = 1000
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
@onready var pivot: Node2D = $pivot
@onready var health_bar = $CanvasLayer/mona_vida

var enemy_inattack_range = false
var enemy_attack_cooldown = true
var taking_damage = false


var health = 100:
	set(value):
		health = value
		if (health_bar):
			health_bar.set_health(health)
		

@onready var agua_spawn: Marker2D = $pivot/AguaSpawn
@onready var attack_cooldown: Timer = $Attack_cooldown

@export var agua_gpu_scene : PackedScene

var player_alive = true
@export var attacking = false 


func _ready() -> void:
	animation_tree.active = true
	attacking = false
	health_bar.set_health(health)
	Global.player = self
	
func _physics_process(delta):
	#var move_input = Input.get_axis("left","right")
	if player_alive:
		var move_input = Input.get_vector("left", "right", "up", "down")
		if not attacking:
			velocity.x = move_toward(velocity.x,speed*move_input.x,aceleration)
			velocity.y = move_toward(velocity.y,speed*move_input.y,aceleration)
		else:	
			velocity.x = move_toward(velocity.x,speed*move_input.x* 0.4,aceleration)
			velocity.y = move_toward(velocity.y,speed*move_input.y* 0.4,aceleration)
		
		enemy_attack()
	
		if health <= 0:
			player_alive = false
			health = 0
			Debug.dprint("Juego terminado :(")
			self.hide()
		
		if move_input.x != 0 and not attacking: # para que se quede mirando al lado correcta a pesar de frenar
			pivot.scale.x = sign(move_input.x)
			
		# Animation
		if attacking:
			playback.travel("attack")
			$Attack_cooldown.start()
			Global.player_current_attack = true
			
		elif taking_damage == true:
			playback.travel("daño")
						
		elif move_input.x != 0 or move_input.y != 0:
			playback.travel("run")
			

		
		else:
			playback.travel("Idle")
			
		move_and_slide()

	
func tirar_agua():
	var inicio_agua = agua_gpu_scene.instantiate()
	agua_spawn.add_child(inicio_agua)

func _process(_delta):
	pass

var duration = 1


## ATAQUE CON BALDE
func _on_hitbox_awa_body_entered(body: Node2D) -> void:
	## cuando el enemigo no tiene ningun estado encima, y lo ataca con el balde
	## if mojado and espumado and arrugado = false and balde
	if body.has_method("enemy"):
		body.setMojado()
		body.take_damage()
		

## ATAQUE CON DETERGENTE
func _on_hitbox_espuma_body_entered(body: Node2D) -> void:
	## cuando el enemigo esta mojado, y lo ataca con el detergente
	if body.has_method("enemy"):
		body.setDetergente(body)
		body.take_damage()

	

##ATAQUE CON ESCOBILLA
func _on_hitbox_arruga_body_entered(body: Node2D) -> void:
	## cuando el enemigo esta espumado, y lo ataca con la escobilla
	## if detergente and body.espuma = trued
	if body.has_method("enemy"):
		body.setEscobilla(body)
		body.take_damage()
		

func player():
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		attacking = true 

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
		taking_damage = true
		health = health - 10
		enemy_attack_cooldown = false
		$enemy_attack_cooldown.start()
		print(health)
	else: 
		taking_damage = false	
		
func _on_enemy_attack_cooldown_timeout():
	enemy_attack_cooldown = true
