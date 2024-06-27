extends Node2D



func _on_button_pressed():
	Trans.change_scene("res://mundo/mundo_3.tscn")
	pass # Replace with function body.


func _on_button_2_pressed():
	get_tree().quit()
	pass # Replace with function body.
