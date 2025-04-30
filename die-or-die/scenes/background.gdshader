shader_type canvas_item;

uniform vec4 color_a : source_color;
uniform vec4 color_b : source_color;
uniform vec4 color_c : source_color;

uniform float spin_speed = 1.0;
uniform float noise_scale = 20.0;
uniform float contrast = 2.0;
uniform float intensity = 1.0;
uniform vec2 mouse_position;

float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

float noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);

    float a = hash(i);
    float b = hash(i + vec2(1.0, 0.0));
    float c = hash(i + vec2(0.0, 1.0));
    float d = hash(i + vec2(1.0, 1.0));

    vec2 u = f*f*(3.0 - 2.0*f);
    return mix(a, b, u.x) +
           (c - a)* u.y * (1.0 - u.x) +
           (d - b) * u.x * u.y;
}

void fragment() {
    // Snap screen UV to a pixel grid
	float pixel_resolution = 300.0; // lower = more pixelized
	vec2 pixel_uv = floor(UV * pixel_resolution) / pixel_resolution;

	vec2 uv = pixel_uv * noise_scale;

    vec2 distorted_uv = uv;

    // Add chaotic swirl like before
    for (int i = 0; i < 5; i++) {
        float t = TIME * spin_speed * float(i);
        distorted_uv += vec2(sin(t + distorted_uv.y), cos(t - distorted_uv.x)) * 0.2;
    }

    // Mouse distortion
    float dist = distance(UV, mouse_position);
    float influence = smoothstep(0.3, 0.0, dist); // falloff
    vec2 warp = (UV - mouse_position) * influence * 0.2;
    distorted_uv += warp * intensity;

    distorted_uv = floor(distorted_uv * 25.0) / 25.0;

    // noisy background
    float n = noise(distorted_uv);
    n = pow(n, contrast);

    vec4 base = mix(color_a, color_b, n);
    COLOR = base;
}