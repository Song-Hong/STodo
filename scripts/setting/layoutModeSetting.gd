extends Node

@export var drag_mode:Button
@export var drag_name:Label
@export var grid_mode:Button
@export var grid_name:Label

func _ready():
	drag_mode.connect("button_down",Callable(self,"_on_drag_mode_button_down"))
	grid_mode.connect("button_down",Callable(self,"_on_grid_mode_button_down"))
	match Global.layoutMode:
		"drag" : _on_drag_mode_button_down()
		"grid" : _on_grid_mode_button_down()
		
func _on_drag_mode_button_down():
	Global.layoutMode = "drag"
	drag_name.add_theme_color_override("font_color","1990ff")
	grid_name.add_theme_color_override("font_color","3d3d3d")
	Global.tools.show_animation_quick_speed(drag_mode)
	
func _on_grid_mode_button_down():
	Global.layoutMode = "grid"
	grid_name.add_theme_color_override("font_color","1990ff")
	drag_name.add_theme_color_override("font_color","3d3d3d")
	Global.tools.show_animation_quick_speed(grid_mode)

