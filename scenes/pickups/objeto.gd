class_name Objeto
extends Node2D

@onready var jugador = Global.player
@onready var sprite_2d = $Sprite2D
@onready var sprite_quieto = $spriteQuieto

@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree


@export var tipo_arma : Global.armas = Global.armas.NADA

var player_is_near = false
var posicion = self.global_position


func get_texture():
	return sprite_2d.texture
		
func _ready():
	pass
	
func _process(delta):
	if player_is_near and Input.is_action_just_pressed("interact"):
		Debug.dprint("objeto recogido")
		jugador.arma = tipo_arma
		
		Debug.dprint(jugador.arma)
		Global.inventario = self.sprite_quieto

func _on_body_entered(body):
	if body.has_method("player"):
		player_is_near = true
		sprite_2d.material.set_shader_parameter("width",5)	

func _on_body_exited(body):
	if body.has_method("player"):
		player_is_near = false
		sprite_2d.material.set_shader_parameter('width',0)
