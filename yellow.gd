extends Node

signal chosen_one(x)

var id = null

func set_id(x):
	id = x

func _ready():
	pass # Replace with function body.


func _on_piece_focus_entered():
	emit_signal("chosen_one",id)
