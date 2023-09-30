extends CharacterBody2D

@export var speed = 150
var aceleration = 1000
@onready var _animated_sprite = $AnimatedSprite2D

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(delta):
	var move_input = Input.get_axis("left","right")
	get_input()
	velocity.x = move_toward(velocity.x,speed*move_input,aceleration*delta)
	move_and_slide()
	

func _process(_delta):
	if Input.is_action_pressed("right") or Input.is_action_pressed("left") or Input.is_action_pressed("up") or Input.is_action_pressed("down"):
		_animated_sprite.play("run")
	if Input.is_action_just_pressed("attack"):
		_animated_sprite.play("attack")
	else:
		_animated_sprite.play("idle")
