#version 330 compatibility

#include "settings.glsl"
#include "light_model.glsl"

in vec2 texcoords;
in vec2 lmcoords;
in vec4 vertexColor;
in float vertexDst;
in vec3 normal;

uniform sampler2D gtexture;
uniform sampler2D lightmap;
uniform vec3 shadowLightPosition;

uniform vec3 fogColor;
uniform float fogStart;
uniform float fogEnd;

void main() {
    vec4 texColor = texture(gtexture, texcoords);

	if (texColor.a < 0.1) {
		discard;
	}

    vec4 terrainColor = texColor * vertexColor;

	float fogIntensity = smoothstep(fogStart, fogEnd, vertexDst);
	vec3 terrainWithFog = vec3(mix(terrainColor.rgb, fogColor, fogIntensity));

	vec3 albedo = getLighting(terrainWithFog, normal, shadowLightPosition);
	vec2 light = texture(lightmap, lmcoords).rg;

/* DRAWBUFFERS:01 */
    gl_FragData[0] = vec4(light, 0.0, terrainColor.a);
}