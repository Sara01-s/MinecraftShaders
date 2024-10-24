#version 330 compatibility

#include "/lib/settings.glsl"
#include "/lib/light_model.glsl"
#include "/lib/utils.glsl"

in vec2 texcoords;
in vec2 lmcoords;
in vec4 vertexColor;
in float vertexDst;
in vec3 normal;
in vec3 worldNormal;

uniform sampler2D gtexture;
uniform sampler2D lightmap;
uniform sampler2D depthtex1;

uniform vec3 fogColor;
uniform float fogStart;
uniform float fogEnd;

void main() {
    vec4 texColor = texture(gtexture, texcoords);

	if (texColor.a < 0.1) {
		discard;
	}

	vec4 lightmapColor = texture(lightmap, lmcoords);
    vec4 terrainColor = texColor * vertexColor * lightmapColor; // minecraft classic look

	vec2 screenPos = gl_FragCoord.xy / vec2(viewWidth, viewHeight);
	float depth = texture(depthtex1, screenPos).r;
	vec3 clipSpace = vec3(screenPos, 1.0) * 2.0 - 1.0;

	vec3 terrainLighted = getLighting(terrainColor.rgb, worldNormal, lmcoords, clipSpace);

	float fogIntensity = smoothstep(fogStart, fogEnd, vertexDst);
	vec3 terrainLightedWithFog = mix(terrainLighted.rgb, fogColor, fogIntensity);

/* DRAWBUFFERS:0 */
    gl_FragData[0] = vec4(terrainLightedWithFog, texColor.a);
}