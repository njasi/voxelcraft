local modem = peripheral.wrap("back")
local target = peripheral.wrap("top")
local debug = peripheral.wrap("left")

local keyboard =       "` 1 2 3 4 5 6 7 8 9 0 - = del\ntab q w e r t y u i o p [ ] \\\ncaps a s d f g h j k l ; ' en\nshift z x c v b n m , . / \n            space            "
local shift_keyboard = "~ ! @ # $ % ^ & * ( ) _ + del\ntab Q W E R T Y U I O P { } |\ncaps A S D F G H J K L : \" en\nshift Z X C V B N M < > ? \n            space            "
local keys = {}

local row1  = {}
row1[1]="`"
row1[2]="`"
row1[3]="1"
row1[4]="1"
row1[5]="2"
row1[6]="2"
row1[7]="3"
row1[8]="3"
row1[9]="4"
row1[10]="4"
row1[11]="5"
row1[12]="5"
row1[13]="6"
row1[14]="6"
row1[15]="7"
row1[16]="7"
row1[17]="8"
row1[18]="8"
row1[19]="9"
row1[20]="9"
row1[21]="0"
row1[22]="0"
row1[23]="-"
row1[24]="-"
row1[25]="="
row1[26]="="
row1[27]="DEL"
row1[28]="DEL"
row1[29]="DEL"

local shiftRow1  = {}
shiftRow1[1]="~"
shiftRow1[2]="~"
shiftRow1[3]="!"
shiftRow1[4]="!"
shiftRow1[5]="@"
shiftRow1[6]="@"
shiftRow1[7]="#"
shiftRow1[8]="#"
shiftRow1[9]="$"
shiftRow1[10]="$"
shiftRow1[11]="%"
shiftRow1[12]="%"
shiftRow1[13]="^"
shiftRow1[14]="^"
shiftRow1[15]="&"
shiftRow1[16]="&"
shiftRow1[17]="*"
shiftRow1[18]="*"
shiftRow1[19]="("
shiftRow1[20]="("
shiftRow1[21]=")"
shiftRow1[22]=")"
shiftRow1[23]="_"
shiftRow1[24]="_"
shiftRow1[25]="+"
shiftRow1[26]="+"
shiftRow1[27]="DEL"
shiftRow1[28]="DEL"
shiftRow1[29]="DEL"


local row2={}
row2[1]="TAB"
row2[2]="TAB"
row2[3]="TAB"
row2[4]="TAB"
row2[5]="q"
row2[6]="q"
row2[7]="w"
row2[8]="w"
row2[9]="e"
row2[10]="e"
row2[11]="r"
row2[12]="r"
row2[13]="t"
row2[14]="t"
row2[15]="y"
row2[16]="y"
row2[17]="u"
row2[18]="u"
row2[19]="i"
row2[20]="i"
row2[21]="o"
row2[22]="o"
row2[23]="p"
row2[24]="p"
row2[25]="["
row2[26]="["
row2[27]="]"
row2[28]="]"
row2[29]="\\"

local shiftRow2={}
shiftRow2[1]="TAB"
shiftRow2[2]="TAB"
shiftRow2[3]="TAB"
shiftRow2[4]="TAB"
shiftRow2[5]="Q"
shiftRow2[6]="Q"
shiftRow2[7]="W"
shiftRow2[8]="W"
shiftRow2[9]="E"
shiftRow2[10]="E"
shiftRow2[11]="R"
shiftRow2[12]="R"
shiftRow2[13]="T"
shiftRow2[14]="T"
shiftRow2[15]="Y"
shiftRow2[16]="Y"
shiftRow2[17]="U"
shiftRow2[18]="U"
shiftRow2[19]="I"
shiftRow2[20]="I"
shiftRow2[21]="O"
shiftRow2[22]="O"
shiftRow2[23]="P"
shiftRow2[24]="P"
shiftRow2[25]="{"
shiftRow2[26]="{"
shiftRow2[27]="}"
shiftRow2[28]="}"
shiftRow2[29]="|"

local row3={}
row3[1]="CAPS"
row3[2]="CAPS"
row3[3]="CAPS"
row3[4]="CAPS"
row3[5]="CAPS"
row3[6]="a"
row3[7]="a"
row3[8]="s"
row3[9]="s"
row3[10]="d"
row3[11]="d"
row3[12]="f"
row3[13]="f"
row3[14]="g"
row3[15]="g"
row3[16]="h"
row3[17]="h"
row3[18]="j"
row3[19]="j"
row3[20]="k"
row3[21]="k"
row3[22]="l"
row3[23]="l"
row3[24]=";"
row3[25]=";"
row3[26]="'"
row3[27]="'"
row3[28]="ENTER"
row3[29]="ENTER"

