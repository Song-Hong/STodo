extends Panel

#按钮组
@export var group:ButtonGroup

#初始化,连接每一个按钮信号,然后设置初始化按钮
func _ready():
	for btn in group.get_buttons():
		if btn.text == Global.nowListName:
			btn.button_pressed = true
			Global.nowList = btn
		btn.connect("pressed",Callable(self,"on_pressed"))

#当按钮点击的时候
func on_pressed():
	#获取当前点击的按钮
	var btn = group.get_pressed_button()
	
	#当重复点击时,返回请求
	if Global.nowListName == btn.text:
		return
	
	#提交给全局变量
	Global.nowList = btn
	Global.nowListName = btn.text
	
	#获取当前点击的按钮和之前显示的按钮的相对位置
	var now_index = 0
	for tbtn in group.get_buttons():
		if tbtn.text == Global.nowListName:
			break
		now_index += 1
	var next_index = group.get_buttons().find(btn)
	
	btn.button_pressed = true
	
#按钮的移动
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
			
#按钮回归移动		
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
