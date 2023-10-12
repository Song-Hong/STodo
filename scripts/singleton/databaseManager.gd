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
	today_path    = Global.time.get_now_day()
	tomorrow_path = Global.time.get_tomorrow_day()
	week_path     = Global.time.get_now_week()
	connect_db()

#测试类
func select():
	var query ="SELECT * FROM items WHERE end = '2023109'"
	print(query)
	db.query(query)
	return db.query_result
	
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
		data.append(select_day(day))
	return data

#查询该天信息
func select_day(date:String):
	var query = "SELECT * FROM items WHERE end = '%s'"%date
	db.query(query)
	return db.query_result

#初始化数据库
func frist_init_database():
	db = SQLite.new() 
	db.path = Paths.user_db_path
	db.open_db()
	#创建表格
	var query = "CREATE TABLE IF NOT EXISTS items (id PRIMARY KEY, name TEXT,task TEXT,po TEXT,tag TEXT,start TEXT,end TEXT,complete INTEGER)"
	db.query(query)
	db.close_db()
	
#插入一个item节点
func insert_item():
	var query = "INSERT INTO items VALUES('dasdsa213124','新节点','null','230,220','def','2023109','2023109')"
	var result = db.query(query)

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
