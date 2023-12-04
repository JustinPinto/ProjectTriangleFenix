extends Node

signal inventario_cambio

enum armas {
	NADA,
	BALDE,
	DETERGENTE,
	ESPONJA,
	TRAPO
}

var player_current_attack = false
var player = null
# 1 para balde, 2 para detergente, 3 para esponja y 4 para trapo
var equipado = null
var inventario = null:
	set(value):
		inventario = value
		inventario_cambio.emit()		

var enemy_count = 0
var max_enemys = 4


