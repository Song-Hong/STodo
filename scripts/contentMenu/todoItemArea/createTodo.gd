#创建新节点
extends Button

func _ready():
	text = TranslationServer.translate("Create Todo")

#当鼠标点击时
func _on_button_down():
	Global.todoItemArea.create_new_todo()
