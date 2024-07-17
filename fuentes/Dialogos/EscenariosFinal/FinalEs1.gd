extends Node2D


func _ready():
	await get_tree().create_timer(1.2).timeout
	pass # Replace with function body.


func _on_button_pressed():
	Trans.change_scene("res://fuentes/Dialogos/EscenariosFinal/FinalEs2.tscn")
	
	pass # Replace with function body.




