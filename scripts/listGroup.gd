extends Node

#按钮组
@export var group:ButtonGroup

#连接每一个按钮信号
func _ready():
	for btn in group.get_buttons():
		btn.connect("pressed",Callable(self,"on_pressed"))
	$today.button_pressed = true
	
#当按钮点击时候
func on_pressed():
	var btn = group.get_pressed_button()
	$"../../todoItemArea".Save()
	$"../../todoItemArea".showDayTodo(btn.text)
	Global.nowList = btn.text

#移动
func move(choose_btn):
	var ismove = false
	for btn in group.get_buttons():
		if ismove:
			btn.position += Vector2(0,36)
			continue
		if choose_btn == btn:
			ismove = true
			
#回归移动		
func remove(choose_btn):
	var ismove = false
	for btn in group.get_buttons():
		if ismove:
			btn.position -= Vector2(0,36)
			continue
		if choose_btn == btn:
			ismove = true
