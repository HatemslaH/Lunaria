extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D
@export var speed = 200
var is_attacking = false

func _ready() -> void:
	_animated_sprite.play("idle")
	

func _process(delta: float) -> void:
	var velocity = Vector2.ZERO

	if not is_attacking:
		if Input.is_action_pressed("move_bottom") and Input.is_action_just_pressed("attack"):
			_animated_sprite.play("attack_bottom")
			is_attacking = true
		elif Input.is_action_pressed("move_right") and Input.is_action_just_pressed("attack"):
			_animated_sprite.flip_h = false
			_animated_sprite.play("attack_right")
			is_attacking = true
		elif Input.is_action_pressed("move_left") and Input.is_action_just_pressed("attack"):
			_animated_sprite.flip_h = true
			_animated_sprite.play("attack_right")
			is_attacking = true
		elif Input.is_action_pressed("move_up") and Input.is_action_just_pressed("attack"):
			_animated_sprite.play("attack_up")
			is_attacking = true
		elif Input.is_action_pressed("move_bottom"):
			velocity = Vector2(0, 1)
			_animated_sprite.play("run_bottom")
		elif Input.is_action_pressed("move_right"):
			velocity = Vector2(1, 0)
			_animated_sprite.flip_h = false
			_animated_sprite.play("run_right")
		elif Input.is_action_pressed("move_left"):
			velocity = Vector2(-1, 0)
			_animated_sprite.flip_h = true
			_animated_sprite.play("run_right")
		elif Input.is_action_pressed("move_up"):
			velocity = Vector2(0, -1)
			_animated_sprite.play("run_up")
		else:
			_animated_sprite.play("idle")

	move_and_collide(velocity * delta * speed)


func _on_animated_sprite_2d_animation_finished() -> void:
	is_attacking = false
