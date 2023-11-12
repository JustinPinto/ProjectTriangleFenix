extends MarginContainer
@onready var resume: Button = %Reanudar
@onready var retry: Button = %Reiniciar
@onready var exit: Button = %Salir

func _ready() -> void:
	hide()
	resume.pressed.connect(_on_resume_pressed)
	retry.pressed.connect(_on_retry_pressed)
	exit.pressed.connect(_on_exit_pressed)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pausa"):
		visible = !visible
		get_tree().paused = visible

func _on_resume_pressed():
	hide()
	get_tree().paused = false

func _on_retry_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false

func _on_exit_pressed():
	get_tree().quit()
func _process(delta: float) -> void:
	pass
