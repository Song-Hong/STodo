#负责游戏的启动和流程
extends Node

#初始化
func _ready():
	Global.database.init_database()
