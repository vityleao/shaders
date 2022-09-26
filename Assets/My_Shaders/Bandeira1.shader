Shader "Unlit/Bandeira1"
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

                struct Attributes
                {
                    float4 position :POSITION;
                    float2 uv       :TEXCOORD0;
                };
           
                struct Varyings
                {
                    float4 positionVAR :SV_POSITION;
                    float2 uvVAR       : TEXCOORD0;
                };

                Varyings vert(Attributes Input)
                {
                    Varyings Output;

                    Output.positionVAR = TransformObjectToHClip(Input.position.xyz);
                    Output.uvVAR = Input.uv;
                   
                    //Output.positionVAR = Input.position;

                    return Output;
                }
                float4 frag(Varyings Input) :SV_TARGET
                {
                    
                    //if (Input.uvVAR.y > 0.5) {
                    //     color = float4(1,0,0,1);
                    //}
                    float4 color = float4(0,1,0,1);

                    if (Input.uvVAR.x<0.33)
                    {
                        color = float4(0,146.0,70.0,1.0)/255.0;
                    }
                    else if (Input.uvVAR.x>0.33 && Input.uvVAR.x<0.66)
                    {
                        color = float4(1.0,1.1,1.0,1.0);
                    }
                    else 
                    {
                        color = float4(206.0,43.0,55.0,1.0)/255.0;
                    }
                   
                    return color;
                }
            ENDHLSL
        }
    }
}