#if !defined LIGHT_MODEL_GLSL
#define LIGHT_MODEL_GLSL

#include "/lib/utils.glsl"
#include "/lib/shadows.glsl"

uniform vec3 shadowLightPosition;
uniform float viewWidth, viewHeight;
uniform vec3 skyColor;

const vec3 torchColor = vec3(0.98, 0.68, 0.55);
const vec3 ambientColor = vec3(0.02, 0.04, 0.08);

vec3 getLighting(vec3 albedo, vec3 normal, vec2 lmcoords) {
	float ndotl = max(0.2, dot(normal, normalize(shadowLightPosition)));

    vec3 torchLight = lmcoords.x * torchColor;
    vec3 skyLight = lmcoords.y * skyColor;

    vec3 lightColor = torchLight + skyLight;

	vec3 diffuse = albedo;
	diffuse *= ndotl + lightColor + ambientColor;
	diffuse *= lmcoords.g; // darken areas with low sky exposure. (aka lmcoords.g)

	return max(vec3(0.0), diffuse);
}

#endif