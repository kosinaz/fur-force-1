extends Node2D

signal animal_pressed
signal go_pressed

func _input(event):
	if $CanvasLayer/AnimationPlayer.current_animation_position > 6:
		return
	if event is InputEventMouseButton or event is InputEventKey:
		$CanvasLayer/AnimationPlayer.advance(6)

func _on_button_pressed(name):
	emit_signal("animal_pressed", name)

func _on_go_pressed():
	emit_signal("go_pressed")
