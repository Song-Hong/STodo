#时间管理
extends Node
class_name timeManager

#当前的日期
var year
var month
var day
var week

#初始化
func _init():
	set_singleton()  #设置单例
	var time = Time.get_datetime_dict_from_system()
	year     = time.year
	month    = time.month
	day      = time.day
	week     = time.weekday

#设置单例
func set_singleton():
	if Global.time == null:
		Global.time = self
	else:
		get_parent().remove_child(self)

#获取当天的天气
func get_now_day():
	return str(year)+str(month)+str(day)

#获取明天的日期
func get_tomorrow_day():
	var now_year  = year
	var now_month = month
	var now_day   = day
	var days      = get_days_in_year_month(year,month)
	if now_day+1 > days:
		now_month += 1
		if now_month>12:
			now_month = 1
			now_year += 1
		now_day = 1
	else:
		now_day += 1
	return str(now_year)+str(now_month)+str(now_day)


#获取本周的数据
func get_now_week():
	var weeks    = []
	var days     = get_days_in_year_month(year,month)
	var now_day  = day
	var now_week = week
	if week == 0:
		now_week = 6
	var start_day = now_day-now_week
	var check_day = start_day+7
	if check_day < days: #当前周就在本月
		for i in range(7):
			weeks.append(str(year)+str(month)+str(start_day+i))
	elif check_day>days: #当前周横跨本月和下个月
		var now_month_week_days  = days - start_day
		var next_month_week_days = 7 - now_month_week_days
		for i in range(now_month_week_days):
			weeks.append(str(year)+str(month)+str(start_day+i))
		for i in range(next_month_week_days):
			weeks.append(str(year)+str(month)+str(i))
	elif check_day<0:   #当前周横跨本月和上个月
		var now_month_week_days  = now_day
		var last_month_week_days = -start_day
		var now_month = month
		var now_year = year
		if now_month == 1:
			now_month = 12
			now_year -= 1;
		var last_month_days = get_days_in_year_month(now_year,now_month)
		start_day = last_month_days-last_month_week_days
		for i in range(last_month_week_days):
			weeks.append(str(year)+str(month)+str(start_day+i))
		for i in range(now_month_week_days):
			weeks.append(str(year)+str(month)+str(i))
	return weeks

#获取天数胡
func get_days_in_year_month(now_year,now_month):
	match now_month:
		1 : return 31
		3 : return 31
		4 : return 30
		5 : return 31
		6 : return 30
		7 : return 31
		8 : return 31
		9 : return 30
		10: return 31
		11: return 30
		12: return 31
		2 : if (now_year%4==0) and (now_year%100 !=0) or (now_year%400)==0: return 29
	return 28

#获取当月第一天的星期数
func get_frist_day_week(now_year,now_month):
	var now_day = 1
	if now_month == 1 || now_month == 2 :
		now_month += 12
		now_year  -= 1
	return (now_day+2*now_month+3*(now_month+1)/5+ now_year +now_year/4-now_year/100+now_year/400+1)%7

