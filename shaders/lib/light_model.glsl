#if !defined LIGHT_MODEL_GLSL
#define LIGHT_MODEL_GLSL

#include "/lib/utils.glsl"
#include "/lib/shadows.glsl"

uniform vec3 shadowLightPosition;
uniform float viewWidth, viewHeight;
uniform vec3 skyColor;
uniform vec3 upPosition; // IN VIEW SPACE!!! magnitude = 100.0

const vec3 ambientColor = vec3(0.02, 0.04, 0.08);
const vec3 torchColor = vec3(0.98, 0.68, 0.55);

vec3 getLighting(vec3 albedo, vec3 worldNormal, vec2 lmcoords, vec3 clipSpace) {
	vec4 worldUpDir = gbufferModelViewInverse * vec4(upPosition, 1.0); // up in world space
	vec3 worldSunPosition = mat3(gbufferModelViewInverse) * normalize(shadowLightPosition);

	float ndotl = max(0.0, dot(worldNormal, worldSunPosition));

    vec3 skyLight = lmcoords.y * skyColor;
    vec3 torchLight = lmcoords.x * torchColor;
    vec3 lightColor = skyLight + torchColor;

	vec3 diffuse = albedo;
	diffuse *= ndotl + lightColor + ambientColor;
	diffuse *= lmcoords.g; // darken areas with low sky exposure. (aka lmcoords.g)

	return diffuse;
}

#endif