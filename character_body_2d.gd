extends CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# No reproducimos la animación al principio
	$Animaciones.play("Normal")

# Variable para guardar la última dirección horizontal
var ultima_direccion_x = 1

# Variable para controlar el estado de disparo
var is_shooting = false

# Called every frame. 'delta' es el tiempo transcurrido desde el cuadro anterior.
func _physics_process(_delta):
	var direccion = Vector2.ZERO

	# Verificamos si se está disparando
	if is_shooting:
		# Si está disparando, no permitimos el movimiento
		velocity = Vector2.ZERO
	else:
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

			# Determinamos la animación a reproducir y la dirección
			if direccion.x < 0:
				ultima_direccion_x = -1
				if not $Animaciones.is_playing() or $Animaciones.current_animation != "CaminarMarcosIzq":
					$Animaciones.play("CaminarMarcosIzq")
			elif direccion.x > 0:
				ultima_direccion_x = 1
				if not $Animaciones.is_playing() or $Animaciones.current_animation != "CaminarMarcos":
					$Animaciones.play("CaminarMarcos")
		else:
			velocity = Vector2.ZERO
			if not Input.is_action_pressed("disparar"):
				$Animaciones.stop()
				$Animaciones.play("Normal")

	move_and_slide()

	# Verificamos la tecla "x" para disparar
	if Input.is_action_just_pressed("disparar"):
		is_shooting = true
		if ultima_direccion_x < 0:
			$Animaciones.play("DisparoMarcosIzq")
		else:
			$Animaciones.play("DisparoMarcos")

	# Finalizamos el estado de disparo cuando la animación termina
	if is_shooting and not $Animaciones.is_playing():
		is_shooting = false
		$Animaciones.play("Normal")

