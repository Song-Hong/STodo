#ToDo显示区域
extends Control

#初始化
func _ready():
	connect("gui_input",Callable(self,"_on_gui_input"))
	if name == "todoItemAreaGrid" && Global.layoutMode != "grid":
		visible = false
		return
	elif name != "todoItemAreaGrid" && Global.layoutMode == "grid":
		visible = false
		return
	Global.todoItemArea = self

#右键点击申请右键菜单
func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			Global.tools.del_date_choose()
			Global.contentMenuManager.showContetnMenu("todoItemAreaCM")
	
	
#显示当前的todo页面
func show_todo(datas):
	if datas == null: return
	for data in datas:
		if len(data) == 0: continue
		var item_data = itemdata.new()
		item_data.parsing(data)
		create_todo(item_data)
	
#创建节点数据
func create_todo(data:itemdata):
	#创建item节点
	var item = Global.scenes.get_scene("item")
	add_child(item)
	
	#初始化节点数据
	item.InitItem(data)
	
#创建一个新的Todo节点
func create_new_todo():
	#创建一个节点,并赋予父物体和位置
	var item = Global.scenes.get_scene("item")
	add_child(item)
	
	#设置节点和名称
	var data       = itemdata.new()
	data.id        = Global.time.get_ID()
	data.iNameText = TranslationServer.translate("New Todo")
	data.start     = Global.time.get_now_str()
	data.tags      = ["def"]
	data.task      = {}
	
	if Global.layoutMode != "grid":
		data.po    = get_global_mouse_position()-data.size
	
	match Global.nowListName:
		"today"    : data.end = Global.time.get_now_day()
		"tomorrow" : data.end = Global.time.get_tomorrow_day()
		_          : data.end = Global.time.get_now_day()
	
	#初始化节点
	item.new_item(data)
