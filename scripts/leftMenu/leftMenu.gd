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
	
	#当当前按钮不为空时,调用退出事件,并获取显示的页面
	if Global.nowList != null:
		Global.nowList.exit_pressed()
		
	#获取当前点击的按钮位置
	var now_index = group.get_buttons().find(Global.nowList)
	
	#提交给全局变量
	Global.nowList = btn
	Global.nowListName = btn.text
	
	#获取再一次点击的按钮位置
	var next_index = group.get_buttons().find(btn)

	#调用按钮来处理这次点击,并获取需要显示的页面
	btn.open_pressed()
	
	#播放动画如果开启的话
	if Global.animationState:
		show_move(next_index-now_index)
	else:
		var temporarily = $"../temporarily"
		for item in temporarily.get_children():
			temporarily.remove_child(item)
	
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

#显示移动画面
func show_move(moveDirection):	
	#判断时向上还是向下移动
	var directionSize = 0
	if moveDirection > 0:
		directionSize = size.y
	else:
		directionSize = -size.y
	
	#获取临时页面	
	var temporarily  = $"../temporarily"
	var todoItemArea = Global.todoItemArea
	
	#开始播放动画
	todoItemArea.position = Vector2(0,directionSize)
	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property(temporarily,"position",Vector2(0,-directionSize),0.3)
	await tween.tween_property(todoItemArea,"position",Vector2(0,0),0.3).finished
	for item in temporarily.get_children():
		temporarily.remove_child(item)
