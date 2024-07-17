extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_button_pressed():
	get_tree().paused = true
	disable_character()
	$AudioStreamPlayer.play()
	await get_tree().create_timer(1.2).timeout
	get_tree().paused = false
	Trans.change_scene("res://fuentes/Dialogos/EscenarioSofia/SofiaEs4.tscn")
	pass # Replace with function body.

func disable_character():
	if $CharacterBody2D:
		$CharacterBody2D.set_physics_process(false)
		$CharacterBody2D.set_process(false)
		$CharacterBody2D.hide()
