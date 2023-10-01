extends Node

#按钮组
@export var group:ButtonGroup

#连接每一个按钮信号
func _ready():
	for btn in group.get_buttons():
		if btn.name == "setting":
			continue
		btn.connect("pressed",Callable(self,"on_pressed"))

#初始化当前的选中列表
func init_list(default_btn):
	for btn in group.get_buttons():
		if btn.text == default_btn:
			btn.button_pressed = true
			Global.nowList = btn.text
			return

#当按钮点击时候
func on_pressed():
	if Global.nowList == "setting":
		$setting.remove_self()
		Global.nowList = "setting"
	var btn   = group.get_pressed_button()
	var now_index = 0
	for tbtn in group.get_buttons():
		if tbtn.text == Global.nowList:
			break
		now_index += 1
	var next_index = group.get_buttons().find(btn)
	$"../../todoItemArea".Save()
	$"../../todoItemArea".showDayTodo(btn.text,next_index-now_index)
	Global.nowList = btn.text

#移动
func move(choose_btn):
	var ismove = false
	for btn in group.get_buttons():
		if btn.name == "setting":
			continue
		if ismove:
			btn.position += Vector2(0,36)
			continue
		if choose_btn == btn:
			ismove = true
			
#回归移动		
func remove(choose_btn):
	var ismove = false
	for btn in group.get_buttons():
		if btn.name == "setting":
			continue
		if ismove:
			btn.position -= Vector2(0,36)
			continue
		if choose_btn == btn:
			ismove = true
