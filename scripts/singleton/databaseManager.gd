#数据库
extends Node
class_name databaseManager

var db:SQLite

func _init():
	set_singleton()  #设置单例

#设置单例
func set_singleton():
	if Global.database == null:
		Global.database = self
	else:
		get_parent().remove_child(self)

#连接数据库
func init_database():
	db = SQLite.new()
	db.path = Paths.db_path
	db.open_db()
	
#查询当天数据
func select_today():
	pass
