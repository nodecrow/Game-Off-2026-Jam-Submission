extends RefCounted
class_name Palette

enum Hue {
	RED,
	GREEN,
	BLUE,
	YELLOW,
	WHITE,
}

const COLORS = {
	Hue.RED: Color(0.827, 0.153, 0.204, 1.0),
	Hue.GREEN: Color(0.157, 0.776, 0.255, 1.0),
	Hue.BLUE: Color(0.176, 0.576, 0.867, 1.0),
	Hue.YELLOW: Color(0.902, 0.855, 0.161, 1.0),
	Hue.WHITE: Color(1.0, 1.0, 1.0, 1.0),
}

static func get_color(hue: Hue) -> Color:
	return COLORS[hue]
