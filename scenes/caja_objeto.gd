extends MarginContainer

@onready var herramienta = %herramienta

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.inventario_cambio.connect(on_inventario_cambio)
	
func on_inventario_cambio():
	herramienta.texture = Global.inventario.get_texture()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
