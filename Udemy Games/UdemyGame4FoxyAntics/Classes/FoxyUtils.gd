extends Object

class_name FoxyUtils

static func formatted_dt() -> String:
	var dr = Time.get_datetime_dict_from_system()
	return "%02d/%02d/%04d" % [dr.day, dr.month, dr.year]
