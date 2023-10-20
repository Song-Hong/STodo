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
func parsing(data):
	data = JSON.parse_string(data)
	if len(data) == 0: return
	id        = data["id"]
	iNameText = data["name"]
	start     = data["start"]
	end       = data["end"]
	tags      = data["tags"]
	task      = JSON.parse_string(data["task"])
	po        = str2vec2(data["po"])
	size      = str2vec2(data["size"])

#转为db数据
func to_db():
	var data = {
	"id"    : str(id)       ,
	"name"  : str(iNameText),
	"start" : str(start)    ,
	"end"   : str(end)      ,
	"tags"  : str(tags)     ,
	"task"  : str(task)     ,
	"po"    : str(po)       ,
	"size"  : str(size)     }
	return data

#字符串转Vector2
func str2vec2(data_str)->Vector2:
	var vec  = Vector2(0,0)
	var strs = data_str.replace("(", "").replace(")", "").split(",")
	if len(strs)>=2:
		var x = int(strs[0])
		var y = int(strs[1])
		vec = Vector2(x,y)
	return vec
