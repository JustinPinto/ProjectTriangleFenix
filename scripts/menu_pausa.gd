extends MarginContainer
@onready var resume: Button = %Resume
@onready var retry: Button = %Retry
@onready var exit: Button = %Exit
#@onready var main_menu = preload("res://scenes/main_menu.tscn") as PackedScene

@export var main_menu: PackedScene

func _ready() -> void:
	hide()
	resume.pressed.connect(_on_resume_pressed)
	retry.pressed.connect(_on_retry_pressed)
	#main_menu.pressed.connect(_on_mainmenu_pressed)
	exit.pressed.connect(_on_exit_pressed)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pausa"):
		visible = !visible
		get_tree().paused = visible

func _on_resume_pressed():
	hide()
	get_tree().paused = false

func _on_retry_pressed():
	get_tree().paused = false	
	get_tree().reload_current_scene()

func _on_mainmenu_pressed():

	get_tree().paused = false
	#get_tree().change_scene_to_packed("res://scenes/main_menu.tscn")

func _on_exit_pressed():
	get_tree().quit()
func _process(delta: float) -> void:
	pass
