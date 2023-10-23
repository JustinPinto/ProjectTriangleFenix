extends CharacterBody2D
@export var speed = 150
var aceleration = 1000
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
@onready var pivot: Node2D = $pivot

var enemy_inattack_range = false
var enemy_attack_cooldown = true

var health = 100:
	set(value):
		health = value
#		if (health_bar):
#			health_bar.value = health
		

@onready var agua_spawn: Marker2D = $pivot/AguaSpawn
@onready var attack_cooldown: Timer = $Attack_cooldown

@export var agua_gpu_scene : PackedScene

var player_alive = true
@export var attacking = false 

func _ready() -> void:
	animation_tree.active = true
	attacking = false
	
func _physics_process(delta):
	#var move_input = Input.get_axis("left","right")
	var move_input = Input.get_vector("left", "right", "up", "down")
	if not attacking:
		velocity.x = move_toward(velocity.x,speed*move_input.x,aceleration*delta)
		velocity.y = move_toward(velocity.y,speed*move_input.y,aceleration*delta)
	else:
		velocity = Vector2.ZERO
	
	enemy_attack()
	
	if health <= 0:
		player_alive = false
		health = 0
		Debug.dprint("Juego terminado :(")
		self.queue_free()
	
	if move_input.x != 0 and not attacking: #para que se quede mirando al lado correcta a pesar de frenar
		pivot.scale.x = sign(move_input.x)
		
	# Animation
	if attacking:
		playback.travel("attack")
		$Attack_cooldown.start()
		Global.player_current_attack = true
		
	elif move_input.x != 0 or move_input.y != 0:
		playback.travel("run")

	else:
		playback.travel("Idle")
	
#
	move_and_slide()

	
func tirar_agua():
	var inicio_agua = agua_gpu_scene.instantiate()
	agua_spawn.add_child(inicio_agua)

func _process(_delta):
	pass


func _on_hitbox_awa_body_entered(body: Node2D) -> void:
	Debug.dprint("eeee")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		attacking = true 

func _on_attack_cooldown_timeout() -> void:
	pass
#	attacking = false
#	Global.player_current_attack = false
	
func take_damage():
	Debug.dprint(health)
	health -= 10



func _on_area_2d_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true
		
func _on_area_2d_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false
		
func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true:
		health = health - 20
		enemy_attack_cooldown = false
		$enemy_attack_cooldown.start()
		print(health)
		
func _on_enemy_attack_cooldown_timeout():
	enemy_attack_cooldown = true
