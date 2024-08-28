#version 330 compatibility

in vec2 texCoord;
in vec2 lightCoord;
in vec4 vertexColor;
in float vertexDistance;
in vec3 normal;

uniform sampler2D gtexture;
uniform sampler2D lightmap;

uniform float fogStart;
uniform float fogEnd;
uniform vec3 fogColor;
uniform vec3 shadowLightPosition;

layout(location = 0) out vec4 pixelColor;

void main() {
    vec4 texColor = texture(gtexture, texCoord);

    if (texColor.a < 0.1) {
		discard;
	}

    vec4 lightColor = texture(lightmap, lightCoord);
    float fogValue = vertexDistance < fogEnd ? smoothstep(fogStart, fogEnd, vertexDistance) : 1.0;
    vec4 finalColor = texColor * lightColor * vertexColor;
	float NdotL = max(0.2, dot(normal, normalize(shadowLightPosition)));

	finalColor.rgb *= NdotL;

    pixelColor = vec4(mix(finalColor.xyz, fogColor, fogValue), finalColor.a);
}