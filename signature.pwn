//------------------------------------------------
/*
	GAdmin System (gadmin.pwn)
	* A call of duty styleed signature system for SAMP (using some textdraws)
	* Two commands: /mysignature (/mysign), /signature (/sign)

 	Author: (creator)
	* Gammix

 	Contributors:
 	* Y_Less - sscanf
	* Zeex & Yashas - izcmd include
	* SAMP team

	(c) Copyright 2015
  	* This file is provided as is (no warranties).
*/
//------------------------------------------------

#define FILTERSCRIPT//must be defined

//------------------------------------------------

#include <a_samp> //SA-MP team
#include <izcmd> //Zeex & Yashas
#include <sscanf2> //Y_Less

//------------------------------------------------

#define DIALOG_SIGN        				(100)

#define DIALOG_SIGN_EDIT   				(DIALOG_SIGN + 1)

#define DIALOG_SIGN_EDIT_BG   			(DIALOG_SIGN + 2)
#define DIALOG_SIGN_EDIT_BG_COL			(DIALOG_SIGN + 3)
#define DIALOG_SIGN_EDIT_BG_COL_0		(DIALOG_SIGN + 4)
#define DIALOG_SIGN_EDIT_BG_COL_1		(DIALOG_SIGN + 5)
#define DIALOG_SIGN_EDIT_BG_IMG			(DIALOG_SIGN + 6)
#define DIALOG_SIGN_EDIT_BG_OPC			(DIALOG_SIGN + 7)

#define DIALOG_SIGN_EDIT_PIC  			(DIALOG_SIGN + 8)
#define DIALOG_SIGN_EDIT_PIC_COL		(DIALOG_SIGN + 9)
#define DIALOG_SIGN_EDIT_PIC_COL_0		(DIALOG_SIGN + 10)
#define DIALOG_SIGN_EDIT_PIC_COL_1		(DIALOG_SIGN + 11)
#define DIALOG_SIGN_EDIT_PIC_IMG		(DIALOG_SIGN + 12)
#define DIALOG_SIGN_EDIT_PIC_OPC		(DIALOG_SIGN + 13)

#define DIALOG_SIGN_EDIT_MOTO  			(DIALOG_SIGN + 14)
#define DIALOG_SIGN_EDIT_MOTO_COL		(DIALOG_SIGN + 15)
#define DIALOG_SIGN_EDIT_MOTO_COL_0		(DIALOG_SIGN + 16)
#define DIALOG_SIGN_EDIT_MOTO_COL_1		(DIALOG_SIGN + 17)
#define DIALOG_SIGN_EDIT_MOTO_TEXT		(DIALOG_SIGN + 18)
#define DIALOG_SIGN_EDIT_MOTO_OPC		(DIALOG_SIGN + 19)

#define DIALOG_SIGN_RESTORE   			(DIALOG_SIGN + 20)

#define COLOR_SIGNATURE         		(0xFFDAB9FF)
#define COLOR_SIGNATURE_RANK        	(0xFFFFFFFF)

#define MAX_MOTO_SIZE                   (50)

//------------------------------------------------

enum e_PLAYER_SIGNATURE
{
				i_ExpireTimer,
				i_NameColor,
				i_BackgroundColor,
				i_AvatarColor,
				i_MotoColor,
	PlayerText:	i_Textdraw[9],
	bool:       b_Toggled,
				s_BackgroundSprite[25],
				s_AvatarSprite[25],
				s_Moto[MAX_MOTO_SIZE]
};

enum e_RANK_DATA
{
				i_Score,
				s_RankName[35]
};

new
				g_PlayerSignature[MAX_PLAYERS][e_PLAYER_SIGNATURE]
;

new
				g_ScoreBasedRanks[][e_RANK_DATA] =
{
				{0, 		"Newbie"},
				{50, 		"Beginner"},
				{100, 		"Trainne"},
				{200, 		"Private"},
				{500, 		"Specialist"},
				{750, 		"Expert"},
				{1000,		"Master"},
				{1500, 		"Killer"},
				{1750, 		"Pschyo Killer"},
				{2000, 		"Silent Killer"},
				{2500, 		"Topper"},
				{3000, 		"Predator"},
				{4000, 		"Allien"},
				{5000, 		"Champion"},
				{6500, 		"Soldier"},
				{7500, 		"Leader"},
				{9000, 		"Optimistic"},
				{10000, 	"Marshall"},
				{11000, 	"General"},
				{12500, 	"Professional"},
				{13000, 	"Professional Killer"},
				{14000, 	"Super Man"},
				{15000, 	"Super Woman"},
				{16000, 	"Robin"},
				{17000, 	"Batman"},
				{18000, 	"Thor"},
				{19000, 	"King"},
				{20000, 	"Joker"},
				{21000, 	"Master Of War"},
				{22000, 	"God Of War"}
};

//------------------------------------------------

public OnFilterScriptInit()
{
	return 1;
}

//------------------------------------------------

public OnFilterScriptExit()
{
	return 1;
}

//------------------------------------------------

