#设置模块
extends Button

var settingPanel

#当前按钮处理事件
func open_pressed():
	var layout = Global.layoutMode
	if layout == "grid":
		Global.layoutMode = "drag"
		Global.main.resetTodoItemArea()
	Global.layoutMode = layout
	settingPanel = Global.scenes.get_scene("setting")
	var windowSize = get_window().size
	Global.todoItemArea.add_child(settingPanel)
	settingPanel.position = Vector2(176,10)
	settingPanel.size = Vector2(windowSize.x-192,windowSize.y)
	
#按钮退出事件
func exit_pressed():
	Global.main.resetTodoItemArea()
	if settingPanel == null: return
	settingPanel.reparent($"../../temporarily")
