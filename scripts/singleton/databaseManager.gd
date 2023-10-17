#数据库
extends Node
class_name databaseManager

#数据库
var db:SQLite

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
	today_path    = str(Global.time.get_now_day())
	tomorrow_path = str(Global.time.get_tomorrow_day())
	week_path     = Global.time.get_now_week()
	connect_db()

#删除节点
func delete(id:String):
	var sql = "DELETE FROM items WHERE id='"+id+"'"
	return exec(sql)

#更新节点的task
func update_item_task(id:String,task:String):
	var sql = "UPDATE items SET task = '" + task+"' WHERE ID = '"+id+"';"
	return exec(sql)

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
		for d in select_day(str(day)):
			data.append(d)
	return data

#查询该天信息
func select_day(date:String):
	var query = "SELECT * FROM items WHERE end = '%s'"%date
	return exec(query)

#初始化数据库
func frist_init_database():
	db = SQLite.new() 
	db.path = Paths.user_db_path
	db.open_db()
	#创建表格
	var query = "CREATE TABLE IF NOT EXISTS items (id PRIMARY KEY,name TEXT,start TEXT,end TEXT,tags TEXT,task TEXT,po TEXT,size TEXT)"
	db.query(query)
	db.close_db()

#显示全部表格
func show_tables():
	return exec("SELECT name FROM sqlite_master WHERE type='table'")

#执行sql语句,并返回执行结果
func exec(sql):
	db.query(sql)
	return db.query_result

#执行,并返回错误语句
func err_exec(sql):
	db.query(sql)
	return db.error_message

#连接数据库
func connect_db():
	db = SQLite.new() 
	db.path = Paths.user_db_path
	db.open_db()

#关闭数据库
func close_db():
	if db != null:
		db.close_db()
		db = null
