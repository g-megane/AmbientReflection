// コンスタントバッファ
cbuffer ConstantBuffer : register(b0)
{
    matrix World;           // ワールド行列
    matrix View;            // ビュー行列
    matrix Projection;      // 射影行列
    float4 lightAmbient;    // 環境光
    float4 materialAmbient; // 物体の色
}

struct VS_INPUT
{
    float4 Pos : POSITION; // 頂点位置
    float3 Norm : NORMAL;  // 法線ベクトル
};

struct PS_INPUT
{
    float4 Pos  : SV_POSITION;
    float4 PosW : POSITION0;
    float4 NorW : TEXCOORD0;
};

PS_INPUT VS(VS_INPUT input)
{
    PS_INPUT output = (PS_INPUT)0;
    output.PosW = mul(input.Pos, World);
    output.Pos  = mul(output.PosW, View);
    output.Pos  = mul(output.Pos, Projection);
    output.NorW = mul(input.Norm, World);

    return output;
}