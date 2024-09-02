#if !defined UTILS_GLSL
#define UTILS_GLSL

const vec3 LUMA = vec3(0.2125, 0.7153, 0.0721);

float luminance(vec3 color) {
    return dot(color, LUMA);
}

vec2 distort(vec2 position) {
	float centerDst = length(position);
	float distortion = mix(1.0, centerDst, 0.9);

	return position / distortion;
}

#endif
