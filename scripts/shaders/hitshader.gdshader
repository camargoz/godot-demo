shader_type canvas_item;

uniform float flash : hint_range(0.0, 1.0) = 0.0;

void fragment() {
  vec4 tex = texture(TEXTURE, UV);
  tex.rgb = mix(tex.rgb, vec3(1.0), flash);
  COLOR = tex;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