public OnPlayerConnect(playerid)
{
    g_PlayerSignature[playerid][i_Textdraw][0] = CreatePlayerTextDraw(playerid, 320.000000, 325.000000, "You got killed by Gammix(-1)");
	PlayerTextDrawAlignment(playerid, g_PlayerSignature[playerid][i_Textdraw][0], 2);
	PlayerTextDrawBackgroundColor(playerid, g_PlayerSignature[playerid][i_Textdraw][0], 255);
	PlayerTextDrawFont(playerid, g_PlayerSignature[playerid][i_Textdraw][0], 1);
	PlayerTextDrawLetterSize(playerid, g_PlayerSignature[playerid][i_Textdraw][0], 0.170000, 1.000000);
	PlayerTextDrawColor(playerid, g_PlayerSignature[playerid][i_Textdraw][0], -1);
	PlayerTextDrawSetOutline(playerid, g_PlayerSignature[playerid][i_Textdraw][0], 0);
	PlayerTextDrawSetProportional(playerid, g_PlayerSignature[playerid][i_Textdraw][0], 1);
	PlayerTextDrawSetShadow(playerid, g_PlayerSignature[playerid][i_Textdraw][0], 1);
	PlayerTextDrawSetSelectable(playerid, g_PlayerSignature[playerid][i_Textdraw][0], 0);

	g_PlayerSignature[playerid][i_Textdraw][1] = CreatePlayerTextDraw(playerid, 320.000000, 343.000000, "box");
	PlayerTextDrawAlignment(playerid, g_PlayerSignature[playerid][i_Textdraw][1], 2);
	PlayerTextDrawBackgroundColor(playerid, g_PlayerSignature[playerid][i_Textdraw][1], 255);
	PlayerTextDrawFont(playerid, g_PlayerSignature[playerid][i_Textdraw][1], 1);
	PlayerTextDrawLetterSize(playerid, g_PlayerSignature[playerid][i_Textdraw][1], 0.000000, 5.199998);
	PlayerTextDrawColor(playerid, g_PlayerSignature[playerid][i_Textdraw][1], -1);
	PlayerTextDrawSetOutline(playerid, g_PlayerSignature[playerid][i_Textdraw][1], 0);
	PlayerTextDrawSetProportional(playerid, g_PlayerSignature[playerid][i_Textdraw][1], 1);
	PlayerTextDrawSetShadow(playerid, g_PlayerSignature[playerid][i_Textdraw][1], 1);
	PlayerTextDrawUseBox(playerid, g_PlayerSignature[playerid][i_Textdraw][1], 1);
	PlayerTextDrawBoxColor(playerid, g_PlayerSignature[playerid][i_Textdraw][1], 255);
	PlayerTextDrawTextSize(playerid, g_PlayerSignature[playerid][i_Textdraw][1], 7.000000, -151.000000);
	PlayerTextDrawSetSelectable(playerid, g_PlayerSignature[playerid][i_Textdraw][1], 0);

	g_PlayerSignature[playerid][i_Textdraw][2] = CreatePlayerTextDraw(playerid, 248.000000, 341.000000, "loadsc3:loadsc3");
	PlayerTextDrawAlignment(playerid, g_PlayerSignature[playerid][i_Textdraw][2], 2);
	PlayerTextDrawBackgroundColor(playerid, g_PlayerSignature[playerid][i_Textdraw][2], 255);
	PlayerTextDrawFont(playerid, g_PlayerSignature[playerid][i_Textdraw][2], 4);
	PlayerTextDrawLetterSize(playerid, g_PlayerSignature[playerid][i_Textdraw][2], 0.000000, 5.199998);
	PlayerTextDrawColor(playerid, g_PlayerSignature[playerid][i_Textdraw][2], -16776961);
	PlayerTextDrawSetOutline(playerid, g_PlayerSignature[playerid][i_Textdraw][2], 0);
	PlayerTextDrawSetProportional(playerid, g_PlayerSignature[playerid][i_Textdraw][2], 1);
	PlayerTextDrawSetShadow(playerid, g_PlayerSignature[playerid][i_Textdraw][2], 1);
	PlayerTextDrawUseBox(playerid, g_PlayerSignature[playerid][i_Textdraw][2], 1);
	PlayerTextDrawBoxColor(playerid, g_PlayerSignature[playerid][i_Textdraw][2], 255);
	PlayerTextDrawTextSize(playerid, g_PlayerSignature[playerid][i_Textdraw][2], 144.000000, 50.000000);
	PlayerTextDrawSetSelectable(playerid, g_PlayerSignature[playerid][i_Textdraw][2], 0);

	g_PlayerSignature[playerid][i_Textdraw][3] = CreatePlayerTextDraw(playerid, 249.000000, 342.000000, "LD_TATT:5gun");
	PlayerTextDrawAlignment(playerid, g_PlayerSignature[playerid][i_Textdraw][3], 2);
	PlayerTextDrawBackgroundColor(playerid, g_PlayerSignature[playerid][i_Textdraw][3], 255);
	PlayerTextDrawFont(playerid, g_PlayerSignature[playerid][i_Textdraw][3], 4);
	PlayerTextDrawLetterSize(playerid, g_PlayerSignature[playerid][i_Textdraw][3], 0.000000, 5.199998);
	PlayerTextDrawColor(playerid, g_PlayerSignature[playerid][i_Textdraw][3], 255);
	PlayerTextDrawSetOutline(playerid, g_PlayerSignature[playerid][i_Textdraw][3], 0);
	PlayerTextDrawSetProportional(playerid, g_PlayerSignature[playerid][i_Textdraw][3], 1);
	PlayerTextDrawSetShadow(playerid, g_PlayerSignature[playerid][i_Textdraw][3], 1);
	PlayerTextDrawUseBox(playerid, g_PlayerSignature[playerid][i_Textdraw][3], 1);
	PlayerTextDrawBoxColor(playerid, g_PlayerSignature[playerid][i_Textdraw][3], 255);
	PlayerTextDrawTextSize(playerid, g_PlayerSignature[playerid][i_Textdraw][3], 43.000000, 48.000000);
	PlayerTextDrawSetSelectable(playerid, g_PlayerSignature[playerid][i_Textdraw][3], 0);

	g_PlayerSignature[playerid][i_Textdraw][4] = CreatePlayerTextDraw(playerid, 294.000000, 344.000000, "You");
	PlayerTextDrawBackgroundColor(playerid, g_PlayerSignature[playerid][i_Textdraw][4], 255);
	PlayerTextDrawFont(playerid, g_PlayerSignature[playerid][i_Textdraw][4], 1);
	PlayerTextDrawLetterSize(playerid, g_PlayerSignature[playerid][i_Textdraw][4], 0.230000, 1.299999);
	PlayerTextDrawColor(playerid, g_PlayerSignature[playerid][i_Textdraw][4], -1);
	PlayerTextDrawSetOutline(playerid, g_PlayerSignature[playerid][i_Textdraw][4], 0);
	PlayerTextDrawSetProportional(playerid, g_PlayerSignature[playerid][i_Textdraw][4], 1);
	PlayerTextDrawSetShadow(playerid, g_PlayerSignature[playerid][i_Textdraw][4], 1);
	PlayerTextDrawSetSelectable(playerid, g_PlayerSignature[playerid][i_Textdraw][4], 0);

	g_PlayerSignature[playerid][i_Textdraw][5] = CreatePlayerTextDraw(playerid, 294.000000, 357.000000, "Moto:");
	PlayerTextDrawBackgroundColor(playerid, g_PlayerSignature[playerid][i_Textdraw][5], 255);
	PlayerTextDrawFont(playerid, g_PlayerSignature[playerid][i_Textdraw][5], 1);
	PlayerTextDrawLetterSize(playerid, g_PlayerSignature[playerid][i_Textdraw][5], 0.159999, 0.799998);
	PlayerTextDrawColor(playerid, g_PlayerSignature[playerid][i_Textdraw][5], -1);
	PlayerTextDrawSetOutline(playerid, g_PlayerSignature[playerid][i_Textdraw][5], 0);
	PlayerTextDrawSetProportional(playerid, g_PlayerSignature[playerid][i_Textdraw][5], 1);
	PlayerTextDrawSetShadow(playerid, g_PlayerSignature[playerid][i_Textdraw][5], 1);
	PlayerTextDrawSetSelectable(playerid, g_PlayerSignature[playerid][i_Textdraw][5], 0);

	g_PlayerSignature[playerid][i_Textdraw][6] = CreatePlayerTextDraw(playerid, 296.000000, 363.000000, "You is the best coder!");
	PlayerTextDrawBackgroundColor(playerid, g_PlayerSignature[playerid][i_Textdraw][6], 255);
	PlayerTextDrawFont(playerid, g_PlayerSignature[playerid][i_Textdraw][6], 1);
	PlayerTextDrawLetterSize(playerid, g_PlayerSignature[playerid][i_Textdraw][6], 0.189999, 0.999998);
	PlayerTextDrawColor(playerid, g_PlayerSignature[playerid][i_Textdraw][6], -1);
	PlayerTextDrawSetOutline(playerid, g_PlayerSignature[playerid][i_Textdraw][6], 0);
	PlayerTextDrawSetProportional(playerid, g_PlayerSignature[playerid][i_Textdraw][6], 1);
	PlayerTextDrawSetShadow(playerid, g_PlayerSignature[playerid][i_Textdraw][6], 1);
	PlayerTextDrawUseBox(playerid, g_PlayerSignature[playerid][i_Textdraw][6], 1);
	PlayerTextDrawBoxColor(playerid, g_PlayerSignature[playerid][i_Textdraw][6], 100);
	PlayerTextDrawTextSize(playerid, g_PlayerSignature[playerid][i_Textdraw][6], 388.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid, g_PlayerSignature[playerid][i_Textdraw][6], 0);

	g_PlayerSignature[playerid][i_Textdraw][7] = CreatePlayerTextDraw(playerid, 294.000000, 382.000000, "~y~~h~~h~Admin ~w~~h~I ~y~~h~~h~Expert~w~~h~(score 2451)");
	PlayerTextDrawBackgroundColor(playerid, g_PlayerSignature[playerid][i_Textdraw][7], 255);
	PlayerTextDrawFont(playerid, g_PlayerSignature[playerid][i_Textdraw][7], 1);
	PlayerTextDrawLetterSize(playerid, g_PlayerSignature[playerid][i_Textdraw][7], 0.159999, 0.799998);
	PlayerTextDrawColor(playerid, g_PlayerSignature[playerid][i_Textdraw][7], -1);
	PlayerTextDrawSetOutline(playerid, g_PlayerSignature[playerid][i_Textdraw][7], 0);
	PlayerTextDrawSetProportional(playerid, g_PlayerSignature[playerid][i_Textdraw][7], 1);
	PlayerTextDrawSetShadow(playerid, g_PlayerSignature[playerid][i_Textdraw][7], 1);
	PlayerTextDrawSetSelectable(playerid, g_PlayerSignature[playerid][i_Textdraw][7], 0);

	g_PlayerSignature[playerid][i_Textdraw][8] = CreatePlayerTextDraw(playerid, 250.000000, 343.000000, "LD_TATT:5gun");
	PlayerTextDrawAlignment(playerid, g_PlayerSignature[playerid][i_Textdraw][8], 2);
	PlayerTextDrawBackgroundColor(playerid, g_PlayerSignature[playerid][i_Textdraw][8], 255);
	PlayerTextDrawFont(playerid, g_PlayerSignature[playerid][i_Textdraw][8], 4);
	PlayerTextDrawLetterSize(playerid, g_PlayerSignature[playerid][i_Textdraw][8], 0.000000, 5.199998);
	PlayerTextDrawColor(playerid, g_PlayerSignature[playerid][i_Textdraw][8], -1);
	PlayerTextDrawSetOutline(playerid, g_PlayerSignature[playerid][i_Textdraw][8], 0);
	PlayerTextDrawSetProportional(playerid, g_PlayerSignature[playerid][i_Textdraw][8], 1);
	PlayerTextDrawSetShadow(playerid, g_PlayerSignature[playerid][i_Textdraw][8], 1);
	PlayerTextDrawUseBox(playerid, g_PlayerSignature[playerid][i_Textdraw][8], 1);
	PlayerTextDrawBoxColor(playerid, g_PlayerSignature[playerid][i_Textdraw][8], 255);
	PlayerTextDrawTextSize(playerid, g_PlayerSignature[playerid][i_Textdraw][8], 41.000000, 46.000000);
	PlayerTextDrawSetSelectable(playerid, g_PlayerSignature[playerid][i_Textdraw][8], 0);

    g_PlayerSignature[playerid][i_ExpireTimer] = -1;
    g_PlayerSignature[playerid][i_NameColor] = -1;
    g_PlayerSignature[playerid][i_BackgroundColor] = -1;
    g_PlayerSignature[playerid][i_AvatarColor] = -1;
    g_PlayerSignature[playerid][i_MotoColor] = -1;
    g_PlayerSignature[playerid][b_Toggled] = true;
    format(g_PlayerSignature[playerid][s_BackgroundSprite], 25, "loadsc3:loadsc3");
    format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:5gun");
    format(g_PlayerSignature[playerid][s_Moto], MAX_MOTO_SIZE, "You is the best coder!");
	return 1;
}

//------------------------------------------------

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

//------------------------------------------------

CalculateRankFromScore(score)
{
	if(score <= g_ScoreBasedRanks[0][i_Score])
	{
	    return 0;
	}
	else if(score >= g_ScoreBasedRanks[(sizeof(g_ScoreBasedRanks) - 1)][i_Score])
	{
	    return (sizeof(g_ScoreBasedRanks) - 1);
	}
	else
	{
		for(new i = 0, j = (sizeof(g_ScoreBasedRanks) - 1); i <= j; i++)
		{
			if(score < g_ScoreBasedRanks[i][i_Score])
			{
			    return (i - 1);
			}
		}
		return 0;
	}
}

//------------------------------------------------

