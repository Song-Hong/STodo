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
	#如果当前有显示的右键菜单,删除它
	if Global.nowContentMenu != null:
		remove_child(Global.nowContentMenu)
	#实例化当前右键右键菜单   
	var CM
	match Mname:
		"itemCM":         CM = Global.scenes.get_scene("itemCM")
		"todoItemAreaCM": CM = Global.scenes.get_scene("todoItemAreaCM")
	#判断右键菜单是否为空,为空则返回
	if(CM==null):return
	#更改右键菜单的父物体,并设置位置
	add_child(CM)
	CM.position = get_global_mouse_position()
	#设置当前的右键菜单
	Global.nowContentMenu = CM
	
	#if Global.nowLineEditor != null: 
	#	Global.nowLineEditor.focus_mode = Control.FOCUS_NONE
	#	Global.nowLineEditor.focus_mode = Control.FOCUS_ALL
