#截止日期
extends Button

var end_year
var end_month
var end_day

#当按钮点击时
func _on_button_down():
	if Global.nowShowDate != null: 
		if len(get_children()) > 0:
			return
		else:
			if Global.nowContentMenu != null:
				Global.nowShowDate.get_parent().remove_child(Global.nowShowDate)
	var date = preload("res://scenes/date.tscn").instantiate()
	add_child(date)
	date.position = Vector2(0,-get_parent().size.y-40)
	Global.nowShowDate = date

#设置结束的天数
func set_end_date(year,month,day):
	end_year  = year
	end_month = month
	end_day   = day
	var content = ""
	var time      = Time.get_datetime_dict_from_system()
	if time.year != year:
		content = str(year)+"/"+str(month)+str(day)
	elif time.month != month:
		content = str(month)+"/"+str(day)
	else:
		var distanceDays = time.day - day
		if distanceDays < -1:
			content = str(month)+"/"+str(day)
		elif distanceDays == -1:
			content = str("Tomorrow")
		elif distanceDays == 0:
			content = str("Today")
		elif distanceDays == 1:
			content = str("Yesterday")
		else:
			content = str(month)+"/"+str(day)
	text = content

#获取结束的日期
func get_end_date():
	return [end_year,end_month,end_day]
