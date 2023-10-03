#负责窗口的初始化
extends Control

#目录
var dir = "user://"

#初始化
func _ready():
	#设置背景透明
	get_tree().root.set_transparent_background(true)
	if FileAccess.file_exists(dir+"conf/core.json"):
		loadConf()
	else:
		frist()
	
#检查版本号
func checkVersion():
	var file = FileAccess.open("res://conf/core.json",FileAccess.READ)
	var json = JSON.parse_string(file.get_as_text())
	var _version = json["version"]
	var _app_version = json["app_version"]
	
#当第一次打开该软件时,进行初始化配置
func frist():
	var sSize = DisplayServer.screen_get_size()
	var wSize = sSize/2
	var wPo = sSize/2 -wSize/2
	DisplayServer.window_set_size(wSize)
	get_window().position = wPo
	DirAccess.make_dir_absolute(dir+"list/")
	DirAccess.make_dir_absolute(dir+"conf/")
	saveState()
	Global.nowList = "Today"
	
#加载配置文件
func loadConf():
	#显示当前列表
	var file = FileAccess.open(dir+"conf/core.json",FileAccess.READ)
	var json = JSON.parse_string(file.get_as_text())
	var default_list      = json["default_list"]
	var window_size       = json["window_size"]
	var window_po         = json["window_po"]
	Global.animationState = json["animationState"]
	TranslationServer.set_locale(json["language"])
	get_window().size     = Vector2(window_size[0],window_size[1])
	get_window().position = Vector2(window_po[0],window_po[1])
	$todoItemArea.showDayTodo(default_list)
	file.close()
	$leftMenu/Node.init_list(default_list)

#存储状态
func saveState():
	var wSize = get_window().size
	var po   = get_window().position
	var default_list = Global.nowList
	if default_list == null || default_list == "":
		default_list = "Today"
	var file = FileAccess.open(dir+"conf/core.json",FileAccess.WRITE)
	var json = {
		"is_frist":false,
		"default_list":default_list,
		"animationState":Global.animationState,
		"language":TranslationServer.get_locale(),
		"window_size":[wSize.x,wSize.y],
		"window_po":[po.x,po.y]}
	var data = JSON.stringify(json)
	file.store_string(data)
	file.close()
	
#当软件退出,存储当前状态
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		$todoItemArea.Save()
		saveState()
