extends Node2D

var length = 10

# Called when the node enters the scene tree for the first time.
func _ready():
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
