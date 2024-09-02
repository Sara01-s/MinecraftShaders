#if !defined SETTINGS_GLSL
#define SETTINGS_GLSL

#define SUN_PATH_ROTATION 40.0			// [-50.0 -40.0 -30.0 -20.0 -10.0 0.0 10.0 20.0 30.0 40.0 50.0]
#define AO_LEVEL 1.0 					// [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]
#define SHADOW_BRIGHTNESS 0.0			// [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]

const float sunPathRotation = SUN_PATH_ROTATION;
const float ambientOcclusionLevel = AO_LEVEL;
const int noiseTextureResolution = 256;

#endif