extends CharacterBody2D
@onready var pivot = $pivot
@export var speed = 150
var aceleration = 1000
@onready var _animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	var move_input = Input.get_axis("left","right")
	velocity.x = move_toward(velocity.x,speed*move_input,aceleration*delta)
	move_and_slide()
	
	velocity = input_direction * speed
	var move_input = Input.get_vector("left", "right", "up", "down")
	if move_input !=0:
		
	

func _process(_delta):
	pass