ShowPlayerSignature(playerid, ofplayerid, expiretime = -1)
{
	PlayerTextDrawShow(playerid, g_PlayerSignature[playerid][i_Textdraw][1]);
	
	PlayerTextDrawSetString(playerid, g_PlayerSignature[playerid][i_Textdraw][2], g_PlayerSignature[ofplayerid][s_BackgroundSprite]);
	PlayerTextDrawColor(playerid, g_PlayerSignature[playerid][i_Textdraw][2], g_PlayerSignature[ofplayerid][i_BackgroundColor]);
	PlayerTextDrawShow(playerid, g_PlayerSignature[playerid][i_Textdraw][2]);

	PlayerTextDrawShow(playerid, g_PlayerSignature[playerid][i_Textdraw][3]);
	
	new
	    s_Name[MAX_PLAYER_NAME]
 	;
 	GetPlayerName(ofplayerid, s_Name, MAX_PLAYER_NAME);
	PlayerTextDrawSetString(playerid, g_PlayerSignature[playerid][i_Textdraw][4], s_Name);
	PlayerTextDrawColor(playerid, g_PlayerSignature[playerid][i_Textdraw][4], g_PlayerSignature[ofplayerid][i_NameColor]);
	PlayerTextDrawShow(playerid, g_PlayerSignature[playerid][i_Textdraw][4]);

	PlayerTextDrawShow(playerid, g_PlayerSignature[playerid][i_Textdraw][5]);
	
	PlayerTextDrawSetString(playerid, g_PlayerSignature[playerid][i_Textdraw][6], g_PlayerSignature[ofplayerid][s_Moto]);
	PlayerTextDrawColor(playerid, g_PlayerSignature[playerid][i_Textdraw][6], g_PlayerSignature[ofplayerid][i_MotoColor]);
	PlayerTextDrawShow(playerid, g_PlayerSignature[playerid][i_Textdraw][6]);

	new
		i_Rank = CalculateRankFromScore(GetPlayerScore(ofplayerid)),
		s_Str[100]
	;
	format(s_Str, sizeof(s_Str), "~y~~h~~h~%s ~w~~h~(~y~~h~~h~Rank: %i, Score: %i~w~~h~)", g_ScoreBasedRanks[i_Rank][s_RankName], i_Rank, GetPlayerScore(ofplayerid));
	PlayerTextDrawSetString(playerid, g_PlayerSignature[playerid][i_Textdraw][7], s_Str);
	PlayerTextDrawColor(playerid, g_PlayerSignature[playerid][i_Textdraw][7], COLOR_SIGNATURE_RANK);
	PlayerTextDrawShow(playerid, g_PlayerSignature[playerid][i_Textdraw][7]);
	
	PlayerTextDrawSetString(playerid, g_PlayerSignature[playerid][i_Textdraw][8], g_PlayerSignature[ofplayerid][s_AvatarSprite]);
	PlayerTextDrawColor(playerid, g_PlayerSignature[playerid][i_Textdraw][8], g_PlayerSignature[ofplayerid][i_AvatarColor]);
	PlayerTextDrawShow(playerid, g_PlayerSignature[playerid][i_Textdraw][8]);

	if(g_PlayerSignature[playerid][i_ExpireTimer] != -1)
	{
	    KillTimer(g_PlayerSignature[playerid][i_ExpireTimer]);
	    g_PlayerSignature[playerid][i_ExpireTimer] = -1;
	}
	if(expiretime != -1)
 	{
	 	g_PlayerSignature[playerid][i_ExpireTimer] = SetTimerEx("OnPlayerSignatureExpire", expiretime, false, "i", playerid);
	}
	
	return true;
}

//------------------------------------------------

HidePlayerSignature(playerid)
{
	return OnPlayerSignatureExpire(playerid);
}

//------------------------------------------------

forward OnPlayerSignatureExpire(playerid);
public OnPlayerSignatureExpire(playerid)
{
	for(new i; i < 9; i++)
	{
		PlayerTextDrawHide(playerid, g_PlayerSignature[playerid][i_Textdraw][i]);
	}
	
	return 1;
}

//------------------------------------------------

RGB(red, green, blue, alpha)
{
	return (red * 16777216) + (green * 65536) + (blue * 256) + alpha;
}

//------------------------------------------------

HexToInt(string[])
{
  	if(! string[0])
	{
		return 0;
  	}

  	new cur = 1;
  	new res = 0;
  	for(new i = strlen(string); i > 0; i--)
  	{
    	if(string[i-1] < 58)
		{
			res = res + cur * (string[i-1] - 48);
		}
		else
		{
			res = res + cur * (string[i-1] - 65 + 10);
    	}
		cur = cur * 16;
	}
	return res;
}

