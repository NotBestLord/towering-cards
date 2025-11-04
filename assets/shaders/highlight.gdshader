/*
Shader from Godot Shaders - the free shader library.
godotshaders.com/shader/pixelate

This shader is under CC0 license. Feel free to use, improve and 
change this shader according to your needs and consider sharing 
the modified result to godotshaders.com.
*/

shader_type canvas_item;

uniform bool enabled;
uniform vec4 color : source_color = vec4(1,1,1,1);

void fragment()
{
	vec4 text = texture(TEXTURE, UV);
	if (text.a == 0.){
		COLOR.a = 0.;
	}
	else{
		COLOR = color;
	}
	if (!enabled){
		COLOR = text;
	}
}