extends CharacterBody2D


@onready var _animated_sprite = $AnimatedSprite2D
@onready var player = $"../Player"

@export var speed = 100
@export var min_step_delay = 1.0
@export var max_step_delay = 2.0
@export var step_distance = 50.0
@export var chance_to_stay = 0.7

var _is_attacking: bool
var _time_since_last_step: float = 0.0
var _current_step_delay: float = 0.0
var _target_position: Vector2

func _ready() -> void:
	_animated_sprite.play("idle")
	_set_random_step_delay()
	_set_new_target_position()


func _process(delta: float) -> void:
	_time_since_last_step += delta

	if _time_since_last_step >= _current_step_delay:
		_time_since_last_step = 0.0
		print("step")
		_set_random_step_delay()
		_set_new_target_position()
		
	# Randomly choose a direction
	var direction = (_target_position - global_position).normalized()
	if (_target_position - global_position).length() < 1.0:
		direction = Vector2.ZERO
	velocity = direction * speed * delta
	move_and_collide(velocity)

	if direction == Vector2.ZERO:
		_animated_sprite.play("idle")
	elif direction.x > 0:
		_animated_sprite.flip_h = false
		_animated_sprite.play("run_right")
	elif direction.x < 0:
		_animated_sprite.flip_h = true
		_animated_sprite.play("run_right")
	elif direction.y > 0:
		_animated_sprite.play("run_bottom")
	elif direction.y < 0:
		_animated_sprite.play("run_up")


func _set_new_target_position() -> void:
	var direction = Vector2()
	if randf() < chance_to_stay:
		direction = Vector2.ZERO
	else:
		if randi() % 2 == 0:
			direction.x = randf() * 2 - 1
		else:
			direction.y = randf() * 2 - 1
		direction = direction.normalized()
	_target_position = global_position + direction * step_distance


func _set_random_step_delay() -> void:
	_current_step_delay = randf_range(min_step_delay, max_step_delay)