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
	Hue.RED: Color(1.0, 0.0, 0.0, 1.0),
	Hue.GREEN: Color(0.49, 1.0, 0.0, 1.0),
	Hue.BLUE: Color(0.0, 0.361, 1.0, 1.0),
	Hue.YELLOW: Color(1.0, 0.953, 0.0, 1.0),
	Hue.WHITE: Color(1.0, 1.0, 1.0, 1.0),
}

static func get_color(hue: Hue) -> Color:
	return COLORS[hue]
