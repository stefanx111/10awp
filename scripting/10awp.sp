#pragma semicolon 1 

#include <PTaH> 
#include <sdktools> 

#define primary_clip_size 20

Handle hGetCCSWeaponData;
char sig[] = "\x55\x89\xE5\x53\x83\xEC\x04\x8B\x45\x08\x85\xC0\x74\x4A\x8B\x15";

public void OnPluginStart()  
{
	StartPrepSDKCall(SDKCall_Raw);
	PrepSDKCall_SetSignature(SDKLibrary_Server, sig, sizeof(sig) - 1);
	PrepSDKCall_SetReturnInfo(SDKType_PlainOldData, SDKPass_Plain);
	hGetCCSWeaponData = EndPrepSDKCall();
	if(!hGetCCSWeaponData) SetFailState("Could not initialize call to GetCCSWeaponDataFromDef");
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