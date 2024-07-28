extends Node2D

signal changed_lane

enum states {
	MOVING_FORWARD,
	CHANGING_LANES,
	REVERSING,
}

var state = states.MOVING_FORWARD
var right_lane = true
var action_pressed = false
var arrived = false

func _process(_delta):
	if arrived:
		return
	position += Vector2(3, 1.5)
	if state == states.MOVING_FORWARD:
		if action_pressed:
			state = states.CHANGING_LANES
			action_pressed = false
	elif state == states.CHANGING_LANES:
		if right_lane:
			$Sprite.position.x += 1
			if $Sprite.position.x > 30:
				$Sprite.position.x = 30
				state = states.MOVING_FORWARD
				right_lane = false
				emit_signal("changed_lane")
		else:
			$Sprite.position.x -= 1
			if $Sprite.position.x < 0:
				$Sprite.position.x = 0
				state = states.MOVING_FORWARD
				right_lane = true
				emit_signal("changed_lane")
