extends HBoxContainer

#初始化任务节点
func init_task(task_name:String,task_state:bool):
	$taskState.button_pressed = task_state
	$taskName.text            = task_name

#转为数据
func to_data():
	return [$taskName.text,$taskState.button_pressed]

#当数据被修改时
func _on_task_name_text_submitted(new_text):
	Global.tools.unfocus($taskName)
	$"../../../".update_task_to_db()

#当任务状态发生改变时
func _on_task_state_toggled(button_pressed):
	$"../../../".update_task_to_db()
