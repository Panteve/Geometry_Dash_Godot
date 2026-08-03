extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -230.0
const ROTATION_SPEED = 380.0


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		$Sprite2D.rotation_degrees += ROTATION_SPEED * delta
	else:
		$Sprite2D.rotation_degrees = round($Sprite2D.rotation_degrees / 90.0) * 90.0
	
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	velocity.x = SPEED

	move_and_slide()
	if is_on_wall():
		die()

func _on_hitbox_roja_area_entered(_area: Area2D) -> void:
	die()

func die() -> void:
	get_tree().reload_current_scene()
