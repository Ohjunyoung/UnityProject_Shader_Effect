Shader "Custom/BasicDiffuse" {
	Properties {
		//_Color ("Color", Color) = (1,1,1,1)
		//_MainTex ("Albedo (RGB)", 2D) = "white" {}
		//_Glossiness ("Smoothness", Range(0,1)) = 0.5
		//_Metallic ("Metallic", Range(0,1)) = 0.0
		_EmissiveColor("Emisssive Color", Color) = (1,1,1,1)
		_AmbientColor ("Ambient Color",Color) = (1,1,1,1)
		_MySliderValue ("This is a Slider", Range(0,10)) = 2.5
		_RampTex ("Ramp Texture", 2D) = "white"{}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		//#pragma surface surf Standard fullforwardshadows
		#pragma surface surf BasicDiffuse
		#pragma target 3.0
		float4 _EmissiveColor;
		float4 _AmbientColor;
		float _MySliderValue;
		sampler2D _RampTex;
		// Use shader model 3.0 target, to get nicer looking lighting
		

		//sampler2D _MainTex;

		//struct Input {
			//float2 uv_MainTex;
		//};

		//half _Glossiness;
		//half _Metallic;
		//fixed4 _Color;
		
		inline half4 LightingBasicDiffuse (SurfaceOutput s, half3 lightDir, half atten)
		{
			half NdotL = dot(s.Normal, lightDir);
   			half diff = NdotL*0.5+0.5;
   			half3 ramp = tex2D(_RampTex, float2(diff)).rgb;
   			half4 c;
   			c.rgb = s.Albedo * _LightColor0.rgb * ramp * (atten *2);
  			c.a = s.Alpha;
  			return c;
		}

		
		struct Input
		{
			float2 uv_MainTex;
		};
		
		
		void surf (Input IN, inout SurfaceOutput o) {
			// Albedo comes from a texture tinted by color
			//fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			//o.Albedo = c.rgb;
			// Metallic and smoothness come from slider variables
			//o.Metallic = _Metallic;
			//o.Smoothness = _Glossiness;
			//o.Alpha = c.a;
			
			float4 c;
			c = pow((_EmissiveColor + _AmbientColor), _MySliderValue);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
