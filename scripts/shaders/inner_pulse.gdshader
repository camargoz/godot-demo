shader_type canvas_item;

uniform vec3 pulse_color : source_color = vec3(1.0, 1.0, 1.0);
uniform float pulse_strength : hint_range(0.0, 1.0) = 0.5;
uniform float pulse_speed : hint_range(0.1, 10.0) = 3.0;

void fragment() {
  vec4 tex = texture(TEXTURE, UV);
  float pulse = pow(sin(TIME * pulse_speed) * 0.5 + 0.5, 2.0) * pulse_strength;

  tex.rgb = mix(tex.rgb, pulse_color, pulse * tex.a);
  COLOR = tex;
}