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

#像当前场景下添加场景
func add_scene(scene_name:String):
	get_parent().add_child(get_scene(scene_name))

#获取场景
func get_scene(scene_name:String):
	var scene
	match scene_name:
		"date"           : scene = preload("res://scenes/date.tscn")          .instantiate()
		"item"           : scene = preload("res://scenes/item.tscn")          .instantiate()
		"main"           : scene = preload("res://scenes/main.tscn")          .instantiate()
		"setting"        : scene = preload("res://scenes/setting.tscn")       .instantiate()
		"todoItemAreaCM" : scene = preload("res://scenes/todoItemAreaCM.tscn").instantiate()
		"itemCM"         : scene = preload("res://scenes/itemCM.tscn")        .instantiate()
		"task"           : scene = preload("res://scenes/task.tscn")          .instantiate()
	return scene