local shiftRow3={}
shiftRow3[1]="CAPS"
shiftRow3[2]="CAPS"
shiftRow3[3]="CAPS"
shiftRow3[4]="CAPS"
shiftRow3[5]="CAPS"
shiftRow3[6]="A"
shiftRow3[7]="A"
shiftRow3[8]="S"
shiftRow3[9]="S"
shiftRow3[10]="D"
shiftRow3[11]="D"
shiftRow3[12]="F"
shiftRow3[13]="F"
shiftRow3[14]="G"
shiftRow3[15]="G"
shiftRow3[16]="H"
shiftRow3[17]="H"
shiftRow3[18]="J"
shiftRow3[19]="J"
shiftRow3[20]="K"
shiftRow3[21]="K"
shiftRow3[22]="L"
shiftRow3[23]="L"
shiftRow3[24]=":"
shiftRow3[25]=":"
shiftRow3[26]="\""
shiftRow3[27]="\""
shiftRow3[28]="ENTER"
shiftRow3[29]="ENTER"

local row4={}
row4[1]="SHIFT"
row4[2]="SHIFT"
row4[3]="SHIFT"
row4[4]="SHIFT"
row4[5]="SHIFT"
row4[6]="SHIFT"
row4[7]="z"
row4[8]="z"
row4[9]="x"
row4[10]="x"
row4[11]="c"
row4[12]="c"
row4[13]="v"
row4[14]="v"
row4[15]="b"
row4[16]="b"
row4[17]="n"
row4[18]="n"
row4[19]="m"
row4[20]="m"
row4[21]=","
row4[22]=","
row4[23]="."
row4[24]="."
row4[25]="/"
row4[26]="/"
for i = 27,29 do
  row4[i] = "EMPTY"
end

local shiftRow4={}
shiftRow4[1]="SHIFT"
shiftRow4[2]="SHIFT"
shiftRow4[3]="SHIFT"
shiftRow4[4]="SHIFT"
shiftRow4[5]="SHIFT"
shiftRow4[6]="SHIFT"
shiftRow4[7]="Z"
shiftRow4[8]="Z"
shiftRow4[9]="X"
shiftRow4[10]="X"
shiftRow4[11]="C"
shiftRow4[12]="C"
shiftRow4[13]="V"
shiftRow4[14]="V"
shiftRow4[15]="B"
shiftRow4[16]="B"
shiftRow4[17]="N"
shiftRow4[18]="N"
shiftRow4[19]="M"
shiftRow4[20]="M"
shiftRow4[21]="<"
shiftRow4[22]="<"
shiftRow4[23]=">"
shiftRow4[24]=">"
shiftRow4[25]="?"
shiftRow4[26]="?"
for i = 27,29 do
  shiftRow4[i] = "EMPTY"
end

local row5 = {}
for i = 1,12 do
  row5[i] = "EMPTY"
end
row5[13]="SPACE"
row5[14]="SPACE"
row5[15]="SPACE"
row5[16]="SPACE"
row5[17]="SPACE"
for i = 18,30 do
  row5[i] = "EMPTY"
end

local shiftRow5 = {}
for i = 1,12 do
  shiftRow5[i] = "EMPTY"
end
shiftRow5[13]="SPACE"
shiftRow5[14]="SPACE"
shiftRow5[15]="SPACE"
shiftRow5[16]="SPACE"
shiftRow5[17]="SPACE"
for i = 18,30 do
  shiftRow5[i] = "EMPTY"
end

-- add the key rows into the table
keys[1] = row1
keys[6] = shiftRow1
keys[2] = row2
keys[7] = shiftRow2
keys[3] = row3
keys[8] = shiftRow3
keys[4] = row4
keys[9] = shiftRow4
keys[5] = row5
keys[10] = shiftRow5

function debugPrint(thing,curr)
  debug.print(thing)
end

function getKey (xPos,yPos,shift,keys)
  local row = keys[yPos + shift]
  return row[xPos]
end

local shifted = falsea
local caps = false

while true do
  -- write shift keyboard
  if shifted or caps then
    target.write(shift_keyboard)
  else
    target.write(keyboard)
  end

  -- pull the keypress
  event, side, xPos, yPos = os.pullEvent("monitor_touch")

  -- get keypress
  local keyPressed = "TEMP"
  if shifted or caps then
    keyPressed = getKey(xPos,yPos,5,keys)
  else
    keyPressed = getKey(xPos,yPos,0,keys)
  end
  debugPrint(keyPressed,target)

  -- unshift
  if shifted then
    shifted = false
  end

  -- special keys
  if keyPressed == "SHIFT" then
    shifted = not shifted
  elseif keyPressed == "CAPS" then
    caps = not caps
  else if keyPressed == "EMPTY" then
    keyPressed = ""
  else if keyPressed == "SPACE" then
    keyPressed = " "
  end
end