extends Node2D

var length = 10
var car_left_map_positions = {}
var car_right_map_positions = {}
var crosses = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$"%Police/Sprite".get_node(get_parent().mission_name).show()
	for i in range(31):
		for y in [-8, -7, -5, -4, -2, -1, 1, 2, 4, 5, 7, 8]:
			$TileMap.set_cell(i * length, y, 2)
			var se = range(12, 19)
			se.append_array(range(12, 19))
			se.shuffle()
			var nw = range(28, 35)
			nw.append_array(range(28, 35))
			nw.shuffle()
			for j in range(12):
				$TileMap.set_cell(i * length - 1, y, se[j])
				$TileMap.set_cell(i * length + 1, y, nw[j])
		for y in [-9, -6, -3, 0, 3, 6, 9]:
			$TileMap.set_cell(i * length, y, 1)
			for x in range(1, length):
				$TileMap.set_cell(x + i * length, y, 3)
		var sw2 = range(4, 11)
		sw2.append_array(range(37, 41))
		sw2.shuffle()
		for x in range(2, length - 1):
			$TileMap.set_cell(x + i * length, 2, sw2[x - 2])
		for y in [-7, -4, -1, 5, 8]:
			var sw = range(4, 11)
			sw.append_array(range(37, 41))
			sw.append_array(range(45, 52))
			sw.shuffle()
			for x in range(2, length - 1):
				$TileMap.set_cell(x + i * length, y, sw[x - 2])
		for y in [-8, -5, -2, 1, 4, 7]:
			var ne = range(20, 27)
			ne.shuffle()
			for x in range(2, length - 1):
				$TileMap.set_cell(x + i * length, y, ne[x - 2])
	$TileMap.set_cell(219, -1, 0)
	$"%Man".position = $TileMap.map_to_world(Vector2(219, -1)) + Vector2(0, 20)
	randomize()
	for segment in range(6):
		var car_lefts = range(1, 5)
		var car_rights = range(1, 5)
		car_lefts.shuffle()
		car_rights.shuffle()
		for i in range(4):
			var mod = [-2, 2][randi() % 2]
			var car_left = get_node("%CarLeft" + str(car_lefts[i])).duplicate()
			var car_left_map_position = Vector2(segment * 40 + 15 + mod + i * 10, 0)
			car_left_map_positions[car_left_map_position] = car_left
			car_left.position = $TileMap.map_to_world(car_left_map_position) + Vector2(19, 34)
			$TileMap.add_child(car_left)
			var car_right = get_node("%CarRight" + str(car_rights[i])).duplicate()
			var car_right_map_position  = Vector2(segment * 40 + 15 - mod + i * 10, 0)
			car_right_map_positions[car_right_map_position] = car_right
			car_right.position = $TileMap.map_to_world(car_right_map_position) + Vector2(0, 40)
			$TileMap.add_child(car_right)

func _process(_delta):
	var player_map_position = $TileMap.world_to_map($"%Police".position)
	if player_map_position == Vector2(219, 0):
		$"%Police".arrived = true
		$"%Win".show()
	elif $"%Police".right_lane:
		if car_right_map_positions.has(player_map_position):
			hit(car_right_map_positions[player_map_position])
			car_right_map_positions.erase(player_map_position)
	else:
		if car_left_map_positions.has(player_map_position):
			hit(car_left_map_positions[player_map_position])
			car_left_map_positions.erase(player_map_position)

func hit(car):
	if crosses < 3:
		$"%Crosses".get_child(crosses).show()
		crosses += 1
		car.get_node("AnimationPlayer").play("jump")
	else:
		$"%Police".arrived = true
		$"%GameOver".show()
	

func _on_button_up_pressed():
	$"%Police".action_pressed = true
	$"%ButtonUp".hide()
	$"%ButtonDown".show()
	$"%ButtonDown".set_disabled(true)

func _on_button_down_pressed():
	$"%Police".action_pressed = true
	$"%ButtonDown".hide()
	$"%ButtonUp".show()
	$"%ButtonUp".set_disabled(true)

func _on_changed_lane():
	$"%ButtonUp".set_disabled(false)
	$"%ButtonDown".set_disabled(false)

func _on_try_again_pressed():
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()

func _on_continue_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://menu.tscn")
