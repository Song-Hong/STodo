#网格布局
extends Node

var start_po = Vector2(170,10)
var interval = Vector2(210,210)
var grid_po  = []

#初始化
func _ready():
	Global.grid_layout = self

#转为网格位置
func to_grid(po):
	pass

#获取网格位置
func get_po()->Vector2:
	var po     = start_po
	var w_size = get_window().size
	w_size.x  -= 180
	while exist_path(po):
		var x  = po.x + interval.x
		po.x   = x
		if x > w_size.x:
			po.y += interval.y
			po.x  = start_po.x
	var new_po = Vector2(po.x,po.y)
	grid_po.append(new_po)
	return new_po

#存在路径
func exist_path(po:Vector2)->bool:
	for g_po in grid_po:
		if g_po == po:
			return true
	return false

#清理数据
func clear():
	grid_po.clear()
