extends Node2D


func _ready():
	await get_tree().create_timer(3).timeout
	pass # Replace with function body.



func _on_button_pressed():
	await get_tree().create_timer(1.0).timeout
	Trans.change_scene("res://fuentes/Dialogos/EscenariosFinal/FinalEs3.tscn")
	
	pass # Replace with function body.
