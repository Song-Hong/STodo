extends Node
class_name scenesMananger

#初始化
func _init():
	set_singleton()

#设置单例
func set_singleton():
	if Global.scenes == null:
		Global.scenes = self
	else:
		get_parent().remove_child(self)
