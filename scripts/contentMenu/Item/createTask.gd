extends Button

#创建
func _on_button_down():
	Global.nowItem.create_new_task()
	Global.nowItem = null
