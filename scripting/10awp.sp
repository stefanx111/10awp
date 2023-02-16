#pragma semicolon 1 

#include <PTaH> 
#include <sdktools> 

#define primary_clip_size 20

public Plugin myinfo =
{
	name = "[10awp] Return Old Awp",
	author = "bklol, StefanX",
	description = "Retrun old awp.",
	version = "1.0",
	url = "https://github.com/stefanx111/10awp"
};

Handle hGetCCSWeaponData;

public void OnPluginStart()  
{
	GameData gd = LoadGameConfigFile("10awp.games");
	if (!gd) SetFailState("[10awp] Could not initialize 10awp.games file");
	StartPrepSDKCall(SDKCall_Raw);
	PrepSDKCall_SetFromConf(gd, SDKConf_Signature, "GetCCSWeaponDataFromDef");
	PrepSDKCall_SetReturnInfo(SDKType_PlainOldData, SDKPass_Plain);
	hGetCCSWeaponData = EndPrepSDKCall();
	if(!hGetCCSWeaponData) SetFailState("[10awp] Could not initialize call to GetCCSWeaponDataFromDef");
	CloseHandle(gd);
}

public void OnMapStart()  
{
	CEconItemDefinition ItemDef;
	Address CCSWeaponData;
	ItemDef = PTaH_GetItemDefinitionByName("weapon_awp");
	if(ItemDef && (CCSWeaponData = SDKCall(hGetCCSWeaponData, ItemDef)))
	{
		StoreToAddress(CCSWeaponData + view_as<Address>(primary_clip_size), 10, NumberType_Int32);
	}
}