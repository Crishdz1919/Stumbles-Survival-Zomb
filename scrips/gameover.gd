extends CanvasLayer

@onready var anim = $AnimationPlayer

func _ready():
	#layer es para poner el canvaslayer detras del juego
	layer = -1
	$AnimationPlayer.play("game")
	
func reload_current() -> void:
	#layer es para poner el canvaslayer delante del juego
	layer = 1
	get_tree().paused = true
	#Reproducir la animacion: trans
	anim.play("game")
	await ($AnimationPlayer. animation_finished)
	#reiniciar la escena
	get_tree().reload_current_scene()
	anim.play_backwards("game")
	await ($AnimationPlayer. animation_finished)
	get_tree().paused = false
	layer = -1
