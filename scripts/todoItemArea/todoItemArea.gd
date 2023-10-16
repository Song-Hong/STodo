#ToDo显示区域
extends Control

#初始化
func _ready():
	Global.todoItemArea = self
	connect("gui_input",Callable(self,"_on_gui_input"))

#右键点击申请右键菜单
func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			Global.contentMenuManager.showContetnMenu("todoItemAreaCM")
	
#显示当前的todo页面
func show_todo(datas):
	if datas == null: return
	for data in datas:
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
	data.end       = Global.time.get_now_day()
	data.tags      = ["def"]
	data.task      = {}
	data.po        = get_global_mouse_position()
	
	#初始化节点
	item.InitItem(data)

