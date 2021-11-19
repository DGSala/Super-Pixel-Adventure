shader_type canvas_item;

uniform bool blinking = false;

void fragment() {
	vec4 color1 = texture(TEXTURE, UV);
	vec4 blink_color = vec4(1.0, 0.0, 0.0, color1.a);
	vec4 color2 = color1;
	if (blinking == true){
		color2 = blink_color;
	}
	COLOR = color2;
}