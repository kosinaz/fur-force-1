extends Button

func _on_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://game.tscn")