//------------------------------------------------

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_SIGN)
	{
	    if(! response)
	    {
	        HidePlayerSignature(playerid);
	    }
	    else
	    {
	        if(! g_PlayerSignature[playerid][b_Toggled])
         	{
         	    g_PlayerSignature[playerid][b_Toggled] = true;
	            SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: You have enabled your signature.");

	            cmd_mysignature(playerid);
         	}
         	else
         	{
			 	switch(listitem)
	        	{
   		         	case 0:
		            {
	                    g_PlayerSignature[playerid][b_Toggled] = false;
	                    SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: You have disabled your signature.");
	                    
	                    cmd_mysignature(playerid);
	                }
   		         	case 1:
		            {
	                    ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT, DIALOG_STYLE_LIST, "Edit signature:", "Edit Background\nEdit Avatar\nEdit Moto", "Select", "Back");
	                }
   		         	case 2:
		            {
	                    ShowPlayerDialog(playerid, DIALOG_SIGN_RESTORE, DIALOG_STYLE_LIST, "Restore default signature:", "Are you sure you want to reset your signature settings?\nhis will erase the current setup and replace it with the deafult one!", "Yes", "No");
	                }
	            }
	        }
	    }
	}

	if(dialogid == DIALOG_SIGN_EDIT)
	{
	    if(! response)
	    {
			cmd_mysignature(playerid);
	    }
	    else
	    {
	        switch(listitem)
	        {
   		    	case 0:
		        {
		        	ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_BG, DIALOG_STYLE_LIST, "Edit signature - Background:", "Change Color\nChange Sprite\nChange Transparency", "Select", "Back");
		        }
   		    	case 1:
		        {
		        	ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_PIC, DIALOG_STYLE_LIST, "Edit signature - Avatar:", "Change Color\nChange Sprite\nChange Transparency", "Select", "Back");
		        }
   		    	case 2:
		        {
		        	ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_MOTO, DIALOG_STYLE_LIST, "Edit signature - Text:", "Change Color\nChange Text\nChange Transparency", "Select", "Back");
		        }
			}
	    }
	}

	// edit background

	if(dialogid == DIALOG_SIGN_EDIT_BG)
	{
	    if(! response)
	    {
			ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT, DIALOG_STYLE_LIST, "Edit signature:", "Edit Background\nEdit Avatar\nEdit Moto", "Select", "Back");
	    }
	    else
	    {
	        switch(listitem)
	        {
   		    	case 0:
		        {
		        	ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_BG_COL, DIALOG_STYLE_LIST, "Edit signature - Background - Color:", "Use custom hexadecimal\nPre-defined colors", "Select", "Back");
		        }
   		    	case 1:
		        {
		        	ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_BG_IMG, DIALOG_STYLE_LIST, "Edit signature - Background - Sprite:", "load0uk:load0uk\nloadsc0:loadsc0\nloadsc1:loadsc1\nloadsc2:loadsc2\nloadsc3:loadsc3\nloadsc4:loadsc4\nloadsc5:loadsc5\nloadsc6:loadsc6\nloadsc7:loadsc7\nloadsc8:loadsc8\nloadsc9:loadsc9\nloadsc10:loadsc10\nloadsc11:loadsc11\nloadsc12:loadsc12\nloadsc13:loadsc13\nloadsc14:loadsc14\noutro:outro\nsplash1:splash1\nsplash2:splash2", "Select", "Back");
		        }
   		    	case 2:
		        {
		        	ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_BG_OPC, DIALOG_STYLE_INPUT, "Edit signature - Background - Transparency:", "Type in the opacity level to set\nNOTE: You can have maximum level of 255", "Select", "Back");
		        }
			}
	    }
	}

	if(dialogid == DIALOG_SIGN_EDIT_BG_COL)
	{
	    if(! response)
	    {
			ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_BG, DIALOG_STYLE_LIST, "Edit signature - Background:", "Change Color\nChange Sprite\nChange Transparency", "Select", "Back");
	    }
	    else
	    {
	        switch(listitem)
	        {
   		    	case 0:
		        {
		        	ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_BG_COL_0, DIALOG_STYLE_INPUT, "Edit signature - Background - Color - Custom:", "Insert a hexdecimal color code to set your background color:", "Select", "Back");
		        }
   		    	case 1:
		        {
		            new
		                s_Dialog[500]
					;

					strcat(s_Dialog, "{FFFFFF}White\n");
			    	strcat(s_Dialog, "{000000}Black\n");
			    	strcat(s_Dialog, "{808080}Grey\n");
			    	strcat(s_Dialog, "{008080}Teal\n");
			    	strcat(s_Dialog, "{003366}Navy blue\n");
			    	strcat(s_Dialog, "{3366CC}Sky blue\n");
			    	strcat(s_Dialog, "{000099}Dark blue\n");
			    	strcat(s_Dialog, "{3399FF}Light blue\n");
			    	strcat(s_Dialog, "{6600CC}Dark purple\n");
			    	strcat(s_Dialog, "{6600FF}Purple\n");
			    	strcat(s_Dialog, "{6666FF}Light purple\n");
			    	strcat(s_Dialog, "{00FFFF}Cyan\n");
			    	strcat(s_Dialog, "{00FFCC}Aqua\n");
			    	strcat(s_Dialog, "{00CC99}Poision green\n");
			    	strcat(s_Dialog, "{006666}Lawn green\n");
			    	strcat(s_Dialog, "{00CC00}Green\n");
			    	strcat(s_Dialog, "{CC99FF}Pink\n");
			    	strcat(s_Dialog, "{FF99FF}Hot pink\n");
			    	strcat(s_Dialog, "{FFFF99}Light yellow\n");
			    	strcat(s_Dialog, "{FFFF66}Yellow\n");
			    	strcat(s_Dialog, "{FF9933}Orange\n");
			    	strcat(s_Dialog, "{660033}Magenta\n");
			    	strcat(s_Dialog, "{800000}Marone\n");
			    	strcat(s_Dialog, "{FF0000}Red\n");
			    	strcat(s_Dialog, "{CC0000}Dark red\n");
			    	strcat(s_Dialog, "{999966}Khaki\n");
			    	strcat(s_Dialog, "{993333}Coral\n");
			    	strcat(s_Dialog, "{CCFF99}Lime\n");
			    	strcat(s_Dialog, "{663300}Brown\n");
			    	strcat(s_Dialog, "{A9C4E4}SA-MP Blue");

		        	ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_BG_COL_1, DIALOG_STYLE_LIST, "Edit signature - Background - Color - List:", s_Dialog, "Select", "Back");
		        }
			}
	    }
	}

	if(dialogid == DIALOG_SIGN_EDIT_BG_COL_0)
	{
	    if(! response)
	    {
			ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_BG_COL, DIALOG_STYLE_LIST, "Edit signature - Background - Color:", "Use custom hexadecimal\nPre-defined colors", "Select", "Back");
	    }
	    else
	    {
	        new red[3], green[3], blue[3], alpha[3];

           	if(inputtext[0] == '0' && inputtext[1] == 'x') // He's using 0xFFFFFF format
            {
            	if(strlen(inputtext) != 8 && strlen(inputtext) != 10)
				{
					return ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_BG_COL_0, DIALOG_STYLE_INPUT, "Edit signature - Background - Color - Custom:", "Insert a hexdecimal color code to set your background color:\nERROR: Invalid hexdecimal color!", "Select", "Back");
                }
				else
                {
	             	format(red, sizeof(red), "%c%c", inputtext[2], inputtext[3]);
	                format(green, sizeof(green), "%c%c", inputtext[4], inputtext[5]);
	                format(blue, sizeof(blue), "%c%c", inputtext[6], inputtext[7]);
	               	if(inputtext[8] != '\0')
                 	{
				 		format(alpha, sizeof(alpha), "%c%c", inputtext[8], inputtext[9]);
					}
					else
					{
					    alpha = "FF";
					}
                }
     		}
			else if(inputtext[0] == '#') // He's using #FFFFFF format
            {
            	if(strlen(inputtext) != 7 && strlen(inputtext) != 9)
				{
					return ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_BG_COL_0, DIALOG_STYLE_INPUT, "Edit signature - Background - Color - Custom:", "Insert a hexdecimal color code to set your background color:\nERROR: Invalid hexdecimal color!", "Select", "Back");
                }
                else
                {
     				format(red, sizeof(red), "%c%c", inputtext[1], inputtext[2]);
	                format(green, sizeof(green), "%c%c", inputtext[3], inputtext[4]);
	                format(blue, sizeof(blue), "%c%c", inputtext[5], inputtext[6]);
	                if(inputtext[7] != '\0')
                 	{
					 	format(alpha, sizeof(alpha), "%c%c", inputtext[7], inputtext[8]);
					}
					else
					{
					    alpha = "FF";
					}
                }
  			}
		  	else // He's using FFFFFF format
            {
            	if(strlen(inputtext) != 6 && strlen(inputtext) != 8)
				{
					return ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_BG_COL_0, DIALOG_STYLE_INPUT, "Edit signature - Background - Color - Custom:", "Insert a hexdecimal color code to set your background color:\nERROR: Invalid hexdecimal color!", "Select", "Back");
                }
                else
                {
	            	format(red, sizeof(red), "%c%c", inputtext[0], inputtext[1]);
	                format(green, sizeof(green), "%c%c", inputtext[2], inputtext[3]);
	                format(blue, sizeof(blue), "%c%c", inputtext[4], inputtext[5]);
                 	if(inputtext[6] != '\0')
	                {
						format(alpha, sizeof(alpha), "%c%c", inputtext[6], inputtext[7]);
					}
					else
					{
					    alpha = "FF";
					}
                }
			}

			g_PlayerSignature[playerid][i_BackgroundColor] = RGB(HexToInt(red), HexToInt(green), HexToInt(blue), HexToInt(alpha));

			SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: You have changed your signature's background sprite color.");

			ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_BG_COL, DIALOG_STYLE_LIST, "Edit signature - Background - Color:", "Use custom hexadecimal\nPre-defined colors", "Select", "Back");

			ShowPlayerSignature(playerid, playerid);
		}
	}

	if(dialogid == DIALOG_SIGN_EDIT_BG_COL_1)
	{
	    if(! response)
	    {
			ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_BG_COL, DIALOG_STYLE_LIST, "Edit signature - Background - Color:", "Use custom hexadecimal\nPre-defined colors", "Select", "Back");
	    }
	    else
	    {
			SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: You have changed your signature's background sprite color.");

			switch(listitem)
			{
			    case 0: g_PlayerSignature[playerid][i_BackgroundColor] = 0xFFFFFFFF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"WHITE\".");
			    case 1: g_PlayerSignature[playerid][i_BackgroundColor] = 0x000000FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"BLACK\".");
			    case 2: g_PlayerSignature[playerid][i_BackgroundColor] = 0x808080FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"GREY\".");
			    case 3: g_PlayerSignature[playerid][i_BackgroundColor] = 0x008080FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"TEAL\".");
			    case 4: g_PlayerSignature[playerid][i_BackgroundColor] = 0x003366FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"NAVY BLUE\".");
			    case 5: g_PlayerSignature[playerid][i_BackgroundColor] = 0x3366CCFF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"SKY BLUE\".");
			    case 6: g_PlayerSignature[playerid][i_BackgroundColor] = 0x000099FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"DARK BLUE\".");
			    case 7: g_PlayerSignature[playerid][i_BackgroundColor] = 0x3399FFFF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"LIGHT BLUE\".");
			    case 8: g_PlayerSignature[playerid][i_BackgroundColor] = 0x6600CCFF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"DARK PURPLE\".");
			    case 9: g_PlayerSignature[playerid][i_BackgroundColor] = 0x6600FFFF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"PURPLE\".");
			    case 10: g_PlayerSignature[playerid][i_BackgroundColor] = 0x6666FFFF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"LIGHT PURPLE\".");
			    case 11: g_PlayerSignature[playerid][i_BackgroundColor] = 0x00FFFFFF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"CYAN\".");
			    case 12: g_PlayerSignature[playerid][i_BackgroundColor] = 0x00FFCCFF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"AQUA\".");
			    case 13: g_PlayerSignature[playerid][i_BackgroundColor] = 0x00CC99FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"POISION GREEN\".");
			    case 14: g_PlayerSignature[playerid][i_BackgroundColor] = 0x006666FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"LAWN GREEN\".");
			    case 15: g_PlayerSignature[playerid][i_BackgroundColor] = 0x00CC00FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"GREEN\".");
			    case 16: g_PlayerSignature[playerid][i_BackgroundColor] = 0xCC99FFFF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"PINK\".");
			    case 17: g_PlayerSignature[playerid][i_BackgroundColor] = 0xFF99FFFF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"HOT PINK\".");
			    case 18: g_PlayerSignature[playerid][i_BackgroundColor] = 0xFFFF99FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"LIGHT YELLOW\".");
			    case 19: g_PlayerSignature[playerid][i_BackgroundColor] = 0xFFFF66FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"YELLOW\".");
			    case 20: g_PlayerSignature[playerid][i_BackgroundColor] = 0xFF9933FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"ORANGE\".");
			    case 21: g_PlayerSignature[playerid][i_BackgroundColor] = 0x660033FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"MAGENTA\".");
			    case 22: g_PlayerSignature[playerid][i_BackgroundColor] = 0x800000FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"MARONE\".");
			    case 23: g_PlayerSignature[playerid][i_BackgroundColor] = 0xFF0000FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"RED\".");
			    case 24: g_PlayerSignature[playerid][i_BackgroundColor] = 0xCC0000FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"DARK RED\".");
			    case 25: g_PlayerSignature[playerid][i_BackgroundColor] = 0x999966FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"KHAKI\".");
			    case 26: g_PlayerSignature[playerid][i_BackgroundColor] = 0x993333FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"CORAL\".");
			    case 27: g_PlayerSignature[playerid][i_BackgroundColor] = 0xCCFF99FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"LIME\".");
			    case 28: g_PlayerSignature[playerid][i_BackgroundColor] = 0x663300FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"BROWN\".");
			    case 29: g_PlayerSignature[playerid][i_BackgroundColor] = 0xA9C4E4FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"SAMP BLUE\".");
			}

			ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_BG_COL, DIALOG_STYLE_LIST, "Edit signature - Background - Color:", "Use custom hexadecimal\nPre-defined colors", "Select", "Back");

			ShowPlayerSignature(playerid, playerid);
		}
	}

	if(dialogid == DIALOG_SIGN_EDIT_BG_IMG)
	{
	    if(! response)
	    {
			ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_BG, DIALOG_STYLE_LIST, "Edit signature - Background:", "Change Color\nChange Sprite\nChange Transparency", "Select", "Back");
	    }
	    else
	    {
			SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: You have changed your signature's background sprite.");
			switch(listitem)
			{
			    case 0: format(g_PlayerSignature[playerid][s_BackgroundSprite], 25, "load0uk:load0uk"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"load0uk:load0uk\".");
				case 1: format(g_PlayerSignature[playerid][s_BackgroundSprite], 25, "loadsc0:loadsc0"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"loadsc0:loadsc0\".");
				case 2: format(g_PlayerSignature[playerid][s_BackgroundSprite], 25, "loadsc1:loadsc1"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"loadsc1:loadsc1\".");
				case 3: format(g_PlayerSignature[playerid][s_BackgroundSprite], 25, "loadsc2:loadsc2"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"loadsc2:loadsc2\".");
				case 4: format(g_PlayerSignature[playerid][s_BackgroundSprite], 25, "loadsc3:loadsc3"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"loadsc3:loadsc3\".");
				case 5: format(g_PlayerSignature[playerid][s_BackgroundSprite], 25, "loadsc4:loadsc4"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"loadsc4:loadsc4\".");
				case 6: format(g_PlayerSignature[playerid][s_BackgroundSprite], 25, "loadsc5:loadsc5"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"loadsc5:loadsc5\".");
				case 7: format(g_PlayerSignature[playerid][s_BackgroundSprite], 25, "loadsc6:loadsc6"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"loadsc6:loadsc6\".");
				case 8: format(g_PlayerSignature[playerid][s_BackgroundSprite], 25, "loadsc7:loadsc7"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"loadsc7:loadsc7\".");
				case 9: format(g_PlayerSignature[playerid][s_BackgroundSprite], 25, "loadsc8:loadsc8"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"loadsc8:loadsc8\".");
				case 10: format(g_PlayerSignature[playerid][s_BackgroundSprite], 25, "loadsc9:loadsc9"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"loadsc9:loadsc9\".");
				case 11: format(g_PlayerSignature[playerid][s_BackgroundSprite], 25, "loadsc10:loadsc10"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"loadsc10:loadsc10\".");
				case 12: format(g_PlayerSignature[playerid][s_BackgroundSprite], 25, "loadsc11:loadsc11"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"loadsc11:loadsc11\".");
				case 13: format(g_PlayerSignature[playerid][s_BackgroundSprite], 25, "loadsc12:loadsc12"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"loadsc12:loadsc12\".");
				case 14: format(g_PlayerSignature[playerid][s_BackgroundSprite], 25, "loadsc13:loadsc13"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"loadsc13:loadsc13\".");
				case 15: format(g_PlayerSignature[playerid][s_BackgroundSprite], 25, "loadsc14:loadsc14"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"loadsc14:loadsc14\".");
				case 16: format(g_PlayerSignature[playerid][s_BackgroundSprite], 25, "outro:outro"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"outro:outro\".");
				case 17: format(g_PlayerSignature[playerid][s_BackgroundSprite], 25, "splash1:splash1"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"splash1:splash1\".");
				case 18: format(g_PlayerSignature[playerid][s_BackgroundSprite], 25, "splash2:splash2"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"splash2:splash2\".");
			}

			ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_BG, DIALOG_STYLE_LIST, "Edit signature - Background:", "Change Color\nChange Sprite\nChange Transparency", "Select", "Back");

			ShowPlayerSignature(playerid, playerid);
	    }
	}

	if(dialogid == DIALOG_SIGN_EDIT_BG_OPC)
	{
	    if(! response)
	    {
			ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_BG, DIALOG_STYLE_LIST, "Edit signature - Background:", "Change Color\nChange Sprite\nChange Transparency", "Select", "Back");
	    }
	    else
	    {
	        if( ! inputtext[0] ||
				strval(inputtext) < 10 ||
				strval(inputtext) > 255)
			{
			    return ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_BG_OPC, DIALOG_STYLE_INPUT, "Edit signature - Background - Transparency:", "Type in the opacity level to set\nNOTE: You can have maximum level of 255\nERROR: Invalid opacity value!", "Select", "Back");
			}

            g_PlayerSignature[playerid][i_BackgroundColor] = ((g_PlayerSignature[playerid][i_BackgroundColor] & ~0xFF) | (clamp(strval(inputtext), 0x00, 0xFF)));

			SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: You have changed your signature's background's opacity/transparency.");

            ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_BG, DIALOG_STYLE_LIST, "Edit signature - Background:", "Change Color\nChange Sprite\nChange Transparency", "Select", "Back");

			ShowPlayerSignature(playerid, playerid);
		}
	}
	
	// edit avatar
	
	if(dialogid == DIALOG_SIGN_EDIT_PIC)
	{
	    if(! response)
	    {
			ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT, DIALOG_STYLE_LIST, "Edit signature:", "Edit Background\nEdit Avatar\nEdit Moto", "Select", "Back");
	    }
	    else
	    {
	        switch(listitem)
	        {
   		    	case 0:
		        {
		        	ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_PIC_COL, DIALOG_STYLE_LIST, "Edit signature - Avatar - Color:", "Use custom hexadecimal\nPre-defined colors", "Select", "Back");
		        }
   		    	case 1:
		        {
		            new
					    s_Dialog[1000]
					;

		            strcat(s_Dialog, "LD_TATT:4rip\n");
				 	strcat(s_Dialog, "LD_TATT:4spider\n");
					strcat(s_Dialog, "LD_TATT:4weed\n");
					strcat(s_Dialog, "LD_TATT:5cross\n");
					strcat(s_Dialog, "LD_TATT:5cross2\n");
					strcat(s_Dialog, "LD_TATT:5cross3\n");
					strcat(s_Dialog, "LD_TATT:5gun\n");
					strcat(s_Dialog, "LD_TATT:6africa\n");
					strcat(s_Dialog, "LD_TATT:6aztec\n");
					strcat(s_Dialog, "LD_TATT:6clown\n");
					strcat(s_Dialog, "LD_TATT:6crown\n");
					strcat(s_Dialog, "LD_TATT:7cross\n");
					strcat(s_Dialog, "LD_TATT:7cross2\n");
					strcat(s_Dialog, "LD_TATT:7cross3\n");
					strcat(s_Dialog, "LD_TATT:7mary\n");
					strcat(s_Dialog, "LD_TATT:8gun\n");
					strcat(s_Dialog, "LD_TATT:8poker\n");
					strcat(s_Dialog, "LD_TATT:8sa\n");
					strcat(s_Dialog, "LD_TATT:8sa2\n");
					strcat(s_Dialog, "LD_TATT:8sa3\n");
					strcat(s_Dialog, "LD_TATT:8santos\n");
					strcat(s_Dialog, "LD_TATT:8westsd\n");
					strcat(s_Dialog, "LD_TATT:9bullt\n");
					strcat(s_Dialog, "LD_TATT:9crown\n");
					strcat(s_Dialog, "LD_TATT:9gun\n");
					strcat(s_Dialog, "LD_TATT:9gun2\n");
					strcat(s_Dialog, "LD_TATT:9homby\n");
					strcat(s_Dialog, "LD_TATT:9rasta\n");
					strcat(s_Dialog, "LD_TATT:10ls\n");
					strcat(s_Dialog, "LD_TATT:10ls2\n");
					strcat(s_Dialog, "LD_TATT:10ls3\n");
					strcat(s_Dialog, "LD_TATT:10ls4\n");
					strcat(s_Dialog, "LD_TATT:10ls5\n");
					strcat(s_Dialog, "LD_TATT:10og\n");
					strcat(s_Dialog, "LD_TATT:10weed\n");
					strcat(s_Dialog, "LD_TATT:11dice\n");
					strcat(s_Dialog, "LD_TATT:11dice2\n");
					strcat(s_Dialog, "LD_TATT:11ggift\n");
					strcat(s_Dialog, "LD_TATT:11grov2\n");
					strcat(s_Dialog, "LD_TATT:11grov3\n");
					strcat(s_Dialog, "LD_TATT:11grove\n");
					strcat(s_Dialog, "LD_TATT:11jail\n");
					strcat(s_Dialog, "LD_TATT:12angel\n");
					strcat(s_Dialog, "LD_TATT:12bndit\n");
					strcat(s_Dialog, "LD_TATT:12cross\n");
					strcat(s_Dialog, "LD_TATT:12dager\n");
					strcat(s_Dialog, "LD_TATT:12maybr\n");
					strcat(s_Dialog, "LD_TATT:12myfac");

					ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_PIC_IMG, DIALOG_STYLE_LIST, "Edit signature - Avatar - Sprite:", s_Dialog, "Select", "Back");
  				}
   		    	case 2:
		        {
		        	ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_PIC_OPC, DIALOG_STYLE_INPUT, "Edit signature - Avatar - Transparency:", "Type in the opacity level to set\nNOTE: You can have maximum level of 255", "Select", "Back");
		        }
			}
	    }
	}

	if(dialogid == DIALOG_SIGN_EDIT_PIC_COL)
	{
	    if(! response)
	    {
			ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_PIC, DIALOG_STYLE_LIST, "Edit signature - Avatar:", "Change Color\nChange Sprite\nChange Transparency", "Select", "Back");
	    }
	    else
	    {
	        switch(listitem)
	        {
   		    	case 0:
		        {
		        	ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_PIC_COL_0, DIALOG_STYLE_INPUT, "Edit signature - Avatar - Color - Custom:", "Insert a hexdecimal color code to set your avatar color:", "Select", "Back");
		        }
   		    	case 1:
		        {
		            new
		                s_Dialog[700]
					;

					strcat(s_Dialog, "{FFFFFF}White\n");
			    	strcat(s_Dialog, "{000000}Black\n");
			    	strcat(s_Dialog, "{808080}Grey\n");
			    	strcat(s_Dialog, "{008080}Teal\n");
			    	strcat(s_Dialog, "{003366}Navy blue\n");
			    	strcat(s_Dialog, "{3366CC}Sky blue\n");
			    	strcat(s_Dialog, "{000099}Dark blue\n");
			    	strcat(s_Dialog, "{3399FF}Light blue\n");
			    	strcat(s_Dialog, "{6600CC}Dark purple\n");
			    	strcat(s_Dialog, "{6600FF}Purple\n");
			    	strcat(s_Dialog, "{6666FF}Light purple\n");
			    	strcat(s_Dialog, "{00FFFF}Cyan\n");
			    	strcat(s_Dialog, "{00FFCC}Aqua\n");
			    	strcat(s_Dialog, "{00CC99}Poision green\n");
			    	strcat(s_Dialog, "{006666}Lawn green\n");
			    	strcat(s_Dialog, "{00CC00}Green\n");
			    	strcat(s_Dialog, "{CC99FF}Pink\n");
			    	strcat(s_Dialog, "{FF99FF}Hot pink\n");
			    	strcat(s_Dialog, "{FFFF99}Light yellow\n");
			    	strcat(s_Dialog, "{FFFF66}Yellow\n");
			    	strcat(s_Dialog, "{FF9933}Orange\n");
			    	strcat(s_Dialog, "{660033}Magenta\n");
			    	strcat(s_Dialog, "{800000}Marone\n");
			    	strcat(s_Dialog, "{FF0000}Red\n");
			    	strcat(s_Dialog, "{CC0000}Dark red\n");
			    	strcat(s_Dialog, "{999966}Khaki\n");
			    	strcat(s_Dialog, "{993333}Coral\n");
			    	strcat(s_Dialog, "{CCFF99}Lime\n");
			    	strcat(s_Dialog, "{663300}Brown\n");
			    	strcat(s_Dialog, "{A9C4E4}SA-MP Blue");

		        	ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_PIC_COL_1, DIALOG_STYLE_LIST, "Edit signature - Avatar - Color - List:", s_Dialog, "Select", "Back");
		        }
			}
	    }
	}

	if(dialogid == DIALOG_SIGN_EDIT_PIC_COL_0)
	{
	    if(! response)
	    {
			ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_PIC_COL, DIALOG_STYLE_LIST, "Edit signature - Avatar - Color:", "Use custom hexadecimal\nPre-defined colors", "Select", "Back");
	    }
	    else
	    {
	        new red[3], green[3], blue[3], alpha[3];

           	if(inputtext[0] == '0' && inputtext[1] == 'x') // He's using 0xFFFFFF format
            {
            	if(strlen(inputtext) != 8 && strlen(inputtext) != 10)
				{
					return ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_PIC_COL_0, DIALOG_STYLE_INPUT, "Edit signature - Avatar - Color - Custom:", "Insert a hexdecimal color code to set your avatar color:\nERROR: Invalid hexdecimal color!", "Select", "Back");
                }
				else
                {
	             	format(red, sizeof(red), "%c%c", inputtext[2], inputtext[3]);
	                format(green, sizeof(green), "%c%c", inputtext[4], inputtext[5]);
	                format(blue, sizeof(blue), "%c%c", inputtext[6], inputtext[7]);
	               	if(inputtext[8] != '\0')
                 	{
				 		format(alpha, sizeof(alpha), "%c%c", inputtext[8], inputtext[9]);
					}
					else
					{
					    alpha = "FF";
					}
                }
     		}
			else if(inputtext[0] == '#') // He's using #FFFFFF format
            {
            	if(strlen(inputtext) != 7 && strlen(inputtext) != 9)
				{
					return ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_PIC_COL_0, DIALOG_STYLE_INPUT, "Edit signature - Avatar - Color - Custom:", "Insert a hexdecimal color code to set your avatar color:\nERROR: Invalid hexdecimal color!", "Select", "Back");
                }
                else
                {
     				format(red, sizeof(red), "%c%c", inputtext[1], inputtext[2]);
	                format(green, sizeof(green), "%c%c", inputtext[3], inputtext[4]);
	                format(blue, sizeof(blue), "%c%c", inputtext[5], inputtext[6]);
	                if(inputtext[7] != '\0')
                 	{
					 	format(alpha, sizeof(alpha), "%c%c", inputtext[7], inputtext[8]);
					}
					else
					{
					    alpha = "FF";
					}
                }
  			}
		  	else // He's using FFFFFF format
            {
            	if(strlen(inputtext) != 6 && strlen(inputtext) != 8)
				{
					return ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_PIC_COL_0, DIALOG_STYLE_INPUT, "Edit signature - Avatar - Color - Custom:", "Insert a hexdecimal color code to set your avatar color:\nERROR: Invalid hexdecimal color!", "Select", "Back");
                }
                else
                {
	            	format(red, sizeof(red), "%c%c", inputtext[0], inputtext[1]);
	                format(green, sizeof(green), "%c%c", inputtext[2], inputtext[3]);
	                format(blue, sizeof(blue), "%c%c", inputtext[4], inputtext[5]);
                 	if(inputtext[6] != '\0')
	                {
						format(alpha, sizeof(alpha), "%c%c", inputtext[6], inputtext[7]);
					}
					else
					{
					    alpha = "FF";
					}
                }
			}

			g_PlayerSignature[playerid][i_AvatarColor] = RGB(HexToInt(red), HexToInt(green), HexToInt(blue), HexToInt(alpha));

			SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: You have changed your signature's avatar sprite color.");

			ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_PIC_COL, DIALOG_STYLE_LIST, "Edit signature - Avatar - Color:", "Use custom hexadecimal\nPre-defined colors", "Select", "Back");

			ShowPlayerSignature(playerid, playerid);
		}
	}

	if(dialogid == DIALOG_SIGN_EDIT_PIC_COL_1)
	{
	    if(! response)
	    {
			ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_PIC_COL, DIALOG_STYLE_LIST, "Edit signature - Avatar - Color:", "Use custom hexadecimal\nPre-defined colors", "Select", "Back");
	    }
	    else
	    {
			SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: You have changed your signature's avatar sprite color.");

			switch(listitem)
			{
			    case 0: g_PlayerSignature[playerid][i_AvatarColor] = 0xFFFFFFFF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"WHITE\".");
			    case 1: g_PlayerSignature[playerid][i_AvatarColor] = 0x000000FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"BLACK\".");
			    case 2: g_PlayerSignature[playerid][i_AvatarColor] = 0x808080FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"GREY\".");
			    case 3: g_PlayerSignature[playerid][i_AvatarColor] = 0x008080FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"TEAL\".");
			    case 4: g_PlayerSignature[playerid][i_AvatarColor] = 0x003366FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"NAVY BLUE\".");
			    case 5: g_PlayerSignature[playerid][i_AvatarColor] = 0x3366CCFF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"SKY BLUE\".");
			    case 6: g_PlayerSignature[playerid][i_AvatarColor] = 0x000099FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"DARK BLUE\".");
			    case 7: g_PlayerSignature[playerid][i_AvatarColor] = 0x3399FFFF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"LIGHT BLUE\".");
			    case 8: g_PlayerSignature[playerid][i_AvatarColor] = 0x6600CCFF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"DARK PURPLE\".");
			    case 9: g_PlayerSignature[playerid][i_AvatarColor] = 0x6600FFFF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"PURPLE\".");
			    case 10: g_PlayerSignature[playerid][i_AvatarColor] = 0x6666FFFF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"LIGHT PURPLE\".");
			    case 11: g_PlayerSignature[playerid][i_AvatarColor] = 0x00FFFFFF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"CYAN\".");
			    case 12: g_PlayerSignature[playerid][i_AvatarColor] = 0x00FFCCFF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"AQUA\".");
			    case 13: g_PlayerSignature[playerid][i_AvatarColor] = 0x00CC99FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"POISION GREEN\".");
			    case 14: g_PlayerSignature[playerid][i_AvatarColor] = 0x006666FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"LAWN GREEN\".");
			    case 15: g_PlayerSignature[playerid][i_AvatarColor] = 0x00CC00FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"GREEN\".");
			    case 16: g_PlayerSignature[playerid][i_AvatarColor] = 0xCC99FFFF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"PINK\".");
			    case 17: g_PlayerSignature[playerid][i_AvatarColor] = 0xFF99FFFF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"HOT PINK\".");
			    case 18: g_PlayerSignature[playerid][i_AvatarColor] = 0xFFFF99FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"LIGHT YELLOW\".");
			    case 19: g_PlayerSignature[playerid][i_AvatarColor] = 0xFFFF66FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"YELLOW\".");
			    case 20: g_PlayerSignature[playerid][i_AvatarColor] = 0xFF9933FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"ORANGE\".");
			    case 21: g_PlayerSignature[playerid][i_AvatarColor] = 0x660033FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"MAGENTA\".");
			    case 22: g_PlayerSignature[playerid][i_AvatarColor] = 0x800000FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"MARONE\".");
			    case 23: g_PlayerSignature[playerid][i_AvatarColor] = 0xFF0000FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"RED\".");
			    case 24: g_PlayerSignature[playerid][i_AvatarColor] = 0xCC0000FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"DARK RED\".");
			    case 25: g_PlayerSignature[playerid][i_AvatarColor] = 0x999966FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"KHAKI\".");
			    case 26: g_PlayerSignature[playerid][i_AvatarColor] = 0x993333FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"CORAL\".");
			    case 27: g_PlayerSignature[playerid][i_AvatarColor] = 0xCCFF99FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"LIME\".");
			    case 28: g_PlayerSignature[playerid][i_AvatarColor] = 0x663300FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"BROWN\".");
			    case 29: g_PlayerSignature[playerid][i_AvatarColor] = 0xA9C4E4FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"SAMP BLUE\".");
			}

			ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_PIC_COL, DIALOG_STYLE_LIST, "Edit signature - Avatar - Color:", "Use custom hexadecimal\nPre-defined colors", "Select", "Back");

			ShowPlayerSignature(playerid, playerid);
		}
	}

	if(dialogid == DIALOG_SIGN_EDIT_PIC_IMG)
	{
	    if(! response)
	    {
			ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_PIC, DIALOG_STYLE_LIST, "Edit signature - Avatar:", "Change Color\nChange Sprite\nChange Transparency", "Select", "Back");
	    }
	    else
	    {
			SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: You have changed your signature's avatar sprite.");
			switch(listitem)
			{
			    case 0: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:4rip"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:4rip\".");
				case 1: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:4spider"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:4spider\".");
				case 2: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:4weed"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:4weed\".");
				case 3: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:5cross"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:5cross\".");
				case 4: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:5cross2"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:5cross2\".");
				case 5: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:5cross3"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:5cross3\".");
				case 6: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:5gun"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:5gun\".");
				case 7: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:6africa"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:6africa\".");
				case 8: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:6aztec"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:6aztec\".");
				case 9: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:6clown"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:6clown\".");
				case 10: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:6crown"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:6crown\".");
				case 11: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:7cross"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:7cross\".");
				case 12: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:7cross2"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:7cross2\".");
				case 13: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:7cross3"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:7cross3\".");
				case 14: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:7mary"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:7mary\".");
				case 15: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:8gun"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:8gun\".");
				case 16: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:8poker"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:8poker\".");
				case 17: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:8sa"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:8sa\".");
				case 18: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:8sa2"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:8sa2\".");
				case 19: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:8sa3"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:8sa3\".");
				case 20: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:8santos"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:8santos\".");
				case 21: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:8westsd"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:8westsd\".");
				case 22: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:9bullt"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:9bullt\".");
				case 23: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:9crown"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:9crown\".");
				case 24: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:9gun"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:9gun\".");
				case 25: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:9gun2"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:9gun2\".");
				case 26: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:9homby"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:9homby\".");
				case 27: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:9rasta"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:9rasta\".");
				case 28: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:10ls"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:10ls\".");
				case 29: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:10ls2"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:10ls2\".");
				case 30: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:10ls3"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:10ls3\".");
				case 31: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:10ls4"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:10ls4\".");
				case 32: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:10ls5"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:10ls5\".");
				case 33: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:10og"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:10og\".");
				case 34: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:10weed"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:10weed\".");
				case 35: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:11dice"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:11dice\".");
				case 36: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:11dice2"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:11dice2\".");
				case 37: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:11ggift"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:11ggift\".");
				case 38: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:11grov2"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:11grov2\".");
				case 39: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:11grov3"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:11grov3\".");
				case 40: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:11grove"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:11grove\".");
				case 41: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:11jail"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:11jail\".");
				case 42: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:12angel"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:12angel\".");
				case 43: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:12bndit"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:12bndit\".");
				case 44: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:12cross"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:12cross\".");
				case 45: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:12dager"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:12dager\".");
				case 46: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:12maybr"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:12maybr\".");
				case 47: format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:12myfac"), SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Sprite selected \"LD_TATT:12myfac\".");
			}
			
			ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_PIC, DIALOG_STYLE_LIST, "Edit signature - Avatar:", "Change Color\nChange Sprite\nChange Transparency", "Select", "Back");

			ShowPlayerSignature(playerid, playerid);
		}
	}

	if(dialogid == DIALOG_SIGN_EDIT_PIC_OPC)
	{
	    if(! response)
	    {
			ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_PIC, DIALOG_STYLE_LIST, "Edit signature - Avatar:", "Change Color\nChange Sprite\nChange Transparency", "Select", "Back");
	    }
	    else
	    {
	        if( ! inputtext[0] ||
				strval(inputtext) < 10 ||
				strval(inputtext) > 255)
			{
			    return ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_BG_OPC, DIALOG_STYLE_INPUT, "Edit signature - Avatar - Transparency:", "Type in the opacity level to set\nNOTE: You can have maximum level of 255\nERROR: Invalid opacity value!", "Select", "Back");
			}

            g_PlayerSignature[playerid][i_AvatarColor] = ((g_PlayerSignature[playerid][i_AvatarColor] & ~0xFF) | (clamp(strval(inputtext), 0x00, 0xFF)));

			SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: You have changed your signature's avatar's opacity/transparency.");

            ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_PIC, DIALOG_STYLE_LIST, "Edit signature - Avatar:", "Change Color\nChange Sprite\nChange Transparency", "Select", "Back");

			ShowPlayerSignature(playerid, playerid);
		}
	}
	
	// edit moto

	if(dialogid == DIALOG_SIGN_EDIT_MOTO)
	{
	    if(! response)
	    {
			ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT, DIALOG_STYLE_LIST, "Edit signature:", "Edit Background\nEdit Avatar\nEdit Moto", "Select", "Back");
	    }
	    else
	    {
	        switch(listitem)
	        {
   		    	case 0:
		        {
		        	ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_MOTO_COL, DIALOG_STYLE_LIST, "Edit signature - Moto - Color:", "Use custom hexadecimal\nPre-defined colors", "Select", "Back");
		        }
   		    	case 1:
		        {
		        	ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_MOTO_TEXT, DIALOG_STYLE_INPUT, "Edit signature - Moto - Text:", "Inset below the text you want to set as your moto:\nNOTE: Themaximum length is 40 chars!", "Select", "Back");
		        }
   		    	case 2:
		        {
		        	ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_MOTO_OPC, DIALOG_STYLE_INPUT, "Edit signature - Moto - Transparency:", "Type in the opacity level to set\nNOTE: You can have maximum level of 255", "Select", "Back");
		        }
			}
	    }
	}

	if(dialogid == DIALOG_SIGN_EDIT_MOTO_COL)
	{
	    if(! response)
	    {
			ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_MOTO, DIALOG_STYLE_LIST, "Edit signature - Moto:", "Change Color\nChange Text\nChange Transparency", "Select", "Back");
	    }
	    else
	    {
	        switch(listitem)
	        {
   		    	case 0:
		        {
		        	ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_MOTO_COL_0, DIALOG_STYLE_INPUT, "Edit signature - Moto - Color - Custom:", "Insert a hexdecimal color code to set your background color:", "Select", "Back");
		        }
   		    	case 1:
		        {
		            new
		                s_Dialog[700]
					;

					strcat(s_Dialog, "{FFFFFF}White\n");
			    	strcat(s_Dialog, "{000000}Black\n");
			    	strcat(s_Dialog, "{808080}Grey\n");
			    	strcat(s_Dialog, "{008080}Teal\n");
			    	strcat(s_Dialog, "{003366}Navy blue\n");
			    	strcat(s_Dialog, "{3366CC}Sky blue\n");
			    	strcat(s_Dialog, "{000099}Dark blue\n");
			    	strcat(s_Dialog, "{3399FF}Light blue\n");
			    	strcat(s_Dialog, "{6600CC}Dark purple\n");
			    	strcat(s_Dialog, "{6600FF}Purple\n");
			    	strcat(s_Dialog, "{6666FF}Light purple\n");
			    	strcat(s_Dialog, "{00FFFF}Cyan\n");
			    	strcat(s_Dialog, "{00FFCC}Aqua\n");
			    	strcat(s_Dialog, "{00CC99}Poision green\n");
			    	strcat(s_Dialog, "{006666}Lawn green\n");
			    	strcat(s_Dialog, "{00CC00}Green\n");
			    	strcat(s_Dialog, "{CC99FF}Pink\n");
			    	strcat(s_Dialog, "{FF99FF}Hot pink\n");
			    	strcat(s_Dialog, "{FFFF99}Light yellow\n");
			    	strcat(s_Dialog, "{FFFF66}Yellow\n");
			    	strcat(s_Dialog, "{FF9933}Orange\n");
			    	strcat(s_Dialog, "{660033}Magenta\n");
			    	strcat(s_Dialog, "{800000}Marone\n");
			    	strcat(s_Dialog, "{FF0000}Red\n");
			    	strcat(s_Dialog, "{CC0000}Dark red\n");
			    	strcat(s_Dialog, "{999966}Khaki\n");
			    	strcat(s_Dialog, "{993333}Coral\n");
			    	strcat(s_Dialog, "{CCFF99}Lime\n");
			    	strcat(s_Dialog, "{663300}Brown\n");
			    	strcat(s_Dialog, "{A9C4E4}SA-MP Blue");

		        	ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_MOTO_COL_1, DIALOG_STYLE_LIST, "Edit signature - Moto - Color - List:", s_Dialog, "Select", "Back");
		        }
			}
	    }
	}

	if(dialogid == DIALOG_SIGN_EDIT_MOTO_COL_0)
	{
	    if(! response)
	    {
			ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_MOTO_COL, DIALOG_STYLE_LIST, "Edit signature - Moto - Color:", "Use custom hexadecimal\nPre-defined colors", "Select", "Back");
	    }
	    else
	    {
	        new red[3], green[3], blue[3], alpha[3];

           	if(inputtext[0] == '0' && inputtext[1] == 'x') // He's using 0xFFFFFF format
            {
            	if(strlen(inputtext) != 8 && strlen(inputtext) != 10)
				{
					return ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_MOTO_COL_0, DIALOG_STYLE_INPUT, "Edit signature - Moto - Color - Custom:", "Insert a hexdecimal color code to set your background color:\nERROR: Invalid hexdecimal color!", "Select", "Back");
                }
				else
                {
	             	format(red, sizeof(red), "%c%c", inputtext[2], inputtext[3]);
	                format(green, sizeof(green), "%c%c", inputtext[4], inputtext[5]);
	                format(blue, sizeof(blue), "%c%c", inputtext[6], inputtext[7]);
	               	if(inputtext[8] != '\0')
                 	{
				 		format(alpha, sizeof(alpha), "%c%c", inputtext[8], inputtext[9]);
					}
					else
					{
					    alpha = "FF";
					}
                }
     		}
			else if(inputtext[0] == '#') // He's using #FFFFFF format
            {
            	if(strlen(inputtext) != 7 && strlen(inputtext) != 9)
				{
					return ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_MOTO_COL_0, DIALOG_STYLE_INPUT, "Edit signature - Moto - Color - Custom:", "Insert a hexdecimal color code to set your background color:\nERROR: Invalid hexdecimal color!", "Select", "Back");
                }
                else
                {
     				format(red, sizeof(red), "%c%c", inputtext[1], inputtext[2]);
	                format(green, sizeof(green), "%c%c", inputtext[3], inputtext[4]);
	                format(blue, sizeof(blue), "%c%c", inputtext[5], inputtext[6]);
	                if(inputtext[7] != '\0')
                 	{
					 	format(alpha, sizeof(alpha), "%c%c", inputtext[7], inputtext[8]);
					}
					else
					{
					    alpha = "FF";
					}
                }
  			}
		  	else // He's using FFFFFF format
            {
            	if(strlen(inputtext) != 6 && strlen(inputtext) != 8)
				{
					return ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_MOTO_COL_0, DIALOG_STYLE_INPUT, "Edit signature - Moto - Color - Custom:", "Insert a hexdecimal color code to set your background color:\nERROR: Invalid hexdecimal color!", "Select", "Back");
                }
                else
                {
	            	format(red, sizeof(red), "%c%c", inputtext[0], inputtext[1]);
	                format(green, sizeof(green), "%c%c", inputtext[2], inputtext[3]);
	                format(blue, sizeof(blue), "%c%c", inputtext[4], inputtext[5]);
                 	if(inputtext[6] != '\0')
	                {
						format(alpha, sizeof(alpha), "%c%c", inputtext[6], inputtext[7]);
					}
					else
					{
					    alpha = "FF";
					}
                }
			}

			g_PlayerSignature[playerid][i_MotoColor] = RGB(HexToInt(red), HexToInt(green), HexToInt(blue), HexToInt(alpha));

			SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: You have changed your signature's moto color.");

			ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_MOTO_COL, DIALOG_STYLE_LIST, "Edit signature - Moto - Color:", "Use custom hexadecimal\nPre-defined colors", "Select", "Back");

			ShowPlayerSignature(playerid, playerid);
		}
	}

	if(dialogid == DIALOG_SIGN_EDIT_MOTO_COL_1)
	{
	    if(! response)
	    {
			ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_MOTO_COL, DIALOG_STYLE_LIST, "Edit signature - Moto - Color:", "Use custom hexadecimal\nPre-defined colors", "Select", "Back");
	    }
	    else
	    {
			SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: You have changed your signature's moto color.");

			switch(listitem)
			{
			    case 0: g_PlayerSignature[playerid][i_MotoColor] = 0xFFFFFFFF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"WHITE\".");
			    case 1: g_PlayerSignature[playerid][i_MotoColor] = 0x000000FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"BLACK\".");
			    case 2: g_PlayerSignature[playerid][i_MotoColor] = 0x808080FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"GREY\".");
			    case 3: g_PlayerSignature[playerid][i_MotoColor] = 0x008080FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"TEAL\".");
			    case 4: g_PlayerSignature[playerid][i_MotoColor] = 0x003366FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"NAVY BLUE\".");
			    case 5: g_PlayerSignature[playerid][i_MotoColor] = 0x3366CCFF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"SKY BLUE\".");
			    case 6: g_PlayerSignature[playerid][i_MotoColor] = 0x000099FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"DARK BLUE\".");
			    case 7: g_PlayerSignature[playerid][i_MotoColor] = 0x3399FFFF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"LIGHT BLUE\".");
			    case 8: g_PlayerSignature[playerid][i_MotoColor] = 0x6600CCFF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"DARK PURPLE\".");
			    case 9: g_PlayerSignature[playerid][i_MotoColor] = 0x6600FFFF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"PURPLE\".");
			    case 10: g_PlayerSignature[playerid][i_MotoColor] = 0x6666FFFF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"LIGHT PURPLE\".");
			    case 11: g_PlayerSignature[playerid][i_MotoColor] = 0x00FFFFFF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"CYAN\".");
			    case 12: g_PlayerSignature[playerid][i_MotoColor] = 0x00FFCCFF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"AQUA\".");
			    case 13: g_PlayerSignature[playerid][i_MotoColor] = 0x00CC99FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"POISION GREEN\".");
			    case 14: g_PlayerSignature[playerid][i_MotoColor] = 0x006666FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"LAWN GREEN\".");
			    case 15: g_PlayerSignature[playerid][i_MotoColor] = 0x00CC00FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"GREEN\".");
			    case 16: g_PlayerSignature[playerid][i_MotoColor] = 0xCC99FFFF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"PINK\".");
			    case 17: g_PlayerSignature[playerid][i_MotoColor] = 0xFF99FFFF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"HOT PINK\".");
			    case 18: g_PlayerSignature[playerid][i_MotoColor] = 0xFFFF99FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"LIGHT YELLOW\".");
			    case 19: g_PlayerSignature[playerid][i_MotoColor] = 0xFFFF66FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"YELLOW\".");
			    case 20: g_PlayerSignature[playerid][i_MotoColor] = 0xFF9933FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"ORANGE\".");
			    case 21: g_PlayerSignature[playerid][i_MotoColor] = 0x660033FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"MAGENTA\".");
			    case 22: g_PlayerSignature[playerid][i_MotoColor] = 0x800000FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"MARONE\".");
			    case 23: g_PlayerSignature[playerid][i_MotoColor] = 0xFF0000FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"RED\".");
			    case 24: g_PlayerSignature[playerid][i_MotoColor] = 0xCC0000FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"DARK RED\".");
			    case 25: g_PlayerSignature[playerid][i_MotoColor] = 0x999966FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"KHAKI\".");
			    case 26: g_PlayerSignature[playerid][i_MotoColor] = 0x993333FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"CORAL\".");
			    case 27: g_PlayerSignature[playerid][i_MotoColor] = 0xCCFF99FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"LIME\".");
			    case 28: g_PlayerSignature[playerid][i_MotoColor] = 0x663300FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"BROWN\".");
			    case 29: g_PlayerSignature[playerid][i_MotoColor] = 0xA9C4E4FF, SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: Color selected \"SAMP BLUE\".");
			}

			ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_MOTO_COL, DIALOG_STYLE_LIST, "Edit signature - Moto - Color:", "Use custom hexadecimal\nPre-defined colors", "Select", "Back");

			ShowPlayerSignature(playerid, playerid);
		}
	}

	if(dialogid == DIALOG_SIGN_EDIT_MOTO_TEXT)
	{
	    if(! response)
	    {
			ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_MOTO, DIALOG_STYLE_LIST, "Edit signature - Moto:", "Change Color\nChange Text\nChange Transparency", "Select", "Back");
	    }
	    else
	    {
			if(	! inputtext[0] ||
			    strlen(inputtext) > MAX_MOTO_SIZE ||
				strfind(inputtext, "~n~", true) != -1)
			{
			    return ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_MOTO_TEXT, DIALOG_STYLE_INPUT, "Edit signature - Moto - Text:", "Inset below the text you want to set as your moto:\nNOTE: Themaximum length is 40 chars!\nERROR: Invalid moto text (can't be blank as well)", "Select", "Back");
			}

			format(g_PlayerSignature[playerid][s_Moto], MAX_MOTO_SIZE, inputtext);

			ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_MOTO, DIALOG_STYLE_LIST, "Edit signature - Moto:", "Change Color\nChange Text\nChange Transparency", "Select", "Back");

			ShowPlayerSignature(playerid, playerid);
	    }
	}

	if(dialogid == DIALOG_SIGN_EDIT_MOTO_OPC)
	{
	    if(! response)
	    {
			ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_MOTO, DIALOG_STYLE_LIST, "Edit signature - Background:", "Change Color\nChange Text\nChange Transparency", "Select", "Back");
	    }
	    else
	    {
	        if( ! inputtext[0] ||
				strval(inputtext) < 10 ||
				strval(inputtext) > 255)
			{
			    return ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_MOTO_OPC, DIALOG_STYLE_INPUT, "Edit signature - Moto - Transparency:", "Type in the opacity level to set\nNOTE: You can have maximum level of 255!\nERROR: Invalid opacity value!", "Select", "Back");
			}
			
            g_PlayerSignature[playerid][i_MotoColor] = ((g_PlayerSignature[playerid][i_MotoColor] & ~0xFF) | (clamp(strval(inputtext), 0x00, 0xFF)));

			SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: You have changed your signature's moto's opacity/transparency.");

            ShowPlayerDialog(playerid, DIALOG_SIGN_EDIT_MOTO, DIALOG_STYLE_LIST, "Edit signature - Moto:", "Change Color\nChange Text\nChange Transparency", "Select", "Back");

			ShowPlayerSignature(playerid, playerid);
		}
	}
	
	// restore signature
	
	if(dialogid == DIALOG_SIGN_RESTORE)
	{
		if(! response)
		{
			cmd_mysignature(playerid);
		}
		else
		{
		    g_PlayerSignature[playerid][i_ExpireTimer] = -1;
		    g_PlayerSignature[playerid][i_NameColor] = -1;
			g_PlayerSignature[playerid][i_BackgroundColor] = -1;
			g_PlayerSignature[playerid][i_AvatarColor] = -1;
			g_PlayerSignature[playerid][i_MotoColor] = -1;
			g_PlayerSignature[playerid][b_Toggled] = true;
			format(g_PlayerSignature[playerid][s_BackgroundSprite], 25, "loadsc3:loadsc3");
			format(g_PlayerSignature[playerid][s_AvatarSprite], 25, "LD_TATT:5gun");
			format(g_PlayerSignature[playerid][s_Moto], MAX_MOTO_SIZE, "You is the best coder!");

			ShowPlayerSignature(playerid, playerid);

	        SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: You have restored your signature's default settings!");
	        
			cmd_mysignature(playerid);
		}
	}
	return 1;
}

