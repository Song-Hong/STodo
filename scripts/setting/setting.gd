#设置模块
extends Button

var settingPanel

#当前按钮处理事件
func open_pressed():
	settingPanel = Global.scenes.get_scene("setting")
	var windowSize = get_window().size
	$"../../windowState".move_to_front()
	settingPanel.position = Vector2(160,0)
	settingPanel.size = Vector2(windowSize.x-160,windowSize.y-200)
	Global.todoItemArea.add_child(settingPanel)
	
#按钮退出事件
func exit_pressed():
	settingPanel.reparent($"../../temporarily")
