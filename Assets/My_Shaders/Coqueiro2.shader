Shader "Unlit/Coqueiro2"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _verde("HowGreen", float) = 0.5
        _oscilation("Oscilation", float) = 0.0002
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            HLSLPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                #include  "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #include  "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"

                float _verde;
                float _oscilation;
                texture2D _MainTex;
                SamplerState sampler_MainTex;

                struct Attributes
                {
                    float4 position :POSITION;
                    float2 uv       :TEXCOORD0;
                    half3 normal : NORMAL;
                    half4 color : COLOR;
                };
           
                struct Varyings
                {
                    float4 positionVAR :SV_POSITION;
                    float2 uvVAR       : TEXCOORD0;
                    half4 color : COLOR0;
                };

                Varyings vert(Attributes Input)
                {
                    Varyings Output;
                    
                    float oscilation = (-0.0002+cos(_Time.w+ Input.position.y*100)*_oscilation);
                    float3 position = Input.position.xyz;

                    if (Input.color.y > _verde) //se o G do r*G*b for maior que 0.5
                    {
                        position += Input.normal * oscilation;
                    } 
                        
                    Output.positionVAR = TransformObjectToHClip(position);

                    Output.uvVAR = Input.uv;
                 
                    Light l = GetMainLight();
                   
                    float intensity = dot(l.direction, TransformObjectToWorldNormal(Input.normal));
                    Output.color = Input.color* intensity;
                   

                    return Output;
                }
                float4 frag(Varyings Input) :SV_TARGET
                {
                    //float4 color = Input.color;
                    float4 color = _MainTex.Sample(sampler_MainTex, Input.uvVAR);
                   
                    return color;
                }



            ENDHLSL
        }
    }
}