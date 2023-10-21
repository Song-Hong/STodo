extends Control

var state = false

func change_state(new_state:bool):
	state = new_state
	queue_redraw()
	
func _draw():
	if !state: return
	var p_size = get_parent().size
	draw_line(Vector2(-p_size.x+24,-p_size.y/2),Vector2(-40,-p_size.y/2), Color.DARK_GRAY, 4.0)
