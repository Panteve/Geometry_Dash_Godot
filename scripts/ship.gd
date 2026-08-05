extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -270.0
const ROTATION_SPEED = 380.0

var fixed_camera_y: float

func _ready() -> void:
	$HitboxAzulInterior.area_entered.connect(_on_death_hitbox)
	$HitboxAzulInterior.body_entered.connect(_on_death_hitbox)
	$DetectorPinchos.area_entered.connect(_on_death_hitbox)
	
	if fixed_camera_y == 0.0:
		fixed_camera_y = $Camera2D.global_position.y

func _physics_process(delta: float) -> void:
	velocity += get_gravity() * delta

	if Input.is_action_pressed("jump"):
		velocity.y -= 1500.0 * delta
		

	velocity.y = clamp(velocity.y, -300.0, 400.0)
		

	$Ship001.rotation_degrees = clamp(velocity.y * 0.1, -25.0, 25.0)

	velocity.x = SPEED

	move_and_slide()
	
	# Mantener la cámara en la misma altura (solo sigue en X)
	if fixed_camera_y != 0.0:
		$Camera2D.global_position.y = fixed_camera_y

func _on_death_hitbox(_node: Node2D) -> void:
	die()

func die() -> void:
	get_tree().reload_current_scene()
