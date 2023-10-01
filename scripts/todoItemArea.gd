#ToDo显示区域
extends Control

#当前显示的天
var now_list  = ""
#存储地址
var save_path = "user://list/%s.json"

#初始化
func _ready():
	Global.todoItemArea = self

#右键点击申请右键菜单
func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			Global.contentMenuManager.showContetnMenu("todoItemArea")

#显示Todo页面
func showDayTodo(list:String,moveDirection=1):
	#如果请求相同,则驳回请求
	if list == now_list:
		return
	if Global.animationState:
		showDayTodoUX(list,moveDirection)
		return
	for item in get_children():
		remove_child(item)
	now_list = list
	#格式化路径
	var path = save_path%list
	#判断文件是否存在,如果不存在则创建
	if not FileAccess.file_exists(path):
		var f = FileAccess.open(path,FileAccess.WRITE)
		f.store_string("{}")
		f.close()
	var file = FileAccess.open(path,FileAccess.READ)
	var json = JSON.parse_string(file.get_as_text())
	for key in json.keys():
		create(key,json[key])

#创建新的Todo节点	
func create(id,data):
	var iname    = data["name"]
	var po       = data["po"]
	var tag      = data["tag"]
	var start    = data["start"]
	var end      = data["end"]
	var item     = preload("res://scenes/item.tscn").instantiate()
	add_child(item)
	item.InitItem(id,iname,po,tag,start,end)

#时间数值转为字符串
func Time2String(time):
	for i in len(time):
		if time[i]/10 < 1:
			time[i] = "0%s"%str(time[i])
		else:
			time[i] = str(time[i])
	var timeStr = "%s/%s/%s %s:%s:%s"
	return timeStr%time

#存储
func Save():
	if Global.nowList == "setting" or now_list == "" :
		return
	var json_data = "{\n"
	var childs = get_children()
	for child in childs:
		var json = child.ToJson() as String
		json = json.trim_prefix("{")
		json = json.trim_suffix("}")
		json_data += json+","
	if json_data.ends_with(","):
		json_data = json_data.trim_suffix(",")
	json_data+="\n}"
	var path = save_path%now_list
	var file = FileAccess.open(path,FileAccess.WRITE)
	file.store_string(json_data)
	file.close()

#移动Todo卡片
func MoveTo(list,json):
	var path = save_path%list
	if not FileAccess.file_exists(path):
		var f = FileAccess.open(path,FileAccess.WRITE)
		f.store_string("{}")
		f.close()
	var file = FileAccess.open(path,FileAccess.READ).get_as_text()
	file = file.trim_suffix("}")
	file = file.replace("\n","")
	json = json.trim_prefix("{")
	json = json.trim_suffix("}")
	if file == "{":
		file += "%s}"%json
	else:
		file += ",%s}"%json
	var s = FileAccess.open(path,FileAccess.WRITE)
	s.store_string(file)
	s.close()

#显示Todo页面 动画版
func showDayTodoUX(list:String,moveDirection=1):
	var temporarily = Panel.new()
	temporarily.name = "temporarily"
	get_parent().add_child(temporarily)
	temporarily.set_anchors_preset(Control.PRESET_FULL_RECT)
	for item in get_children():
		item.reparent(temporarily)
	temporarily.move_to_front()
	now_list = list
	#格式化路径
	var path = save_path%list
	#判断文件是否存在,如果不存在则创建
	if not FileAccess.file_exists(path):
		var f = FileAccess.open(path,FileAccess.WRITE)
		f.store_string("{}")
		f.close()
	var file = FileAccess.open(path,FileAccess.READ)
	var json = JSON.parse_string(file.get_as_text())
	for key in json.keys():
		create(key,json[key])
	
	#判断时向上还是向下移动
	var directionSize = 0
	if moveDirection > 0:
		directionSize = size.y
	else:
		directionSize = -size.y
	
	#开始播放动画
	position = Vector2(0,directionSize)
	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property(temporarily,"position",Vector2(0,-directionSize),0.3)
	await tween.tween_property(self,"position",Vector2(0,0),0.3).finished
	get_parent().remove_child(temporarily)

#删除当前的Todo
func removeDayTodoUX(moveDirection=1):
	var temporarily = Panel.new()
	temporarily.name = "temporarily"
	get_parent().add_child(temporarily)
	temporarily.set_anchors_preset(Control.PRESET_FULL_RECT)
	for item in get_children():
		item.reparent(temporarily)
	temporarily.move_to_front()
	now_list = ""
	
	#判断时向上还是向下移动
	var directionSize = 0
	if moveDirection > 0:
		directionSize = size.y
	else:
		directionSize = -size.y
	
	#开始播放动画
	position = Vector2(0,directionSize)
	var tween = get_tree().create_tween().set_parallel(true)
	await tween.tween_property(temporarily,"position",Vector2(0,-directionSize),0.3).finished
	get_parent().remove_child(temporarily)

#删除当前页面的全部Todo
func removeDayTodo():
	for item in get_children():
		remove_child(item)
	
	
	
	
	
	
	
	
