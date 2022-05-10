#version 150

#moj_import <fog.glsl>
#moj_import <tools.glsl>
#moj_import <utils.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

in float vertexDistance;
in float dist;
in vec2 texCoord0;
in vec4 vertexColor;
in vec4 lightColor;
in vec4 glpos;

out vec4 fragColor;

void main() {
    discardControlGLPos(gl_FragCoord.xy, glpos);
    vec4 color = texture(Sampler0, texCoord0) * vertexColor * ColorModulator;
    float alpha = textureLod(Sampler0, texCoord0, 0.0).a * 255.0;
    color = make_emissive(color, lightColor, dist, alpha);
    if (color.a < 0.1) {
        discard;
    }
    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}
