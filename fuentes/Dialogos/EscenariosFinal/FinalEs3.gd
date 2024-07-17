extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(4.2).timeout
	pass # Replace with function body.


	


func _on_button_pressed():
	
	Trans.change_scene("res://fuentes/Dialogos/EscenariosFinal/FinalEs4.tscn")
	pass # Replace with function body.
