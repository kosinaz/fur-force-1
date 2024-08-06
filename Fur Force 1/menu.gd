extends Node2D

var missions = [
	{
		"name": "Chilli",
		"briefing": "Alright, team, we have a situation. There's a fire at the old clock tower, and it's spreading fast.",
	}
]

var mission = randi() % missions.size()

func _ready():
	$"%Briefing".bbcode_text = missions[mission].briefing + "\nFor this mission I will need..."
	
func _input(event):
	if event is InputEventMouseButton:
		$CanvasLayer/AnimationPlayer.advance(6)

func _on_button_pressed(name):
	get_node("%" + name).hide()
	if name == missions[mission].name:
		get_node("%" + name + "Yes").show()
		$"%GoButton".show()
	else:
		get_node("%" + name + "No").show()

func _on_go_pressed():
	get_parent().mission_name = missions[mission].name
	var map = preload("res://map.tscn").instance()
	get_parent().add_child(map)
	queue_free()
