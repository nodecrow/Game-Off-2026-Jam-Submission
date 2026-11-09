extends RefCounted
class_name Palette

enum Hue {
	RED,
	GREEN,
	BLUE,
	YELLOW
}

const COLORS = {
	Hue.RED: Color.RED,
	Hue.GREEN: Color.GREEN,
	Hue.BLUE: Color.BLUE,
	Hue.YELLOW: Color.YELLOW,
}

static func get_color(hue: Hue) -> Color:
	return COLORS[hue]
