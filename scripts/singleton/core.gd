#负责游戏的启动和流程
extends Node

#初始化
func _ready():
	#load_core()                      #加载核心系统设置
	#load_core_setting()              #加载核心用户设置
	#Global.database.init_database()  #数据库初始化,打开数据库连接
	get_tree().set_message_translation(true)
	var sSize = DisplayServer.screen_get_size()
	var wSize = sSize/2
	var wPo = sSize/2 -wSize/2
	DisplayServer.window_set_size(wSize)
	get_window().position = wPo
	Global.scenes.add_scene("main")
	
#加载核心系统数据
func load_core():
	Global.io.read_json_file(Paths.res_conf_path)
	pass
	
#加载核心用户数据
func load_core_setting():
	if Global.io.exisit_file(Paths.user_conf_core_path):
		frist()
	else :
		var core = Global.io.read_json_no_exisit_to_create(Paths.user_conf_core_path)
	
	
#当第一次打开该软件时,进行初始化配置
func frist():
	#设置当前窗口尺寸和位置
	var sSize = DisplayServer.screen_get_size()
	var wSize = sSize/2
	var wPo = sSize/2 -wSize/2
	DisplayServer.window_set_size(wSize)
	get_window().position = wPo
	
	#创建文件夹
	Global.io.create_dir_on_no_exisit(Paths.user_db_dir)
	Global.io.create_dir_on_no_exisit(Paths.user_conf_dir)
	
	#创建文件
	Global.io.create_file_on_no_exisit(Paths.user_db_path)
	
	#初始化数据库
	Global.database.frist_init_database()

#当软件退出,存储当前状态
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		Global.database.close_db()
