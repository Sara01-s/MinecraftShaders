#version 330 compatibility

#include "/lib/settings.glsl"
#include "/lib/light_model.glsl"
#include "/lib/utils.glsl"

in vec2 texcoords;
in vec2 lmcoords;
in vec4 vertexColor;
in float vertexDst;
in vec3 normal;

uniform sampler2D gtexture;
uniform sampler2D lightmap;

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

	float fogIntensity = smoothstep(fogStart, fogEnd, vertexDst);
	vec3 terrainWithFog = mix(terrainColor.rgb, fogColor, fogIntensity);

	vec3 albedo = getLighting(terrainWithFog, normal, lmcoords);

/* DRAWBUFFERS:0 */
    gl_FragData[0] = vec4(albedo, texColor.a);
}