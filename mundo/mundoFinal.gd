extends Node2D

var countdown = [29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0]

func _ready():
	update_text_with_countdown()

func update_text_with_countdown():
	for seconds in countdown:
		$CharacterBody2D/TextEdit.text = str(seconds) + " Seg"
		await get_tree().create_timer(1.0).timeout
	
	# Una vez terminado el conteo, ejecuta el resto del código
	disable_zombie()
	disable_character()
	get_tree().paused = true
	$AudioStreamPlayer.play()
	Trans.change_scene("res://fuentes/Dialogos/EscenariosFinal/FinalEs1.tscn")
	await get_tree().create_timer(1.2).timeout
	get_tree().paused = false
	

func disable_zombie():
	if $zomb:
		$zomb.set_physics_process(false)
		$zomb.set_process(false)
		$zomb.hide()
		
func disable_character():
	if $CharacterBody2D:
		$CharacterBody2D.set_physics_process(false)
		$CharacterBody2D.set_process(false)
		$CharacterBody2D.hide()
