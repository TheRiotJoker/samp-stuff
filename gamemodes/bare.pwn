#include <a_samp>
#include <core>
#include <float>
#include <sscanf2>
#include <vehiclehelpers>

//-----------------------------------------------------------------------------------------------------------------
//----------------------------------------------------CONSTANTS----------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------

#define NAME_MAXLEN 128
#define STR_MAXLEN 256
#define STR_MAXLEN_BIG 4096
#define CMD_COUNT 3

static const COMMANDS[][] = {
    "/coords",
    "/car",
    "/help",
	"/fixcar"
};

#define COORDS 0
#define CAR 1
#define HELP 2
#define FIXCAR 3


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
	print(" beener 1 2 3 4 5 6 \n");
	print("----------------------------------\n");
	new commandText[] = "/car 50";
	OnPlayerCommandText(0, commandText);

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
	new cmd[STR_MAXLEN];
	
	cmd = strtok(cmdtext, idx);

	if(strcmp(cmd, COMMANDS[COORDS], true) == 0) {
		new Float: x, Float: y, Float: z;
		GetPlayerPos(playerid, x, y, z);
		new message[STR_MAXLEN];
		format(message, sizeof(message), "Your coordinates are: X: %f, Y: %f, Z: %f", x, y, z);
		SendClientMessage(playerid, WHITE, message);
		printf("Player %d requested coordinates, these were: X: %f, Y: %f, Z: %f", playerid, x, y, z);
		return 1;
	}

	if(strcmp(cmd, COMMANDS[CAR], true) == 0) {
		new vehicleid;
		//extract command and vehicleid from cmdtext
		sscanf(cmdtext, "s[256]i", cmd, vehicleid);
		//check if vehicleid is valid
		if(vehicleid < 400 && vehicleid > 611) {
			new message[STR_MAXLEN];
			format(message, sizeof(message), "Invalid vehicle id: %d", vehicleid);
			SendClientMessage(playerid, RED, message);
			return 1;
		}
		new Float: x, Float: y, Float: z, Float: a;
		GetPlayerPos(playerid, x, y, z);
		new message[STR_MAXLEN];
		format(message, sizeof(message), "You have spawned vehicle with id: %d", vehicleid);
		SendClientMessage(playerid, GREEN, message);

		GetPlayerFacingAngle(playerid, a);
		CreateVehicle(vehicleid,x + 2*floatcos(90+a, degrees), y+ 2*floatsin(90-a, degrees), z, 0.0, 16, 151, 0);
		return 1;
	}

	if(strcmp(cmd, COMMANDS[HELP], true) == 0) {
		new message[512];
		format(message, sizeof(message), "Available commands: ");
		for(new i = 0; i < CMD_COUNT; i++) {
			strcat(message, "\n");
			strcat(message, COMMANDS[i]);
		}
		SendClientMessage(playerid, WHITE, message);
		return 1;
	}

	if(strcmp(cmd, COMMANDS[FIXCAR], true) == 0) {
		if(!IsPlayerInAnyVehicle(playerid)) {
			SendClientMessage(playerid, RED, "You are not in a vehicle.");
			return 1;
		}
		new vehicleid = GetPlayerVehicleID(playerid);
		RepairVehicle(vehicleid);
		SendClientMessage(playerid, GREEN, "Your vehicle has been repaired.");
		return 1;
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
 	SetPlayerInterior(playerid,0);
	SetPlayerPos(playerid,2510.380615,-1670.454101,13.410902);
	SetPlayerFacingAngle(playerid, 270.0);
	SetPlayerCameraPos(playerid, 2513.380615, -1672.454101, 14.410902);
	SetPlayerCameraLookAt(playerid, 2510.380615,-1670.454101,13.410902);
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
	AddPlayerClass(270,2510.380615,-1670.454101,13.410902,270.1425,0,0,0,0,-1,-1);

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
