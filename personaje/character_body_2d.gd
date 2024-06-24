extends CharacterBody2D

const SPEED = 115.0
const JUMP_VELOCITY = -1300
const Gravity = 98

@onready var Anim = $AnimatedSprite2D
@onready var spr = $Sprite2D
@onready var attack_shape = $attack/CollisionShape2D

var attack_timer = 0.0
var attacking = false

func _physics_process(_delta):
	if not is_on_floor():
		$AnimatedSprite2D.play("fall")
		velocity.y += Gravity
	
	if Input.is_action_just_pressed("ata"):
		attack_shape.disabled = false
		$AnimatedSprite2D.visible = false
		$Sprite2D.visible = true
		$AnimationPlayer.play("atacar")
		attacking = true
		attack_timer = 0.0

	if Input.is_action_just_pressed("saltar") and is_on_floor():
		$AnimatedSprite2D.play("jump")
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.play("run")
	
		if direction < 0:
			attack_shape.position.x = -18.5
			Anim.flip_h = true
			spr.flip_h = true
		elif direction > 0:
			attack_shape.position.x = 18.5
			Anim.flip_h = false
			spr.flip_h = false
	
	else:
		$AnimatedSprite2D.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if attacking:
		attack_timer += _delta
		if attack_timer >= 2.0:
			attacking = false
			velocity.x = 0
	
	move_and_slide()

func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"atacar":
			$AnimatedSprite2D.visible = true
			$Sprite2D.visible = false
			attack_shape.disabled = true

func _on_attack_body_entered(body):
	if body.is_in_group("ene"):
		body.hit = true
