extends Control

func _init():
	Global.main = self

#重新设置todoItemArea
func resetTodoItemArea():
	if Global.layoutMode == "grid":
		Global.todoItemArea = $todoItemAreaGrid
		$todoItemArea.visible = false
		$todoItemAreaGrid.visible = true
	else:
		Global.todoItemArea = $todoItemArea
		$todoItemArea.visible = true
		$todoItemAreaGrid.visible = false