//------------------------------------------------

CMD:signature(playerid, params[])
{
	new
	    i_Player
	;
	if(sscanf(params, "u", i_Player))
	{
	    return SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE - USAGE: /signature [player]");
	}
	
	if(! IsPlayerConnected(i_Player))
	{
	    return SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE - ERROR: The specified player is not connected.");
	}
	
	ShowPlayerSignature(playerid, i_Player, 10000);
 	SendClientMessage(playerid, COLOR_SIGNATURE, "SIGNATURE: The signature will automatically hide after 10 seconds.");
	return 1;
}
CMD:sign(playerid, params[])
{
	return cmd_signature(playerid, params);
}

CMD:mysignature(playerid)
{
	if(g_PlayerSignature[playerid][b_Toggled])
	{
		ShowPlayerSignature(playerid, playerid);
		ShowPlayerDialog(playerid, DIALOG_SIGN, DIALOG_STYLE_LIST, "Signature options:", "Disable signature\nEdit Signature\nRestore Default Signature", "Select", "Close");
	}
	else
	{
		HidePlayerSignature(playerid);
		ShowPlayerDialog(playerid, DIALOG_SIGN, DIALOG_STYLE_LIST, "Signature options:", "Enable signature", "Select", "Close");
	}
	return 1;
}
CMD:mysign(playerid)
{
	return cmd_mysignature(playerid);
}

