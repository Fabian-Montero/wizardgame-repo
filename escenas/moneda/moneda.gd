extends Node2D

@export var area_2d: Area2D
@export var reproductor: AudioStreamPlayer2D
var contenedor_monedas: ContenedorMonedas
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_2d.body_entered.connect(_recogida)
	_iniciar_animacion()


func _recogida(_body):
	contenedor_monedas._moneda_recogida()
	reproductor.reparent(get_parent().get_parent().get_parent())
	reproductor.play()
	queue_free()

func _iniciar_animacion():
	var tween: Tween = create_tween()
	tween.set_loops(0)
	tween.tween_property(self, "position:y",position.y -5, 0.5)
	tween.tween_property(self, "position:y",position.y +5, 0.5)
	
	
