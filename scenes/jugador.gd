extends CharacterBody2D
@export var speed = 150
var aceleration = 1000
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
@onready var pivot: Node2D = $pivot

@onready var enemigoprueba = $"../enemigoprueba"
@export var sprite2D : Sprite2D

@onready var agua_spawn: Marker2D = $pivot/AguaSpawn
@onready var attack_cooldown: Timer = $Attack_cooldown

@export var agua_gpu_scene : PackedScene

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
	
<<<<<<< Updated upstream
	enemy_attack()
	
	if health <= 0:
		player_alive = false
		health = 0
		Debug.dprint("Juego terminado :(")
		self.queue_free()
	
=======
>>>>>>> Stashed changes
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

var duration = 1
var oldModulate = self.modulate

func _on_hitbox_awa_body_entered(body: Node2D) -> void:
	Debug.dprint("eeee")
	while duration != 0 :
		body.modulate = Color(0,1,1)
		print("Timer started.")
		await get_tree().create_timer(1.0).timeout
		print("Timer ended.")
		duration = 0
		body.modulate = oldModulate
	duration = 1 	


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		attacking = true 

func _on_attack_cooldown_timeout() -> void:
	pass
#	attacking = false
#	Global.player_current_attack = false
	
