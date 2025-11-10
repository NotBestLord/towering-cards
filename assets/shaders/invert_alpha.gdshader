shader_type canvas_item;


uniform vec3 color : source_color;
uniform float max_a : hint_range(0.0, 1.0, 0.05) = 0.8;
uniform float min_a : hint_range(0.0, 1.0, 0.05) = 0.;


void fragment() {
	COLOR = texture(TEXTURE, UV);
	COLOR.rgb = color;
	COLOR.a = clamp(1. - COLOR.a, min_a, max_a);
}