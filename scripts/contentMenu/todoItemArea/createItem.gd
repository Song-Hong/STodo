#创建新节点
extends Button

#func _ready():
#	text = TranslationServer.translate("Create Todo")

#当鼠标点击时
func _on_button_down():
	var scene = preload("res://scenes/item.tscn").instantiate()
	Global.todoItemArea.add_child(scene)
	scene.position = get_global_mouse_position()
	get_parent().visible = false
	scene.IName.text = TranslationServer.translate("New Todo")
	scene.INameText  = scene.IName.text
