#日历组件
extends Panel

#全部按钮
@export var dayListGroup:ButtonGroup

#局部变量
var now_year        #当前年份
var now_month       #当前月份
var now_day         #当前天数
var now_choose_btn:Button  #当前选中的按钮

#准备
func _ready():
	var time      = Time.get_datetime_dict_from_system()
	now_year      = time.year
	now_month     = time.month
	show_date()
	update_tip_text()
	for btn in dayListGroup.get_buttons():
		btn.connect("pressed",Callable(self,"on_pressed"))
		if btn.text == str(now_day):
			btn.button_pressed = true
			now_choose_btn = btn

#取消选中的按钮
func cancel_button_choose():
	now_choose_btn.button_pressed = false

#当天数按钮点击时
func on_pressed():
	var btn = dayListGroup.get_pressed_button()
	now_choose_btn = btn
	if btn.text == "":
		Global.nowShowDate = null
		get_parent().remove_child(self)
		return
	set_now_day(int(btn.text))
	Global.nowShowDate = null
	get_parent().remove_child(self)

#设置当前天数
func set_now_day(day):
	now_day = day
	get_parent().set_end_date(now_year,now_month,now_day)

#获取当前日期
func get_now_date():
	return str(now_year)+"/"+str(now_month)+"/"+str(now_day)

#初始化值当前天
func init_to_today():
	var time      = Time.get_datetime_dict_from_system()
	now_year      = time.year
	now_month     = time.month
	set_now_day(time.day)

#显示日历
func show_date():
	clear_day_number()
	var monthDay  = get_days_in_year_month(now_year,now_month)
	var fristWeek = get_frist_day_week(now_year,now_month)
	show_day_number(fristWeek,monthDay)
	size = Vector2(196,224)
	
#获取天数胡
func get_days_in_year_month(year,month):
	match month:
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
		2 : if (year%4==0) and (year%100 !=0) or (year%400)==0: return 29
	return 28

#获取当月第一天的星期数
func get_frist_day_week(year,month):
	var day = 1
	if month == 1||month == 2 :
		month += 12
		year  -= 1
	return (day+2*month+3*(month+1)/5+ year +year/4-year/100+year/400+1)%7

#清除全部天数信息
func clear_day_number():
	for li in $List.get_children():
		li.text = ""

#显示天数,在日历上
func show_day_number(fristWeek,monthDay):
	var list = $List.get_children()
	var i = fristWeek
	var n = 1
	for l in range(monthDay):
		list[i].text = str(n)
		i += 1
		n += 1

#更新提示信息
func update_tip_text():
	$YearMonth.text = str(now_year)+" / "+str(now_month)

#当上一个月按钮点击
func _on_last_month_button_down():
	cancel_button_choose()
	now_month -= 1
	if now_month< 1 : 
		now_month = 12
		now_year -= 1
	show_date()
	update_tip_text()

#当下一个月按钮点击
func _on_next_month_button_down():
	cancel_button_choose()
	now_month += 1
	if now_month>12 : 
		now_month = 1
		now_year += 1
	show_date()
	update_tip_text()
