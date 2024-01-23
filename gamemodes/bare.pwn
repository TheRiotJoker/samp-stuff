#include <a_samp>
#include <core>
#include <float>

//-----------------------------------------------------------------------------------------------------------------
//----------------------------------------------------CONSTANTS----------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------

#define NAME_MAXLEN 128
#define STR_MAXLEN 256

//-----------------------------------------------------------------------------------------------------------------
//----------------------------------------------------COLORS-------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------
#define RED 0xFF0000FF
#define GREEN 0x00FF00FF
#define BLUE 0x0000FFFF
#define YELLOW 0xFFFF00FF
#define ORANGE 0xFFA500FF
#define PURPLE 0x800080FF
#define WHITE 0xFFFFFFFF
#define BLACK 0x000000FF

#pragma tabsize 0

main()
{
	print("\n----------------------------------");
	print("  Bare Script\n");
	print("----------------------------------\n");
}

public OnPlayerConnect(playerid)
{
	new playerName[NAME_MAXLEN];
	GetPlayerName(playerid, playerName, sizeof(playerName));
	GameTextForPlayer(playerid,"~w~SA-MP: ~r~Bare Script",5000,5);
	new messageForAll[STR_MAXLEN];
	format(messageForAll, sizeof(messageForAll), "%s has connected to the server. ", playerName);
	SendClientMessageToAll(GREEN, messageForAll);
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new idx;
	new cmd[256];
	
	cmd = strtok(cmdtext, idx);

	if(strcmp(cmd, "/coords", true) == 0) {
		new Float: x, Float: y, Float: z;
		GetPlayerPos(playerid, x, y, z);
		new message[STR_MAXLEN];
		format(message, sizeof(message), "Your coordinates are: X: %f, Y: %f, Z: %f", x, y, z);
		SendClientMessage(playerid, WHITE, message);
		printf("Player %d requested coordinates, these were: X: %f, Y: %f, Z: %f", playerid, x, y, z);
		return 1;
	}

	if(strcmp(cmd, "/car", true) == 0) {

	}

	return 0;
}

public OnPlayerSpawn(playerid)
{
	SetPlayerInterior(playerid,0);
	TogglePlayerClock(playerid,0);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
   	return 1;
}

SetupPlayerForClassSelection(playerid)
{
 	SetPlayerInterior(playerid,14);
	SetPlayerPos(playerid,258.4893,-41.4008,1002.0234);
	SetPlayerFacingAngle(playerid, 270.0);
	SetPlayerCameraPos(playerid,256.0815,-43.0475,1004.0234);
	SetPlayerCameraLookAt(playerid,258.4893,-41.4008,1002.0234);
}

public OnPlayerRequestClass(playerid, classid)
{
	SetupPlayerForClassSelection(playerid);
	return 1;
}

public OnGameModeInit()
{
	SetGameModeText("Bare Script");
	ShowPlayerMarkers(1);
	ShowNameTags(1);
	AllowAdminTeleport(1);

	AddPlayerClass(265,1958.3783,1343.1572,15.3746,270.1425,0,0,0,0,-1,-1);

	return 1;
}

strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
