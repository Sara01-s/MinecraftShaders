#version 330 compatibility

#include "/lib/utils.glsl"

out vec2 texcoords;
out vec4 vertexColor;

void main() {
	vec3 normal = gl_NormalMatrix * gl_Normal;

	gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
	gl_Position.xy = distort(gl_Position.xy);

	texcoords = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	vertexColor = gl_Color;
}