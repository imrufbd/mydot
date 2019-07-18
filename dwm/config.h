/* See LICENSE file for copyright and license details. */
/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 0;        /* 0 means bottom bar */
static const char *fonts[]          = { "UbuntuMono Nerd Font:size=10" };
static const char dmenufont[]       = "NotoMonoRegular:bold:pixelsize=14";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#005577";
static const char col_black[]       = "#000000";
static const char col_red[]         = "#ff0000";
static const char col_yellow[]      = "#ffff00";
static const char col_white[]       = "#ffffff";
static const char col_y1[]          = "#191919";
static const char col_y2[]          = "#fea63c";
static const char *colors[][3]      = {

	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
};
/* tagging */
static const char *tags[] = { "", "", "", "", "", "", "", "", "" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
     /* { "mpv",             NULL,       "mpv",                     1 << 2,       True,                             -1 }, */
    /* { "Gimp",            NULL,       NULL,                      0,            1,           0,         0,        -1 }, */
     /* { "MPlayer",         NULL,       "MPlayer",                 1 << 2,       True,                             -1 }, */
    
	/* class             instance    title                      tags mask     isfloating   isterminal noswallow monitor */
	{ "Firefox",         NULL,       NULL,                      1 << 1,       0,           0,         0,        -1 },
	{ "qutebrowser",     NULL,       NULL,                      1 << 1,       0,           0,         0,        -1 },
	{ "Surf",            NULL,       NULL,                      1 << 1,       0,           0,         0,        -1 },
	{ "st",              NULL,       NULL,                      0,            0,           1,         1,        -1 },
	{ "Soffice",         NULL,       NULL,                      1 << 3,       0,           0,         0,        -1 },
    { "Firefox",         NULL,       "Firefox Preferences",     1 << 1,       True,                             -1 },
    { "Galculator",      NULL,       "Galculator",              0,            True,                             -1 },
	{ "libreoffice-startcenter",  NULL,  NULL,                  1 << 3,       0,           0,         0,        -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[T]=",      tile },    /* first entry is default */
	{ "[F]",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod1Mask
#define MOD2   Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },
#define CMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-fn", dmenufont, "-nb", col_y1, "-nf", col_y2, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *roficmd[] = { "rofi", "-show", "combi", NULL };
static const char *termcmd[]  = { "st", NULL };
static const char *fmcmd[] = { "thunar", NULL };
static const char *bcmd[] = { "qutebrowser", NULL };
static const char *iph[] = { "i3exit", "suspend", NULL };
static const char *ipr[] = { "i3exit", "reboot", NULL };
static const char *ips[] = { "i3exit", "shutdown", NULL };
static const char *ipl[] = { "i3exit", "lock", NULL };
static const char *upvol[]   = { "pactl", "set-sink-volume", "0", "+5%",     NULL };
static const char *downvol[] = { "pactl", "set-sink-volume", "0", "-5%",     NULL };
static const char *mutevol[] = { "pactl", "set-sink-mute",   "0", "toggle",  NULL };
/*static const char *brdec[] = { "brightnessctl", "s", "5-", "radeon_bl0", NULL };
static const char *brinc[] = { "brightnessctl", "s", "+5", "radeon_bl0", NULL };*/

#include <X11/XF86keysym.h>
#include "movestack.c"
/* #include "selfrestart.c" */

static Key keys[] = {
	/* modifier                     key               function        argument */
	{ MODKEY,                       XK_semicolon,     spawn,          {.v = dmenucmd } },
	{ MOD2,                         XK_semicolon,     spawn,          {.v = roficmd } },
	{ MODKEY,                       XK_slash,         spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_p,             spawn,          {.v = fmcmd } },
	{ MODKEY,                       XK_i,             spawn,          {.v = bcmd } },
	{ MODKEY,                       XK_b,             togglebar,      {0} },
	{ MODKEY,                       XK_j,             focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,             focusstack,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_i,             incnmaster,     {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_d,             incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,             setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,             setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_j,             movestack,      {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_k,             movestack,      {.i = -1 } },
	{ MOD2,                         XK_h,             movestack,      {.i = +1 } },
	{ MOD2,                         XK_l,             movestack,      {.i = -1 } },
	{ MODKEY,                       XK_Return,        zoom,           {0} },
	{ MODKEY,                       XK_Tab,           view,           {0} },
	{ MODKEY,                       XK_y,             killclient,     {0} },
	{ MODKEY,                       XK_t,             setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,             setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,             setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,         setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,         togglefloating, {0} },
	{ MOD2,                         XK_u,             togglefloating, {0} },
	{ MODKEY,                       XK_0,             view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,             tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,         focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period,        focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,         tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period,        tagmon,         {.i = +1 } },
	{ MOD2,                         XK_q,             moveplace,      {.ui = WIN_NW }},
	{ MOD2,                         XK_w,             moveplace,      {.ui = WIN_N  }},
	{ MOD2,                         XK_e,             moveplace,      {.ui = WIN_NE }},
	{ MOD2,                         XK_a,             moveplace,      {.ui = WIN_W  }},
	{ MOD2,                         XK_s,             moveplace,      {.ui = WIN_C  }},
	{ MOD2,                         XK_d,             moveplace,      {.ui = WIN_E  }},
	{ MOD2,                         XK_z,             moveplace,      {.ui = WIN_SW }},
	{ MOD2,                         XK_x,             moveplace,      {.ui = WIN_S  }},
	{ MOD2,                         XK_b,             moveplace,      {.ui = WIN_SE }},
    { MODKEY|ControlMask,           XK_l,             shiftview,      { .i = +1 } },
    { MODKEY|ControlMask,           XK_h,             shiftview,      { .i = -1 } },
	TAGKEYS(                        XK_1,                             0)
	TAGKEYS(                        XK_2,                             1)
	TAGKEYS(                        XK_3,                             2)
	TAGKEYS(                        XK_4,                             3)
	TAGKEYS(                        XK_5,                             4)
	TAGKEYS(                        XK_6,                             5)
	TAGKEYS(                        XK_7,                             6)
	TAGKEYS(                        XK_8,                             7)
	TAGKEYS(                        XK_9,                             8)
	{ MODKEY|ShiftMask,             XK_e,              quit,           {0} },
	{ MODKEY|ShiftMask,             XK_h,              spawn,          {.v = iph } },
	{ MODKEY|ShiftMask,             XK_r,              spawn,          {.v = ipr } },
	{ MODKEY|ShiftMask,             XK_s,              spawn,          {.v = ips } },
	{ MODKEY|ShiftMask,             XK_l,              spawn,          {.v = ipl } },
	{ MODKEY,                       XK_o,              spawn,          CMD("st -e nnn") },
	{ MODKEY,                       XK_n,              spawn,          CMD("xfce4-popup-notes --show-hide") },
	{ MOD2,                         XK_o,              spawn,          CMD("xterm -e ranger") },
	{ 0,                            XK_Print,          spawn,          CMD("xfce4-screenshooter -f") },
	{ 0,                            XF86XK_Calculator, spawn,          CMD("galculator") },
	{ ControlMask,                  XK_Print,          spawn,          CMD("xfce4-screenshooter") },
	{ ShiftMask,                    XK_Print,          spawn,          CMD("xfce4-screenshooter -w") },
    { 0,                     XF86XK_AudioLowerVolume,  spawn,          {.v = downvol } },
    { 0,                     XF86XK_AudioMute,         spawn,          {.v = mutevol } },
    { 0,                     XF86XK_AudioRaiseVolume,  spawn,          {.v = upvol   } },
    /*{ 0,                     XF86XK_MonBrightnessUp,   spawn,          {.v = brinc} },*/
    /*{ 0,                     XF86XK_MonBrightnessDown, spawn,          {.v = brdec} },*/
    /*{ MODKEY|ShiftMask,             XK_r,             self_restart,   {0} },*/
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

