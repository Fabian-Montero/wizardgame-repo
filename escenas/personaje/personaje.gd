extends CharacterBody2D
signal personaje_muerto 
@export var animacion: AnimatedSprite2D
@export var area_2d: Area2D
@export var material_personaje_rojo: ShaderMaterial

const _velocidad:float = 100.0
const _velocidad_salto:float = -300.0
var _muerto: bool

func _ready():
	add_to_group("personajes")
	area_2d.body_entered.connect(_on_area_2d_body_entered)

func _physics_process(delta):	
	
	if _muerto:
		return
	# animaciones
	if !is_on_floor():
		animacion.play("saltar")
	elif velocity.x != 0:
		animacion.play("correr")
	else:
		animacion.play("idle")	
	# gravedad 
	velocity += get_gravity() * delta
	
	# salto
	if Input.is_action_just_pressed("Saltar") && is_on_floor():
		velocity.y = _velocidad_salto
	
	# movimiento lateral
	if Input.is_action_pressed("Derecha") or Input.is_action_pressed("ui_right"):
		velocity.x = _velocidad
		animacion.flip_h = true
	elif Input.is_action_pressed("Izquierda") or Input.is_action_pressed("ui_left"):
		velocity.x = -_velocidad
		animacion.flip_h = false
	else:
		velocity.x = 0
	move_and_slide()

func _on_area_2d_body_entered(_body: Node2D) -> void:
		animacion.material = material_personaje_rojo
		_muerto = true
		animacion.stop()
		await get_tree().create_timer(0.5).timeout
		personaje_muerto.emit()
		
		ControladorGlobal.sumar_muerte()
'''
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

Template de movimiento 


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

'''
