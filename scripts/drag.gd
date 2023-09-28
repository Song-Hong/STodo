#Todo 块拖动
extends Button

#内部变量
var isdown = false   #检测鼠标是否按下
var offset           #偏移值
var ID     = "STodo" #唯一值
var Start  = []      #开始时间

#外部引用
@export var IName:LineEdit      #名称
@export var Tags:Button         #标签
@export var deadlineDate:Button #截止日期

func _ready():
	var time   = Time.get_datetime_dict_from_system()
	var year   = str(time.year)
	var month  = str(time.month)
	var day    = str(time.day)
	var hour   = str(time.hour)
	var minute = str(time.minute)

#当鼠标按下时候,开始窗口跟手
func _on_button_down():
	offset = get_global_mouse_position() - position
	isdown = true

#当鼠标抬起时,停止窗口跟手
func _on_button_up():
	isdown = false

#当获取到输入时,执行跟手操作
func _input(_event):
	if isdown:
		position = get_global_mouse_position()-offset
	
#初始化
func Init():
	pass	

#转为Json数据
func ToJson():
	pass
