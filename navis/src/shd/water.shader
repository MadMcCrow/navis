shader_type spatial;
uniform sampler2D noise;
uniform float height_scale = 0.5;
uniform float uv_size = 100;

render_mode specular_toon;

varying vec2 vertex_position;

void vertex() {
  float height = ((texture(noise, VERTEX.xz / 10.0 ).x)*2.0)-1.0; 
  VERTEX.y += height * height_scale * uv_size;
  //VERTEX.y += cos(VERTEX.x * 4.0) * sin(VERTEX.z * 4.0);
}

void fragment() {
  METALLIC = 0.0;
  ROUGHNESS = 0.01;
  ALBEDO = vec3(0.1, 0.3, 0.5);
}

