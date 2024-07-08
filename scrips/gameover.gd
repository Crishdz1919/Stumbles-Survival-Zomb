extends CanvasLayer

@onready var anim = $AnimationPlayer

func _ready():
	# layer es para poner el CanvasLayer detrás del juego
	layer = -1
	anim.play("game")

func reload_current() -> void:
	# layer es para poner el CanvasLayer delante del juego
	$AudioStreamPlayer2.play()
	get_tree().paused = true
	await get_tree().create_timer(.7).timeout
	$AudioStreamPlayer.play()
	layer = 1
	get_tree().paused = true
	# Reproducir la animación: "game"
	anim.play("game")
	await anim.animation_finished
	$VBoxContainer.visible=true
	
func _on_button_pressed():
# Recargar la escena actual desde el botón
	@warning_ignore("unused_variable")
	var current_scene = get_tree().current_scene
	get_tree().paused = false
	layer = -1
	# Recargar la escena actual
	get_tree().reload_current_scene()
	$VBoxContainer.hide()

func _on_button_2_pressed():
	Trans.change_scene("res://mundo.tscn")
	get_tree().paused = false
	layer = -1
	$VBoxContainer.hide()
