extends CharacterBody2D

const SPEED = 180.0
const JUMP_VELOCITY = -270.0
const ROTATION_SPEED = 420.0
@onready var explosion = $Explosion_die
@onready var sonido_muerte = $SonidoMuerte
var is_dead = false


var fixed_camera_y: float
enum FORM {
	CUBO, 
	SHIP
}

#//TODO: (RECORDAR A DIEGO) HACER QUE EL TECHO DESAPAREZCA CUANDO ESTA EN CUBO
var current_form = FORM.CUBO

func _ready() -> void:
	$HitboxAzulInterior.body_entered.connect(_on_death_hitbox)
	$DetectorPinchos.area_entered.connect(_on_death_hitbox)
	$Cubo_Nave.visible = false
	$Nave.visible = false
	print(current_form)
	# Guardar la posición Y inicial de la cámara
	fixed_camera_y = $Camera2D.global_position.y
	explosion.visible = false

func _physics_process(delta: float) -> void:
	velocity += get_gravity() * delta
	match current_form:
		FORM.CUBO:
			
			if not is_on_floor():
				$Cubo.rotation_degrees += ROTATION_SPEED * delta
			else:
				$Cubo.rotation_degrees = round($Cubo.rotation_degrees / 90.0) * 90.0
			if Input.is_action_pressed("jump") and is_on_floor():
				velocity.y = JUMP_VELOCITY
		FORM.SHIP:
			if Input.is_action_pressed("jump"):
				velocity.y -= 1700.0 * delta
			velocity.y = clamp(velocity.y, -500.0, 300.0)
			$Nave.rotation_degrees = clamp(velocity.y * 0.1, -25.0, 25.0)
	velocity.x = SPEED

	move_and_slide()
	
	if fixed_camera_y != 0.0:
		$Camera2D.global_position.y = fixed_camera_y

func _on_death_hitbox(_node: Node2D) -> void:
	die()

func set_mode():
	var techo = get_tree().get_first_node_in_group("techo")
	match current_form:
		FORM.CUBO:
			techo.visible = true
			$Cubo_Nave.visible = true
			$Nave.visible = true
			$Cubo.visible = false
			current_form = FORM.SHIP
		FORM.SHIP:
			techo.visible = false
			$Cubo_Nave.visible = false
			$Nave.visible = false
			$Cubo.visible = true
			current_form = FORM.CUBO
func die():
	if is_dead:
		return
	is_dead = true
	velocity = Vector2.ZERO
	set_physics_process(false)

	$Cubo.visible = false
	$Nave.visible = false
	$Cubo_Nave.visible = false
	explosion.visible = true
	explosion.play("dead")
	sonido_muerte.play()

	await get_tree().create_timer(0.5).timeout

	get_tree().reload_current_scene()
