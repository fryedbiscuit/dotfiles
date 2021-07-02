#include <X11/XF86keysym.h>

/* appearance */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray        = 1;     /* 0 means no systray */
static const int swallowfloating    = 0;        /* 1 means swallow floating windows by default */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const int startontag         = 1;        /* 0 means no tag active on start */
static const char *fonts[]          = { "monospace:size=10" };
static const char dmenufont[]       = "monospace:size=10";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#005577";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
};

static const char *const autostart[] = {
	"nitrogen", "--restore", NULL,
	"pa-applet", NULL,
	"nm-applet", NULL,
	"picom", NULL,
	"xfce4-power-manager", NULL,
	"xfce4-clipman", NULL,
	"udiskie", "-t", "-N", NULL,
	"blueman-applet", NULL,
	"numlockx", "on", NULL,
	"fcitx", NULL,
	"dwm_bar", NULL,
	/* "dropbox", NULL, */
	NULL /* terminate */
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class     instance  title           tags mask  isfloating  isterminal  noswallow  monitor */
	/* { "Gimp",    NULL,     NULL,           0,         1,          0,           0,        -1 }, */
	{ "Firefox", NULL,     NULL,           1 << 8,    0,          0,          -1,        -1 },
	{ "Clamtk",    NULL,     NULL,           0,         1,          0,           0,        -1 },
	{ "st",      NULL,     NULL,           0,         0,          1,          -1,        -1 },
	{ NULL,      NULL,     "Event Tester", 0,         1,          0,           1,        -1 }, /* xev */
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

#include "fibonacci.c"
#include "grid.c"
static const Layout layouts[] = {
	/* symbol     arrange function */
 	{ "[@]",      spiral },  /* first entry is default */
 	{ "[\\]",     dwindle },
	{ "[]=",      tile },
	{ "[M]",      monocle },
	{ "HHH",      grid },
	{ "><>",      NULL },    /* no layout function means floating */
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_recency", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *termcmd[]  = { "st", NULL };

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,			XK_d,      spawn,          {.v = dmenucmd } },
	{ MODKEY,			XK_p,	   spawn,          SHCMD("j4-dmenu-desktop") },
	{ MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY|ShiftMask,             XK_j,      rotatestack,    {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_k,      rotatestack,    {.i = -1 } },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY,                       XK_q,      killclient,     {0} },
	{ MODKEY,                       XK_r,      setlayout,      {.v = &layouts[0]} }, /* Spiral */
	{ MODKEY|ShiftMask,             XK_r,      setlayout,      {.v = &layouts[1]} }, /* Dwindle */
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[2]} }, /* Tile */
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[3]} }, /* Monocle */
	{ MODKEY,                       XK_g,      setlayout,      {.v = &layouts[4]} }, /* Grid */
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[5]} }, /* Floating */
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY|ShiftMask,             XK_f,      togglefullscr,  {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ControlMask,           XK_q,      quit,           {0} }, /* Quit dwm */
	{ MODKEY|ControlMask,		XK_r,      quit,           {1} }, /* Restart dwm */

	/* Audio hotkeys */
	{ MODKEY,			XK_minus,	spawn,		SHCMD("pamixer -d 5 --allow-boost") },
	{ MODKEY,			XK_equal,	spawn,		SHCMD("pamixer -i 5 --allow-boost") },
	{ MODKEY|ShiftMask,		XK_equal,	spawn,		SHCMD("pamixer -t") },

	/* System programs */
	{ MODKEY,			XK_c,		spawn,		SHCMD("picom_toggle") },
	{ MODKEY,			XK_a,		spawn,		SHCMD("st -e pulsemixer") },
	{ MODKEY|ShiftMask,		XK_a,		spawn,		SHCMD("pavucontrol") },
	{ MODKEY|ShiftMask,		XK_l,		spawn,		SHCMD("toggle_led") },
	{ 0,				XK_Print,	spawn,		SHCMD("scr") },
	{ MODKEY,			XK_backslash,	spawn,		SHCMD("slock") },

	/* Program launching */
	{ MODKEY,			XK_w,		spawn,		SHCMD("firefox") },
	{ MODKEY|ShiftMask,		XK_w,		spawn,		SHCMD("torbrowser-launcher") },
	{ MODKEY,			XK_v,		spawn,		SHCMD("st -e vifm") },
	{ MODKEY|ShiftMask,		XK_v,		spawn,		SHCMD("pcmanfm") },
	{ MODKEY|ShiftMask,		XK_h,		spawn,		SHCMD("st -e sudo htop") },
	{ MODKEY|ShiftMask,		XK_p,		spawn,		SHCMD("st -e bpython") },
	/* { MODKEY|ShiftMask,		XK_p,		spawn,		SHCMD("xfce4-appfinder") }, */
	{ MODKEY,			XK_n,		spawn,		SHCMD("st -e vim ~/git/vimwiki/index.wiki") },

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

