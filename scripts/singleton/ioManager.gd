#IO流管理器
extends Node
class_name ioManager

#初始化
func _init():
	set_singleton()

#设置单例
func set_singleton():
	if Global.io == null:
		Global.io = self
	else:
		get_parent().remove_child(self)

#文件是否存在
func exisit_file(path):
	return FileAccess.file_exists(path)

#创建文件,如果文件存在则覆盖
func create_file(path,content=""):
	var f = FileAccess.open(path,FileAccess.WRITE)
	f.store_string(content)
	f.close()

#创建文件当文件不存在的时候
func create_file_on_no_exisit(path,content=""):
	if not exisit_file(path):
		create_file(path,content)

#创建json文件,如果文件存在则覆盖
func create_json_file(path):
	var f = FileAccess.open(path,FileAccess.WRITE)
	f.store_string("{}")
	f.close()

#创建json文件当文件不存在的时候
func create_json_file_no_exisit(path):
	if not exisit_file(path):
		create_json_file(path)

#读取一个文件
func read_file(path):
	var f = FileAccess.open(path,FileAccess.READ)
	return f.get_as_text()

#读取一个json文件
func read_json_file(path):
	return JSON.parse_string(read_file(path))

#读取一个json文件如果不存在则创建
func read_json_no_exisit_to_create(path):
	if exisit_file(path):
		return read_json_file(path)
	else:
		create_json_file(path)

#文件夹是否存在
func exisit_dir(path):
	return DirAccess.dir_exists_absolute(path)

#创建文件夹,如果文件存在则返回
func create_dir(path):
	DirAccess.make_dir_absolute(path)

#创建文件夹,当不存在的时候
func create_dir_on_no_exisit(path):
	if not exisit_dir(path):
		create_dir(path)
