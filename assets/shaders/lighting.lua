return {
    code = [[
        extern vec2 light_positions[30];
        extern float light_size;

        extern vec2 camera;
        extern number number_of_lights;
        
        vec4 effect(vec4 color, Image texture, vec2 uvs, vec2 coords){
            vec4 pixel = Texel(texture, uvs);

            // get the distance
            number n = number_of_lights;

            vec3 rgb = vec3(0.1,0.1,0.1);
        
            for (int i = 0; i < number_of_lights; i++){
                number dist = distance(coords, light_positions[i] - camera);
                number bright = number_of_lights / dist * light_size;

                rgb.x *= bright;
                rgb.y *= bright;
                rgb.z *= bright;

            }
            rgb = clamp(rgb, 0, 1);

            pixel.r = pixel.r * rgb.x;
            pixel.g = pixel.g * rgb.y;
            pixel.b = pixel.b * rgb.z;

            return pixel * color;
        }

    ]]
}