extends CharacterBody2D
@export var speed = 150
var aceleration = 1000
#@onready var _animated_sprite = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
@onready var pivot: Node2D = $pivot
@onready var agua_spawn: Marker2D = $pivot/AguaSpawn
@onready var collision_shape_2d: CollisionShape2D = $pivot/Agua2/CollisionShape2D
@onready var agua_2: Area2D = $pivot/Agua2

#@export var agua_scene : PackedScene


func _ready() -> void:
	animation_tree.active = true

func _physics_process(delta):
	#var move_input = Input.get_axis("left","right")
	var move_input = Input.get_vector("left", "right", "up", "down")
	velocity.x = move_toward(velocity.x,speed*move_input.x,aceleration*delta)
	velocity.y = move_toward(velocity.y,speed*move_input.y,aceleration*delta)
	var attacking = Input.is_action_just_pressed("attack")
	move_and_slide()
	
	collision_shape_2d.disabled = attacking
	agua_2.visible = attacking
		#fire()
	#velocity = input_direction * speed
	if move_input.x != 0: #para que se quede mirando al lado correcta a pesar de frenar
		pivot.scale.x = sign(move_input.x)
	
	# Animation
	if attacking: #abs(velocity.x) > 10 or move_input != 0:
		playback.travel("attack")
		
	elif move_input.x != 0 or move_input.y != 0:
		playback.travel("run")
		
	

		
	#if (abs(velocity.x) > 10 or abs(velocity.y > 10)) and (move_input.x != 0 and move_input.y != 0):
	else:
		playback.travel("Idle")
	

#func fire():
#	if not agua_scene:
	#	return
	#var agua = agua_scene.instantiate()
	#si pelotudo se mueve a la izq, las balas tambien, entonces no queremos que sean hijos de pelotudo, sino hermanos
	#get_parent().add_child(agua)
	#agua.global_position = agua_spawn.global_position
	#agua.rotation = agua_spawn.global_position.direction_to(sign(move_input.x))
	#esto es a la mala:
	#shot_counter.shots +=1
	#shot_counter.update_shots()
	#Game.shots += 1
	

func _process(_delta):
	pass
