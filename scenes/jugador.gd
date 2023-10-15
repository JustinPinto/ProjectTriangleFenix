extends CharacterBody2D
@export var speed = 150
var aceleration = 1000
#@onready var _animated_sprite = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
@onready var pivot: Node2D = $pivot


func _ready() -> void:
	animation_tree.active = true

func _physics_process(delta):
	#var move_input = Input.get_axis("left","right")
	var move_input = Input.get_vector("left", "right", "up", "down")
	velocity.x = move_toward(velocity.x,speed*move_input.x,aceleration*delta)
	velocity.y = move_toward(velocity.y,speed*move_input.y,aceleration*delta)
	move_and_slide()
	
	#velocity = input_direction * speed
	
	# Animation
	if move_input.x != 0: #para que se quede mirando al lado correcta a pesar de frenar
		pivot.scale.x = sign(move_input.x)

	if Input.is_action_just_pressed("attack"):#abs(velocity.x) > 10 or move_input != 0:
		playback.travel("attack")
	else:
		playback.travel("Idle")
	

func _process(_delta):
	pass
