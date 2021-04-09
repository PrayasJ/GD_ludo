extends Node2D

signal roll(r)

func _ready():
	pass # Replace with function body.
var can_roll = true

func allow():
	can_roll = true

func change(curr):
	can_roll = true
	if can_roll:
		randomize()
		for i in range(10):
			yield(get_tree().create_timer(0.1), "timeout")
			get_node(curr).hide()
			curr = str(1+randi()%6)
			get_node(curr).show()
		emit_signal('roll',curr)
		can_roll = false

func _on_1_pressed():
	change("1")

func _on_2_pressed():
	change("2")

func _on_3_pressed():
	change("3")

func _on_4_pressed():
	change("4")

func _on_5_pressed():
	change("5")

func _on_6_pressed():
	change("6")
