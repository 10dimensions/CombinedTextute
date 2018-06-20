// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:4013,x:33231,y:32226,varname:node_4013,prsc:2|emission-3139-OUT;n:type:ShaderForge.SFN_Tex2d,id:9072,x:32618,y:32083,ptovrint:False,ptlb:Tex_1,ptin:_Tex_1,varname:node_9072,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:31954ab6b91ab4748954f7e84c7cd457,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:6893,x:32618,y:32297,ptovrint:False,ptlb:Tex_2,ptin:_Tex_2,varname:node_6893,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:ed31c87d158a62c4b8071f4ac6fe9391,ntxv:2,isnm:False;n:type:ShaderForge.SFN_TexCoord,id:4374,x:32352,y:32467,varname:node_4374,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Lerp,id:3139,x:33039,y:32325,varname:node_3139,prsc:2|A-9072-RGB,B-6893-RGB,T-7052-OUT;n:type:ShaderForge.SFN_Slider,id:8957,x:32069,y:32692,ptovrint:False,ptlb:slider,ptin:_slider,varname:node_8957,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.4871795,max:1;n:type:ShaderForge.SFN_Round,id:7052,x:32825,y:32539,varname:node_7052,prsc:2|IN-3360-OUT;n:type:ShaderForge.SFN_Vector1,id:3826,x:32226,y:32768,varname:node_3826,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Add,id:3360,x:32629,y:32539,varname:node_3360,prsc:2|A-4374-U,B-1254-OUT;n:type:ShaderForge.SFN_Subtract,id:1254,x:32415,y:32685,varname:node_1254,prsc:2|A-8957-OUT,B-3826-OUT;proporder:9072-6893-8957;pass:END;sub:END;*/

Shader "Shader Forge/TextureSlider" {
    Properties {
        _Tex_1 ("Tex_1", 2D) = "white" {}
        _Tex_2 ("Tex_2", 2D) = "black" {}
        _slider ("slider", Range(0, 1)) = 0.4871795
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _Tex_1; uniform float4 _Tex_1_ST;
            uniform sampler2D _Tex_2; uniform float4 _Tex_2_ST;
            uniform float _slider;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                UNITY_FOG_COORDS(1)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
////// Lighting:
////// Emissive:
                float4 _Tex_1_var = tex2D(_Tex_1,TRANSFORM_TEX(i.uv0, _Tex_1));
                float4 _Tex_2_var = tex2D(_Tex_2,TRANSFORM_TEX(i.uv0, _Tex_2));
                float3 emissive = lerp(_Tex_1_var.rgb,_Tex_2_var.rgb,round((i.uv0.r+(_slider-0.5))));
                float3 finalColor = emissive;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
