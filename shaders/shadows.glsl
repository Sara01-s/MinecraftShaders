#include "distort.glsl"

const int numShadowSamples = 3;
const int shadowSamplesPerSize = 2 * numShadowSamples + 1; // 1 to account for center
const int totalSamples = shadowSamplesPerSize * shadowSamplesPerSize;

const int shadowMapResolution = 1024;
const float shadowBias = 0.0001;

uniform sampler2D shadowtex0;	// shadow map   (distances from light source)
uniform sampler2D shadowtex1;	// shadow map 2 (same as shadwotex0 but excluding transparents)
uniform sampler2D shadowcolor0; // shadow.fsh output

uniform mat4 gbufferProjectionInverse;
uniform mat4 gbufferModelViewInverse;
uniform mat4 shadowModelView;
uniform mat4 shadowProjection;

float isVisibleByTheLight(sampler2D shadowMap, vec3 uv, float bias) {
	float shadowMapDepth = texture(shadowMap, uv.xy).r;

	if (uv.z + bias >= shadowMapDepth) {
		return 0.0;
	}
	else { // is visible
		return 1.0;
	}
}

vec3 getShadowColor(vec3 uv, float bias) {
    float shadowVisibility0 = isVisibleByTheLight(shadowtex0, uv, bias);
    float shadowVisibility1 = isVisibleByTheLight(shadowtex1, uv, bias);

    vec4 shadowColor = texture(shadowcolor0, uv.xy);
    vec3 transmittedColor = shadowColor.rgb * (1.0 - shadowColor.a);

	bool s0 = shadowVisibility0 > 0.5 ? true : false;

	if (s0) {
		return vec3(1.0);
	}
	else {
		return transmittedColor * shadowVisibility1; // evitar sombras debajo de bloques
	}

    //return mix(transmittedColor * shadowVisibility1, vec3(1.0), shadowVisibility0);
}

vec3 getShadow(vec3 clipSpace) {
    vec4 viewSpaceHomogenous = gbufferProjectionInverse * vec4(clipSpace, 1.0);
    vec3 viewSpace = viewSpaceHomogenous.xyz / viewSpaceHomogenous.w;

    vec4 worldSpace = gbufferModelViewInverse * vec4(viewSpace, 1.0);
    vec4 shadowSpace = shadowProjection * (shadowModelView * worldSpace);

	shadowSpace.xy = distortPos(shadowSpace.xy);

    vec3 shadowCoords = shadowSpace.xyz * 0.5 + 0.5;
	vec3 shadowSamples = vec3(0.0);

    for (int x = -numShadowSamples; x <= numShadowSamples; x++) {
        for (int y = -numShadowSamples; y <= numShadowSamples; y++) {
            vec2 sampleOffset = vec2(x, y) / shadowMapResolution;
            vec3 sampleCoords = vec3(shadowCoords.xy + sampleOffset, shadowCoords.z);
	
            shadowSamples += getShadowColor(sampleCoords, shadowBias);
        }
    }

    return shadowSamples / totalSamples;
}