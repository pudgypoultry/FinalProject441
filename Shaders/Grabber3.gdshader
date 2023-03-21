shader_type spatial;

vec3 fresnel_glow(float amount, float intensity, vec3 color, vec3 normal, vec3 view)
{
	return pow((1.0 - dot(normalize(normal), normalize(view))), amount) * color * intensity;
}

void fragment()
{
	vec3 base_color = vec3(0.0, 0.0, 0.0);
	vec3 fresnel_color = vec3(1.0, 1.0, 1.0);
	vec3 fresnel = fresnel_glow(3, 3, fresnel_color, NORMAL, VIEW);
	ALBEDO = base_color + fresnel;
}
