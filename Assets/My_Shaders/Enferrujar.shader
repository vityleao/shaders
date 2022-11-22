Shader "Unlit/Enferrujar"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _OldTex("OldTexture", 2D) = "white" {}
        _tempo ("Tempo", float) = 5
    }
        SubShader
        {
            Tags { "RenderType" = "Opaque" }
            LOD 100
            Pass
            {
                HLSLPROGRAM
                    #pragma vertex vert
                    #pragma fragment frag
                    #include  "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                    #include  "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"

                texture2D _MainTex;
                SamplerState sampler_MainTex;
                texture2D _OldTex;
                SamplerState sampler_OldTex;
                float1 _tempo;


                struct Attributes
                {
                    float4 position :POSITION;
                    half2 uv       :TEXCOORD0;
                    half3 normal : NORMAL;
                    half4 color : COLOR;
                };
           
                struct Varyings
                {
                    float4 positionVAR :SV_POSITION;
                    half2 uvVAR       : TEXCOORD0;
                    half4 color : COLOR0;
                   
                    half3 normalVAR : NORMAL;
                };

                Varyings vert(Attributes Input)
                {
                    Varyings Output;
                    float3 position = Input.position.xyz;

                    Output.positionVAR = TransformObjectToHClip(position);

                    Output.uvVAR = Input.uv;
                   
                    Output.normalVAR = Input.normal;
                    Output.color = Input.color;
                   

                    return Output;
                }
                half4 frag(Varyings Input) :SV_TARGET
                {
                    float4 color = lerp(_MainTex.Sample(sampler_MainTex, Input.uvVAR), _OldTex.Sample(sampler_OldTex, Input.uvVAR), _Time.y / _tempo);

                    Light l = GetMainLight();

                    return color;

                }



            ENDHLSL
        }
    }
}