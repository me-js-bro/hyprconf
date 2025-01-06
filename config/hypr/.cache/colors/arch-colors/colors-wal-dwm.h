static const char norm_fg[] = "#bcd4ea";
static const char norm_bg[] = "#12121b";
static const char norm_border[] = "#8394a3";

static const char sel_fg[] = "#bcd4ea";
static const char sel_bg[] = "#607F9F";
static const char sel_border[] = "#bcd4ea";

static const char urg_fg[] = "#bcd4ea";
static const char urg_bg[] = "#56708E";
static const char urg_border[] = "#56708E";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
