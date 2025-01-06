const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#12121b", /* black   */
  [1] = "#56708E", /* red     */
  [2] = "#607F9F", /* green   */
  [3] = "#698CAF", /* yellow  */
  [4] = "#759DC3", /* blue    */
  [5] = "#7BA5CD", /* magenta */
  [6] = "#83B1DA", /* cyan    */
  [7] = "#bcd4ea", /* white   */

  /* 8 bright colors */
  [8]  = "#8394a3",  /* black   */
  [9]  = "#56708E",  /* red     */
  [10] = "#607F9F", /* green   */
  [11] = "#698CAF", /* yellow  */
  [12] = "#759DC3", /* blue    */
  [13] = "#7BA5CD", /* magenta */
  [14] = "#83B1DA", /* cyan    */
  [15] = "#bcd4ea", /* white   */

  /* special colors */
  [256] = "#12121b", /* background */
  [257] = "#bcd4ea", /* foreground */
  [258] = "#bcd4ea",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
