shader_type canvas_item;

uniform vec4 base_color : source_color = vec4(1.0);
uniform vec3 color : source_color = vec3(1.0, 1.0, 1.0);
uniform float flash : hint_range(0.0, 1.0) = 0.0;

void fragment() {
	vec4 tex = texture(TEXTURE, UV);
	vec4 final_color = tex * base_color;
	final_color.rgb = mix(final_color.rgb, color, flash);
	COLOR = final_color;
}