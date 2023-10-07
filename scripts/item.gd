#Todo 块拖动
extends Button

#内部变量
var isdown    = false   #检测鼠标是否按下
var offset              #偏移值
var ID        = "STodo" #唯一值
var Start     = []      #开始时间
var INameText = ""      #当前Item的名称
var isComplete:bool     #当前任务是否完成

#外部引用
@export var IName:LineEdit      #名称
@export var Tags:Button         #标签
@export var deadlineDate:Button #截止日期

func _ready():	
	#设置时间
	var time   = Time.get_datetime_dict_from_system()
	Start = [time.year,time.month,time.day,
			 time.hour,time.minute,time.second]
	deadlineDate.set_end_date(time.year,time.month,time.day)

	#设置唯一标识符
	var IDList = ["","","","","",""]
	for i in len(Start):
		if Start[i]/10 < 1:
			IDList[i] = "0%s"%str(Start[i])
		else:
			IDList[i] = str(Start[i])
	ID = ID+"%s%s%s%s%s%s"%IDList+str(randi() % 1000)

#当鼠标按下时候,开始窗口跟手
func _on_button_down():
	offset = get_global_mouse_position() - position
	isdown = true
	Global.nowItem = self
	move_to_front()
	if Global.nowLineEditor != null: 
		Global.nowLineEditor.focus_mode = Control.FOCUS_NONE
		Global.nowLineEditor.focus_mode = Control.FOCUS_ALL
		IName.text = formattingIName(INameText)

#当鼠标抬起时,停止窗口跟手
func _on_button_up():
	isdown = false
	Global.nowItem = null
	if position.x < 160 : 
		position = Vector2(165,position.y)
		NomalSize()
	if Global.nowShowTipList != null and Global.nowShowTipList.text != Global.nowList:
		var list = Global.nowShowTipList.text.trim_prefix("Move to\n")
		position = Vector2(183,22)
		Global.todoItemArea.MoveTo(list,ToJson())
		get_parent().remove_child(self)
		Global.nowShowTipList.on_mouse_exited()
	
#当右键点击时,申请显示右键菜单
func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			Global.nowItem = self
			Global.contentMenuManager.showContetnMenu("todoItem")

#当获取到输入时,执行跟手操作
func _input(_event):
	if isdown:
		position = get_global_mouse_position()-offset
		if position.x < 160:
			MinSize()
		else :
			NomalSize()
			
#初始化 
func InitItem(f_ID,f_Iname,f_Position,f_Tag,f_Start,f_End):
	ID                 = f_ID
	IName.text         = formattingIName(f_Iname)
	INameText          = f_Iname
	position           = Vector2(f_Position[0],f_Position[1])
	Tags.text          = str(f_Tag[0])
	Start              = f_Start
	deadlineDate.set_end_date(f_End[0],f_End[1],f_End[2])

#设置截止日期
func SetDeadlineDate(end):
	if end != null:
		deadlineDate.text = end

#获取截止时间
func GetDeadlineDateStr():
	var date = deadlineDate.get_end_date()
	return str(date[0])+str(date[1])+str(date[2])

#转为Json数据
func ToJson():
	var json_obj  = {str(ID):{
					 "name":INameText,
					 "po":[position.x,position.y],
					 "tag":["def"],
					 "start":Start,
					 "end":deadlineDate.get_end_date()}}
	var json_data = JSON.stringify(json_obj)
	return json_data
	
#获取全部数据
func get_all_data():
	pass
	
#设置为小尺寸
func MinSize():
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
	IName.focus_mode = Control.FOCUS_NONE
	IName.focus_mode = Control.FOCUS_ALL
	Global.nowLineEditor = null
	IName.text = formattingIName(INameText)
	IName.warp_mouse(Vector2(0,0))

#格式化IName显示的名称
func formattingIName(content:String):
	if len(content) > 20:
		return content.substr(0,20)+"..."
	return content

#当名称输入框按钮点击时
func _on_i_name_mouse_entered():
	Global.nowLineEditor = IName
	IName.text = INameText

#当输入框文本改变时
func _on_i_name_text_changed(new_text):
	INameText = new_text

#当输入框失去焦点时
func _on_i_name_focus_exited():
	IName.text = formattingIName(INameText)

