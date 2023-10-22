#IO流管理器
extends Node
class_name toolsManager

#初始化
func _init():
	set_singleton()

#设置单例
func set_singleton():
	if Global.tools == null:
		Global.tools = self
	else:
		get_parent().remove_child(self)

#删除日期
func del_date_choose():
	if Global.nowShowDate != null: 
		var parent = Global.nowShowDate.get_parent()
		parent.remove_child(Global.nowShowDate)
		Global.nowShowDate = null

#取消焦点
func unfocus(node):
	node.focus_mode = Control.FOCUS_NONE
	node.focus_mode = Control.FOCUS_ALL

#字符串转集合
func str_to_int_array(data:String)->Array:
	var array = []
	var datas = data.replace("[","").replace("]","").split(",")
	for i in range(len(datas)):
		var value = datas[i].replace(" ","")
		value     = int(datas[i].replace(" ",""))
		array.append(value)
	return array

#################################################
# 动画部分
#################################################
#快速的按钮动画
func show_animation_quick_speed(btn:Button):
	if !Global.animationState: return false
	var tween = get_tree().create_tween()
	tween.tween_property(btn,"scale",Vector2(1.1,1.1),0.1)
	tween.tween_property(btn,"scale",Vector2(0.96,0.96),0.03)
	tween.tween_property(btn,"scale",Vector2(1.02,1.02),0.01)
	tween.tween_property(btn,"scale",Vector2(1,1),0.01)
	return true
