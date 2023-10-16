#存储item数据
extends Node
class_name itemdata

var id        = ""               #唯一ID
var iNameText = "New Todo"       #todo名称
var start     = ""               #开始时间
var end       = []               #结束时间
var tags      = ["def"]          #标签
var task      = {}               #任务
var po        = Vector2(0,0)     #位置
var size      = Vector2(200,200) #尺寸  

#解析
func parsing():
	pass

#转为db数据
func to_db():
	var values = "`"+str(id)+"`,`"+str(iNameText)+"`,`"+str(start)+"`,`"+str(end)+"`,"
	
	#将tag 转为字符串
	var tagstr = "`"
	for tag in tags:
		tagstr+= tag+","
	if tagstr.ends_with(","):
		tagstr = tagstr.trim_suffix(",")
	values+=tagstr+"`,"
	
	#将task转为字符串
	var taskstr = "`"
	for key in task.keys():
		var value = task.get(key)
		taskstr += str(key)+":"+str(value)+","
	if taskstr.ends_with(","):
		taskstr = taskstr.trim_suffix(",")
	values+=taskstr+"`,"
	
	#将位置转为字符串
	values += "`"+str(po[0])+","+str(po[1])+"`,"
	
	#将尺寸转为字符串
	values += "`"+str(size[0])+","+str(size[1])+"`"
	
	#拼接sql语句字符串
	var insert = "REPLACE INTO items (id,name,start,end,tags,task,po,size) VALUES (%s)"%values
	#var update = "ON DUPLICATE KEY UPDATE "+str(id)+" = VALUES(%s)"%values
	
	return insert
