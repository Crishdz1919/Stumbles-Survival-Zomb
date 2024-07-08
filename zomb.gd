extends CharacterBody2D

const ZombRun = 30
const Gravedad = 98
var dead = 1
var hit = false

func _ready():
	velocity.x = -ZombRun
	$AnimatedSprite2D.play("run")
	
	
func _physics_process(_delta):
	velocity.y += Gravedad
	Dead()
	
	if is_on_wall():
		if !$AnimatedSprite2D.flip_h:
			velocity.x = ZombRun
		else:
			velocity.x = -ZombRun
			
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = false
	elif velocity.x > 0:
		$AnimatedSprite2D.flip_h = true
		

	
	move_and_slide()

func Dead():
	if hit == true:
		if dead >0:
			set_physics_process(false)
			$AnimatedSprite2D.play("Dead")
			await ($AnimatedSprite2D.animation_finished)
			queue_free()
		

func _on_atac_body_entered(body):
	if body.is_in_group("player"):
		Gameover.reload_current()
	else:
		$AnimatedSprite2D.play("run")
	pass # Replace with function body.
