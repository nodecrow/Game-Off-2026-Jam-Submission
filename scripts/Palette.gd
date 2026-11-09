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
	Hue.RED: Color.RED,
	Hue.GREEN: Color.GREEN,
	Hue.BLUE: Color.BLUE,
	Hue.YELLOW: Color.YELLOW,
	Hue.WHITE: Color.WHITE,
}

static func get_color(hue: Hue) -> Color:
	return COLORS[hue]
