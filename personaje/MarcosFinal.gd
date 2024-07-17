extends CharacterBody2D

const SPEED = 70.0

@onready var Anim = $AnimatedSprite2D
@onready var spr = $Sprite2D
@onready var attack_shape = $attack/CollisionShape2D
@onready var animation_player = $AnimationPlayer

var attack_timer = 0.0
var attacking = false

func _ready():
	# Asegurarse de que las animaciones y visibilidad estén configuradas correctamente al inicio
	Anim.visible = true
	spr.visible = false
	Anim.play("idle")
	attack_shape.disabled = true

func _physics_process(delta):
	# Comprobación de ataque
	if Input.is_action_just_pressed("ata"):
		attack_shape.disabled = false
		Anim.visible = false
		spr.visible = true
		animation_player.play("atacar")
		attacking = true
		attack_timer = 0.0
		$AudioStreamPlayer2D.play()

	# Movimiento horizontal y vertical
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	
	if direction_x != 0:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if direction_y != 0:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	if direction_x != 0 or direction_y != 0:
		if not attacking:
			Anim.play("run")

		if direction_x < 0:
			attack_shape.position.x = -18.5
			Anim.flip_h = true
			spr.flip_h = true
		elif direction_x > 0:
			attack_shape.position.x = 18.5
			Anim.flip_h = false
			spr.flip_h = false
			
	else:
		if not attacking:
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
	if not attacking:
		if direction_x != 0 or direction_y != 0:
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
