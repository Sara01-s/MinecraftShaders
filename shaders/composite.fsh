#version 330 compatibility

#define COMPOSITE_OUTPUT colortex0 // Configures which buffer to draw to the screen [colortex0 shadowcolor0 shadowtex0 shadowtex1 depthtex0]

in vec2 texcoords;

uniform sampler2D colortex0;
uniform sampler2D depthtex0;

#include "/lib/shadows.glsl"

void main() {
	vec3 albedo = texture(COMPOSITE_OUTPUT, texcoords).rgb;
	float depth = texture(depthtex0, texcoords).r;

	if (depth >= 1.0) {
		gl_FragData[0] = vec4(albedo, 1.0);
		return;
	}

	vec3 clipSpace = vec3(texcoords, depth) * 2.0 - 1.0;
	vec3 shadow = getShadow(clipSpace);

	/* DRAWBUFFERS:0 */
	gl_FragData[0] = vec4(albedo * shadow, 1.0);
}