shader_type canvas_item;

void vertex() {
	UV.x += TIME * .04;
	UV.y += TIME * .04;
}
