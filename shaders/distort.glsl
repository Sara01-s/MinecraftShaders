vec2 distortPos(vec2 position) {
	float centerDst = length(position);
	float distortion = mix(1.0, centerDst, 0.9);

	return position / distortion;
}

vec2 adjustLightmapUV(vec2 lmcoords) {
	float torchLight = lmcoords.r;
	float skyLight = lmcoords.g;
	vec2 adjustedLightmap;

	adjustedLightmap.r = 2.0 * (torchLight * torchLight);
	adjustedLightmap.g = skyLight * skyLight;

	return adjustedLightmap;
}