//------------------------------------------------

public OnPlayerDeath(playerid, killerid, reason)
{
	if(killerid != INVALID_PLAYER_ID)
	{
		new
		    s_Name[MAX_PLAYER_NAME],
		    s_Str[144]
	 	;
	 	
	 	//signature for player (the one who died)
	 	GetPlayerName(killerid, s_Name, MAX_PLAYER_NAME);
	 	format(s_Str, sizeof(s_Str), "You got killed by %s(%i)", s_Name, killerid);

		PlayerTextDrawSetString(playerid, g_PlayerSignature[playerid][i_Textdraw][0], s_Str);
		PlayerTextDrawShow(playerid, g_PlayerSignature[playerid][i_Textdraw][0]);

		ShowPlayerSignature(playerid, killerid, 5000);

		//signature for killer (the one who killed)
	 	GetPlayerName(playerid, s_Name, MAX_PLAYER_NAME);
	 	format(s_Str, sizeof(s_Str), "You killed %s(%i)", s_Name, playerid);

		PlayerTextDrawSetString(killerid, g_PlayerSignature[killerid][i_Textdraw][0], s_Str);
		PlayerTextDrawShow(killerid, g_PlayerSignature[killerid][i_Textdraw][0]);
		
		ShowPlayerSignature(killerid, playerid, 5000);
	}
	return 1;
}

//------------------------------------------------
