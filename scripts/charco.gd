extends Area2D
@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var sprite_2d = $Sprite2D
@onready var playback = animation_tree.get("parameters/playback")


func _on_body_entered(body: Node2D) -> void:
	body.resbalar()
	Debug.dprint("charco")
	
	
	
func _ready():
	animation_tree.active = true	
	
func _process(delta):
	pass
	
