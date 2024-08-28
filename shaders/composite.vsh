#version 330 compatibility

out vec2 texcoords;

void main() {
	gl_Position = ftransform();
	texcoords = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
}