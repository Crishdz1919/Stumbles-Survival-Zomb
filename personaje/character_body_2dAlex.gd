extends CharacterBody2D

const SPEED = 90.0
const JUMP_VELOCITY = -800
const GRAVITY = 75

@onready var Anim = $AnimatedSprite2D
@onready var spr = $Sprite2D
@onready var attack_shape = $attack/CollisionShape2D
@onready var animation_player = $AnimationPlayer

var attack_timer = 0.0
var attacking = false
var jump_boost_timer = 0.0
var is_boosted = false

func _ready():
	# Asegurarse de que las animaciones y visibilidad estén configuradas correctamente al inicio
	Anim.visible = true
	spr.visible = false
	Anim.play("idle")
	attack_shape.disabled = true

func _physics_process(delta):
	# Actualizar la velocidad vertical con gravedad
	if not is_on_floor():
		velocity.y += GRAVITY
		if not attacking:
			Anim.play("fall")
	else:
		if not attacking and velocity.x == 0:
			Anim.play("idle")

	# Comprobación de ataque
	if Input.is_action_just_pressed("ata"):
		attack_shape.disabled = false
		Anim.visible = false
		spr.visible = true
		animation_player.play("atacar")
		attacking = true
		attack_timer = 0.0

	# Comprobación de salto
	if Input.is_action_just_pressed("saltar") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		Anim.play("jump")
		is_boosted = true
		jump_boost_timer = 0.0

	if is_boosted:
		jump_boost_timer += delta
		if jump_boost_timer >= 0.4:
			is_boosted = false

	# Movimiento horizontal
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		if is_boosted:
			velocity.x = direction * 180.0
		else:
			velocity.x = direction * SPEED

		if is_on_floor() and not attacking:
			Anim.play("run")

		if direction < 0:
			attack_shape.position.x = -18.5
			Anim.flip_h = true
			spr.flip_h = true
		elif direction > 0:
			attack_shape.position.x = 18.5
			Anim.flip_h = false
			spr.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor() and not attacking:
			Anim.play("idle")

	# Gestión del estado de ataque
	if attacking:
		attack_timer += delta
		if attack_timer >= 0.5:
			attacking = false
			Anim.visible = true
			spr.visible = false
			attack_shape.disabled = true

	move_and_slide()

	# Reproducir la animación correcta después de movernos
	if is_on_floor() and not attacking:
		if direction != 0:
			Anim.play("run")
		else:
			Anim.play("idle")

func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"atacar":
			attacking = false
			Anim.visible = true
			spr.visible = false
			attack_shape.disabled = true

func _on_attack_body_entered(body):
	if body.is_in_group("ene"):
		body.hit = true
