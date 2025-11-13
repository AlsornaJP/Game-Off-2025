shader_type canvas_item;

uniform vec2 u_size = vec2(256.0, 256.0); // tamanho do ColorRect em pixels (passado pelo script)
uniform float u_radius = 100.0;           // raio atual em pixels
uniform float u_soft_edge = 50.0;         // transição suave em pixels
uniform float u_alpha = 1.0;              // alfa (0..1)

void fragment() {
	// UV vai de (0,0) a (1,1) dentro do ColorRect
	vec2 pos_uv = UV - vec2(0.5, 0.5);      // centro em (0,0)
	// converte para pixels (usamos a menor dimensão para preservar círculo)
	float min_dim = min(u_size.x, u_size.y);
	vec2 pos_px = pos_uv * min_dim;         // posição em pixels, centrada

	float dist = length(pos_px);            // distância em pixels do centro

	// smoothstep para criar borda suave: a transição ocorre entre radius-soft_edge e radius
	float edge_inner = max(u_radius - u_soft_edge, 0.0);
	float t = smoothstep(u_radius, edge_inner, dist);

	// queremos uma máscara escura que cubra tudo e tenha um "buraco" (visível) no centro,
	// então t = 0 no centro (visível) e t = 1 fora do círculo (escuro)
	// multiplicamos por u_alpha para controlar a intensidade da escuridão
	COLOR = vec4(0.0, 0.0, 0.0, t * u_alpha);
}
