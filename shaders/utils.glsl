float luminance(vec3 color) {
    return dot(color, vec3(0.2125, 0.7153, 0.0721));
}