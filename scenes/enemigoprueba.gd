extends CharacterBody2D
var mojado = false
var espumado = false
var arrugado = false
var secado = false
var oldModulate = self.modulate


@onready var window = $"../Window"


func setMojado(nuevo) -> void:
	modulate = Color(0.1,0,0.4)
	mojado = nuevo
	Debug.dprint(mojado)

func setDetergente() -> void:
	if (mojado == true):
		espumado = true
		mojado = false
		Debug.dprint("detergente")
		modulate = Color(204,255,204)

func setEscobilla() -> void:
	if (espumado == true):
		arrugado = true
		espumado = false
		Debug.dprint("detergente")
		modulate = Color(54,77,0)

func setSeco() -> void:
	if (arrugado == true):
		secado = true
		arrugado = false
		Debug.dprint("detergente")
		modulate = Color(24,121,94)




func enemy():
	pass
