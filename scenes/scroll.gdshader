shader_type canvas_item;

void vertex() {
	UV.x += TIME * .015;
	UV.y += TIME * .015;
}
