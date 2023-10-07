extends Node
class_name itemsManager

#初始化
func _init():
	set_singleton()

#设置单例
func set_singleton():
	if Global.items == null:
		Global.items = self
	else:
		get_parent().remove_child(self)
