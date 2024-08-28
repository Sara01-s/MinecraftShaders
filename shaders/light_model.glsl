vec3 getLighting(vec3 albedo, vec3 normal, vec3 lightPos) {
	float ndotl = max(0.2, dot(normal, normalize(lightPos)));
	vec3 diffuse = albedo * ndotl;

	return diffuse;
}