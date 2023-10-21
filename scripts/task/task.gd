extends HBoxContainer

var now_text

#初始化任务节点
func init_task(task_name:String,task_state:bool):
	$taskState.button_pressed = task_state
	$taskName.text            = task_name
	now_text                  = task_name
	$Control.change_state(task_state)

#转为数据
func to_data():
	return [$taskName.text,$taskState.button_pressed]

#当数据被修改时
func _on_task_name_text_submitted(new_text):
	Global.tools.unfocus($taskName)
	$"../../../".update_task_to_db(to_data())

#当任务状态发生改变时
func _on_task_state_toggled(button_pressed):
	if $taskName.text == "" : return
	$"../../../".update_task_to_db(to_data())
	$Control.change_state($taskState.button_pressed)
	$"../../../".redraw_tasks()
	
#当前文本发生变化时
func _on_task_name_text_changed(new_text):
	$"../../../".update_task_name(now_text,new_text)
	now_text = new_text

#当删除按钮点击时
func _on_button_button_down():
	$"../../../".delete_task($taskName.text)
	get_parent().remove_child(self)
