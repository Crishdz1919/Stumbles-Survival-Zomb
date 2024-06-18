extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Animaciones.play("Normal")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direccion = Vector2.ZERO

	# Verificamos las teclas de dirección
	if Input.is_action_pressed("ui_left"):
		direccion.x -= 1
	if Input.is_action_pressed("ui_right"):
		direccion.x += 1
	if Input.is_action_pressed("ui_up"):
		direccion.y -= 1
	if Input.is_action_pressed("ui_down"):
		direccion.y += 1

	# Normalizamos la dirección
	direccion = direccion.normalized()
	
	# Actualizamos la velocidad y reproducimos la animación adecuada
	if direccion != Vector2.ZERO:
		velocity = direccion * 300

		# Determinamos la animación a reproducir
		if direccion.x < 0:
			if not $Animaciones.is_playing() or $Animaciones.current_animation != "CaminarMarcosIzq":
				$Animaciones.play("CaminarAlexIzq")
		else:
			if not $Animaciones.is_playing() or $Animaciones.current_animation != "CaminarMarcos":
				$Animaciones.play("CaminarAlex")
	else:
		velocity = Vector2.ZERO
		$Animaciones.stop()
		$Animaciones.play("Normal")

	move_and_slide()
