#删除Todo节点
extends Button

#当按钮按下时删除节点
func _on_button_down():
	if Global.nowItem != null:
		$"../../../todoItemArea".remove_child(Global.nowItem)
		Global.nowItem = null
