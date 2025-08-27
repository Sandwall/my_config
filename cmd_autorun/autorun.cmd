@echo off

REM $M is a remote name for network drives
REM $_ is a carriage return/newline
REM $T is the current time
REM $P is current drive/directory path
REM $G is the > character
REM $E[32m sets color to green, $E[0m resets color

prompt $M$_$E[32m$T$E[0m $P$G

doskey .="%SystemRoot%\explorer.exe" /e,.
doskey ..=cd ..
doskey ls=dir /og /d $*
doskey ll=dir /og /x $*
doskey cat=type $*
doskey clear=cls
doskey macros=doskey /macros
doskey vcvars="C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\VsDevCmd.bat" -startdir=none -arch=x64 -host_arch=x64