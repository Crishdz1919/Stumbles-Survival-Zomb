extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(5.2).timeout
	Trans.change_scene("res://mundo.tscn")
	pass # Replace with function body.


	
