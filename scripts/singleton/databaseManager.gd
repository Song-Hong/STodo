#数据库
extends Node
class_name databaseManager

#数据库
var db:SGDB

#路径   
var today_path     #当天任务
var tomorrow_path  #明天任务
var week_path      #周末日期


#初始化
func _init():
	set_singleton()  #设置单例

#设置单例
func set_singleton():
	if Global.database == null:
		Global.database = self
	else:
		get_parent().remove_child(self)
		
#初始化
func init_database():
	today_path    = str(Global.time.today)
	tomorrow_path = str(Global.time.tomorrow)
	week_path     = Global.time.weeks
	connect_db()

#删除节点
func delete(id:String):
	db.delete_row(id)

#更新或覆盖数据
func replace(id,data):
	db.replace_row(id,data)

#更新节点的task
func update_item_task(id:String,task:String):
	db.update_row_set(id,"task",task)

#根据名称查询
func select(listname:String):
	match listname:
		"expired"  : pass
		"today"    : return select_today()
		"tomorrow" : return select_tomorrow()
		"week"     : return select_week()
	return null

#查询当天数据
func select_today():
	return select_day(today_path)

#查询明天的数据
func select_tomorrow():
	return select_day(tomorrow_path)
	
#查询本周的数据
func select_week():
	var data = []
	for day in week_path:
		var items = select_day(str(day))
		if items == null:break
		for d in items:
			data.append(d)
	return data

#查询该天信息
func select_day(date:String):
	var result = db.select_where("end",date)
	return result

#初始化数据库
func frist_init_database():
	db = SGDB.new(Paths.user_db_dir)
	#创建表格
	db.create_table("items")

#连接数据库
func connect_db():
	db = SGDB.new(Paths.user_db_dir)
	if !db.table_exist("items"):
		db.create_table_use("items")
	else:
		db.use("items")

#关闭数据库
func close_db():
	pass
