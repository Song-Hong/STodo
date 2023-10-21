#Todo 块拖动
extends Button

#todo节点必需属性
var data:itemdata

#内部变量
var isdown    = false   #检测鼠标是否按下
var offset              #偏移值

#外部引用
@export var iName:LineEdit      #名称
@export var Tags:Button         #标签
@export var deadlineDate:Button #截止日期

#初始化
func _ready():	
	pass

#当鼠标按下时候,开始跟手
func _on_button_down():
	offset = get_global_mouse_position() - position
	isdown = true
	Global.nowItem = self
	move_to_front()
	if Global.nowLineEditor != null: 
		Global.nowLineEditor.focus_mode = Control.FOCUS_NONE
		Global.nowLineEditor.focus_mode = Control.FOCUS_ALL

#当鼠标抬起时,停止跟手
func _on_button_up():
	isdown = false
	Global.nowItem = null
	if position.x < 160 : 
		position = Vector2(165,position.y)
		NomalSize()
	if Global.nowShowTipList != null and Global.nowShowTipList.text != Global.nowListName:
		#var list = Global.nowShowTipList.text.trim_prefix("Move to\n")
		position = Vector2(183,22)
		#Global.todoItemArea.MoveTo(list,ToJson())
		#get_parent().remove_child(self)
		Global.nowShowTipList.on_mouse_exited()
	data.po = position
	save_to_db()
	
#当右键点击时,申请显示右键菜单
func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			Global.nowItem = self
			Global.contentMenuManager.showContetnMenu("itemCM")

#当获取到输入时,执行跟手操作
func _input(_event):
	if isdown:
		position = get_global_mouse_position()-offset
		if position.x < 160:
			MinSize()
		else :
			NomalSize()

#初始化 
func InitItem(db_data:itemdata):
	#设置当前节点的属性
	data = db_data
	
	#设置到显示节点
	iName.text = data.iNameText
	position   = data.po
	size       = data.size
	for key in data.task.keys():
		if data.task[key] == null:
			continue
		create_task(key,data.task[key])
	
	#存储
	save_to_db()

#创建任务
func create_task(task_name="",task_state=false):
	var task = Global.scenes.get_scene("task")
	$ScrollContainer/VBoxContainer.add_child(task)
	if task_name == "":
		task_name = TranslationServer.translate("New Task")
	task.init_task(task_name,task_state)
	update_task_to_db()
	
#删除任务
func delete_task():
	pass

#更新任务节点
func update_task():
	var temp_task = {}
	for task in $ScrollContainer/VBoxContainer.get_children():
		var task_data = task.to_data()
		temp_task[str(task_data[0])] = task_data[1]
	data.task = temp_task

#更新任务节点至数据库
func update_task_to_db():
	update_task()
	var res = Global.database.update_item_task(data.id,str(data.task))
	
#存储至数据库
func save_to_db():
	Global.database.replace(data.id,data.to_db())

#设置截止日期
func SetDeadlineDate(end):
	if end != null:
		deadlineDate.text = end

#获取截止时间
func GetDeadlineDateStr():
	var date = deadlineDate.get_end_date()
	return str(date[0])+str(date[1])+str(date[2])

#设置为小尺寸
func MinSize():
	#判断是否有开启动画,启用不同的缩小方式
	if Global.animationState:
		var tween = get_tree().create_tween()
		tween.tween_property(self,"scale",Vector2(0.2,0.2),0.3)
	else:
		scale = Vector2(0.2,0.2)

#设置为默认尺寸
func NomalSize():
	if Global.animationState:
		var tween = get_tree().create_tween()
		tween.tween_property(self,"scale",Vector2(1.12,1.12),0.2)
		tween.tween_property(self,"scale",Vector2(0.9,0.9),0.05)
		tween.tween_property(self,"scale",Vector2(1.05,1.05),0.03)
		tween.tween_property(self,"scale",Vector2(0.98,0.98),0.01)
		tween.tween_property(self,"scale",Vector2(1,1),0.01)
	else:
		scale = Vector2(1,1)

#当名称输入框按钮点击提交时
func _on_i_name_text_submitted(_new_text):
	Global.tools.unfocus(iName)
	Global.nowLineEditor = null
	iName.text = formattingIName(data.iNameText)
	iName.warp_mouse(Vector2(0,0))
	save_to_db()

#格式化IName显示的名称
func formattingIName(content:String):
	if len(content) > 20:
		return content.substr(0,20)+"..."
	return content

#当名称输入框按钮点击时
func _on_i_name_mouse_entered():
	Global.nowLineEditor = iName
	iName.text = data.iNameText

#当输入框文本改变时
func _on_i_name_text_changed(new_text):
	data.iNameText = new_text

#当输入框失去焦点时
func _on_i_name_focus_exited():
	iName.text = formattingIName(data.iNameText)
