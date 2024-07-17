extends CharacterBody2D

const ZombRun = 40
var player = null
var hit = false

func _ready():
	velocity.x = -ZombRun
	$AnimatedSprite2D.play("run")
	player = get_tree().get_nodes_in_group("player")[0]
	
func _physics_process(_delta):
	follow_player()
	
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

func follow_player():
	if player != null:
		velocity = position.direction_to(player.position) * ZombRun

# Función Dead removida ya que el zombi no puede morir
# func Dead():
#	if hit == true:
#		if dead > 0:
#			set_physics_process(false)
#			$AnimatedSprite2D.play("Dead")
#			await ($AnimatedSprite2D.animation_finished)
#			queue_free()
		
func _on_atac_body_entered(body):
	if body.is_in_group("player"):
		Gameover.reload_current()
	else:
		$AnimatedSprite2D.play("run")
