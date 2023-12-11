extends Area2D

@onready var jugador = Global.player
@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var sprite_2d = $Sprite2D
@onready var playback = animation_tree.get("parameters/playback")

var player_is_near = false

func _ready():
	animation_tree.active = true	
	
func _process(delta):
	if player_is_near and jugador.arma == Global.armas.TRAPO and Input.is_action_just_pressed("attack"):
		Debug.dprint("charco limpiado")
		queue_free()

func _on_area_entered(area):
	Debug.dprint(area.name)
	if area.name == "hitboxPies":
		jugador.resbalar()
		
func _on_clean_area_entered(area):
	if area.name == "hitboxPies" and jugador.arma == Global.armas.TRAPO:
		sprite_2d.material.set_shader_parameter("width",5)	
		player_is_near = true


func _on_clean_area_exited(area):
	if area.name == "hitboxPies" and jugador.arma == Global.armas.TRAPO:
		sprite_2d.material.set_shader_parameter("width",0)	
		player_is_near = false
