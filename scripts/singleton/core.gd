#负责游戏的启动和流程
extends Node

#初始化
func _ready():
	load_core()
	Global.scenes.add_scene("main")
	Global.animationState = true
	
#加载核心用户数据
func load_core():
	if !Global.io.exisit_file(Paths.user_conf_core_path):
		frist()
	else :
		load_core_setting()

func load_core_setting():
	var json = Global.io.read_json_no_exisit_to_create(Paths.user_conf_core_path)
	
	#获取当前的版本信息
	Global.version = json["version"]
	Global.app_version = json["app_version"]
	
	#检查版本是否需要更新
	
	#获取玩家设置信息
	var default_list      = json["default_list"]
	var window_size       = json["window_size"]
	var window_po         = json["window_po"]
	Global.animationState = json["animationState"]
	TranslationServer.set_locale(json["language"])
	
	#设置当前窗口的位置和大小
	get_window().size     = Vector2(window_size[0],window_size[1])
	get_window().position = Vector2(window_po[0],window_po[1])
	
	#设置当前显示的列表
	Global.nowListName = default_list
	
	#初始化数据库
	Global.database.init_database()
	
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
	
	#对软件进行初始化配置
	var json = Global.io.read_json_file(Paths.res_conf_path)
	
	#更新版本信息
	Global.version = json["version"]
	Global.app_version = json["app_version"]
	
	#设置当前显示的列表
	Global.nowListName = "Today"
	
	#初始化数据库
	Global.database.init_database()

#当软件退出,存储当前状态
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		Global.database.close_db()
