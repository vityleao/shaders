Shader "Unlit/Coqueiro"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}

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
                    
                    float oscilation = (-0.0002+cos(_Time.w+ Input.position.y*100)*0.0002);
                    float3 position = Input.position.xyz;

                    if (Input.color.y > 0.5) //se o G do r*G*b for maior que 0.5
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
                    float4 color = Input.color;
                    
                    return color;
                }



            ENDHLSL
        }
    }
}