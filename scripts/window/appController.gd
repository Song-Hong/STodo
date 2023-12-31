extends Button

#按钮类
enum Button_Type{
	QUIT,
	MIN,
	MAX
}
@export var btn_type:Button_Type

func _ready():
	match btn_type:
		Button_Type.QUIT : connect("button_down",Callable(self,"quitApp"))
		Button_Type.MIN  : connect("button_down",Callable(self,"minApp"))
		Button_Type.MAX  : connect("button_down",Callable(self,"maxApp"))
	connect("mouse_entered",Callable(self,"on_mouse_entered"))
	connect("mouse_exited",Callable(self,"on_mouse_exited"))

#当鼠标移动到当前节点时
func on_mouse_entered():
	for btn in get_parent().get_children():
		btn = btn as Button
		var theme = btn.get_theme_stylebox("hover")
		btn.add_theme_stylebox_override("normal",theme)

#当鼠标离开当前节点时
func on_mouse_exited():
	for btn in get_parent().get_children():
		btn = btn as Button
		var theme = btn.get_theme_stylebox("pressed")
		btn.add_theme_stylebox_override("normal",theme)

#退出软件
func quitApp():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()

#最小化app
func minApp():
	pass

#最大化app
func maxApp():
	pass

#当窗口市区焦点时
func _notification(what): 
	if what == MainLoop.NOTIFICATION_APPLICATION_FOCUS_OUT: 
		disabled = true
	if what == MainLoop.NOTIFICATION_APPLICATION_FOCUS_IN:
		disabled = false
	

