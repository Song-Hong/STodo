#负责游戏的启动和流程
extends Node

#初始化
func _ready():
	#OS.load_dynamic_library
	
	#加载核心用户数据
	load_core()
	
	#加载主场景
	Global.scenes.add_scene("main")
	
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
	
	#初始化数据库
	Global.database.frist_init_database()
	
	#对软件进行初始化配置
	var json = Global.io.read_json_file(Paths.res_conf_path)
	
	#更新版本信息
	Global.version = json["version"]
	Global.app_version = json["app_version"]
	
	#设置当前显示的列表
	Global.nowListName = "today"
	
	#初始化数据库
	Global.database.init_database()

#存储当前状态至核心用户文件
func save_to_core():
	var json = {}
	var win_size           =  get_window().size
	var win_po             = get_window().position
	#获取当前的版本信息
	json["version"]        = Global.version 
	json["app_version"]    = Global.app_version
	json["default_list"]   = Global.nowListName
	json["window_size"]    = [win_size[0],win_size[1]]
	json["window_po"]      = [win_po[0],win_po[1]]
	json["animationState"] = Global.animationState
	json["language"]       = TranslationServer.get_locale()
	#检查版本是否需要更新
	
	#存储至文件
	var content = JSON.stringify(json)
	Global.io.write_file(Paths.user_conf_core_path,content)

#当软件退出,存储当前状态
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		Global.database.close_db()
		save_to_core()

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_F12:
			var path = ProjectSettings.globalize_path("user://")
			var label = Label.new()
			get_tree().root.add_child(label)
			label.text = path
			label.add_theme_color_override("font_color","#000")
			OS.shell_open(path)
