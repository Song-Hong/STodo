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
	
#取消焦点
func unfocus(node):
	node.focus_mode = Control.FOCUS_NONE
	node.focus_mode = Control.FOCUS_ALL
