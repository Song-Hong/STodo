#列表按钮
extends Button

#显示提示界面
var showTip = false

#初始化连接信号
func _ready():
	connect("mouse_entered",Callable(self,"on_mouse_entered"))
	connect("mouse_exited",Callable(self,"on_mouse_exited"))
	connect("button_down",Callable(self,"on_button_down"))

#当鼠标移动到该按钮上时
func on_mouse_entered():
	if Global.nowItem != null and Global.nowList != text:
		if Global.nowContentMenu != null : return
		text = "Move to\n" + text
		size = Vector2(136,72)
		get_parent().move(self)
		showTip = true
		Global.nowShowTipList = self
		disabled = true
		
		#ux
		if Global.animationState:
			scale = Vector2(0.8,0.8)
			var tween = get_tree().create_tween()
			tween.tween_property(self,"scale",Vector2(1,1),0.2)

#当鼠标移出该按钮上时
func on_mouse_exited():
	if showTip:
		text = text.trim_prefix("Move to\n")
		size = Vector2(136,36)
		get_parent().remove(self)
		showTip = false
		Global.nowShowTipList = null
		disabled = false

#UX 当按钮点击时
func on_button_down():
	if Global.animationState:
		scale = Vector2(0.8,0.8)
		var tween = get_tree().create_tween()
		tween.tween_property(self,"scale",Vector2(1,1),0.2)
