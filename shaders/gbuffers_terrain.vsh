#version 330 compatibility

out vec2 texcoords;
out vec2 lmcoords;
out vec4 vertexColor;
out float vertexDst;
out vec3 normal;

void main() {
    gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;			// vertex in clip position
	
	texcoords = (gl_TextureMatrix[0] * gl_MultiTexCoord0).st;
    lmcoords  = (gl_TextureMatrix[1] * gl_MultiTexCoord1).st;

	vertexColor = gl_Color;
	normal = gl_NormalMatrix * gl_Normal;

	vertexDst = length((gl_ModelViewMatrix * gl_Vertex).xyz);		// distance to the vertex (in camera space)
}