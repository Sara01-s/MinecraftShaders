#version 330 compatibility
#include "distort.glsl"

out vec2 texcoords;
out vec4 vertexColor;

void main() {
	gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
	gl_Position.xy = distortPos(gl_Position.xy);

	texcoords = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	vertexColor = gl_Color;
}