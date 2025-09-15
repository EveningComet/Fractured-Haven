## Manages displaying the selection to the player.
class_name SelectionBox extends Control

var _selecting: bool = false
var _start_pos:       Vector2 = Vector2.ZERO
var _curr_cursor_pos: Vector2 = Vector2.ZERO

## The object that will actually display the selection box to the player.
var _selection_box: Rect2

func draw_selection(start_pos, curr_pos, dragging: bool) -> void:
	_start_pos = start_pos
	_curr_cursor_pos = curr_pos
	_selecting = dragging
	queue_redraw()
	
func _draw() -> void:
	if _selecting == true:
		var x_min = min(_start_pos.x, _curr_cursor_pos.x)
		var y_min = min(_start_pos.y, _curr_cursor_pos.y)
		_selection_box = Rect2(
			x_min, y_min,
			max(_start_pos.x, _curr_cursor_pos.x) - x_min,
			max(_start_pos.y, _curr_cursor_pos.y) - y_min
		)
		draw_rect(_selection_box, Color("#00ff0066"))
		draw_rect(_selection_box, Color("00ff00"), false, 2.0)
