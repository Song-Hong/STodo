#设置模块
extends Button

var settingPanel

#当按钮点击时,跳转到显示节点
func _on_button_down():
	if Global.nowList == "setting":return
	else: $"../../../todoItemArea".Save()
	Global.nowList = "setting"
	#当被点击时,清空页面
	if Global.animationState:
		$"../../../todoItemArea".removeDayTodoUX()
		showSettingUX()
	else:
		$"../../../todoItemArea".removeDayTodo()
		$"../../..".remove_child($"../../../temporarily")
		showSetting()

#显示设置界面
func showSettingUX():
	showSetting()
	settingPanel.position = Vector2(160,get_window().size.y)
	var tween = get_tree().create_tween()
	tween.tween_property(settingPanel,"position",Vector2(160,0),0.3)

#显示设置界面非动画
func showSetting():
	settingPanel = preload("res://scenes/setting.tscn").instantiate()
	var windowSize = get_window().size
	$"../../..".add_child(settingPanel)
	$"../../../windowDrag".move_to_front()
	$"../../../appController".move_to_front()
	settingPanel.position = Vector2(160,0)
	settingPanel.size = Vector2(windowSize.x-160,windowSize.y-200)

#删除当前节点
func remove_self():
	if Global.animationState:
		settingPanel.position = Vector2(160,0)
		var tween = get_tree().create_tween()
		await tween.tween_property(settingPanel,"position",Vector2(160,get_window().size.y),0.3).finished
	$"../../..".remove_child(settingPanel)
