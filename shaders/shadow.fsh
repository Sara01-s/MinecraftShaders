#version 330 compatibility

in vec2 texcoords;
in vec4 vertexColor;

uniform sampler2D colortex0;

void main() {
	gl_FragData[0] = texture(colortex0, texcoords) * vertexColor;
}