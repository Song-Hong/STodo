#管理所有右键菜单
extends Control

#初始化
func _ready():
	Global.contentMenuManager = self

#触发 当判断到右键菜单点击时
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if Global.nowContentMenu != null:
				await get_tree().create_timer(0.1).timeout
				Global.nowContentMenu.visible = false
				Global.nowContentMenu = null

#显示右键菜单
func showContetnMenu(Mname):
	if Global.nowContentMenu != null:
		Global.nowContentMenu.visible = false
	match Mname:
		"todoItem":     Global.nowContentMenu = $todoItemCM
		"todoItemArea": Global.nowContentMenu = $todoItemAreaCM
	Global.nowContentMenu.visible = true
	Global.nowContentMenu.position = get_global_mouse_position()
	if Global.nowLineEditor != null: 
		Global.nowLineEditor.focus_mode = Control.FOCUS_NONE
		Global.nowLineEditor.focus_mode = Control.FOCUS_ALL
