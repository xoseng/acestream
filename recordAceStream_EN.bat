@echo off 
echo ---------------------------------------------------- 
echo -------------SCRIPT RECORDING ACESTREAM-------------
echo ----------------------------------------------------
echo
echo Set a file name:
set /p nombre=
echo Enter the path where you want to store the file, 
echo for example: C:\Users\%USERNAME%\Desktop\
set /p ruta=
set pathacestream= C:\Users\%USERNAME%\AppData\Roaming\ACEStream\player\ace_player.exe 
echo
echo the following file will be created in: %ruta%%nombre%.mpg
echo Set a link: 
echo for example: http://, acestream:// ...
set /p enlace=
echo You have selected the following link %enlace%
echo
echo How much time in minutes do you want to wait before starting the recording?
set /p esperamin=
echo In %esperamin% minutes the recording will begin.
set esperaseg=%esperamin%*60
echo
echo How many minutes do you want the recording to last?
set /p tiempograbmin=
echo the recording will last %tiempograbmin% minutes.
set tiempograbseg=%tiempograbmin%*60
echo
Choice /M "Do you want shutdown the computer once the recording done?"

If Errorlevel 2 Goto No

If Errorlevel 1 Goto Yes

Goto End

:No
echo ----DON'T CLOSE THE SCRIPT WHILE RECORDING ON----
echo The recording starts in %esperamin% minutes.
ping -n %esperaseg% 127.0.0.1 > nul 
echo Now is recording...
%pathacestream% %enlace% --sout=#transcode{vcodec=mp4v,acodec=mpga,vb=800,ab=128,deinterlace}:standard{access=file,mux=ts,dst="%ruta%%nombre%.mpg"} --run-time=%tiempograbseg% --stop-time=%tiempograbseg% vlc://quit
ping -n 300 127.0.0.1 > nul 

Goto End

:Yes
echo ----DON'T CLOSE THE SCRIPT WHILE RECORDING ON----
echo The computer will wait about 5 minutes and once the recording is done it will shutdown.
echo The recording starts in %esperamin% minutes.
ping -n %esperaseg% 127.0.0.1 > nul 
echo Now is recording...
%pathacestream% %enlace% --sout=#transcode{vcodec=mp4v,acodec=mpga,vb=800,ab=128,deinterlace}:standard{access=file,mux=ts,dst="%ruta%%nombre%.mpg"} --run-time=%tiempograbseg% --stop-time=%tiempograbseg% vlc://quit
echo In 5 minutes the computer will shutdown...
shutdown -s -t 300

:End
exit0