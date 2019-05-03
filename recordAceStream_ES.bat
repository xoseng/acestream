@echo off 
echo ---------------------------------------------------- 
echo ----SCRIPT PROGRAMADOR DE GRABACIONES ACESTREAM-----
echo ----------------------------------------------------
echo
echo Introduce un nombre para el archivo:
set /p nombre=
echo Introduce la ruta donde quieres almacenar el archivo, 
echo por ejemplo: C:\Users\%USERNAME%\Desktop\
set /p ruta=
set pathacestream= C:\Users\%USERNAME%\AppData\Roaming\ACEStream\player\ace_player.exe 
echo
echo se creara el siguiente archivo en: %ruta%%nombre%.mpg
echo Introduce un enlace: 
echo por ejemplo: http://, acestream:// ...
set /p enlace=
echo Has seleccionado el siguiente %enlace%
echo
echo Cuanto tiempo en minutos quieres esperar antes de empezar la grabacion?
set /p esperamin=
echo en %esperamin% minutos comenzara la grabacion.
set esperaseg=%esperamin%*60
echo
echo Cuantos minutos quieres que dure la grabacion?
set /p tiempograbmin=
echo la grabacion durara %tiempograbmin% minutos.
set tiempograbseg=%tiempograbmin%*60
echo
Choice /M "Quieres apagar el equipo una vez terminada la grabacion?"

If Errorlevel 2 Goto No

If Errorlevel 1 Goto Yes

Goto End

:No
echo ----NO CIERRES EL SCRIPT MIENTRAS DURA LA GRABACION----

echo El equipo esperara 5 minutos y una vez terminada la grabacion se apagara.
echo La grabacion comenzara en %esperamin% minutos.
ping -n %esperaseg% 127.0.0.1 > nul 
echo Comenzando grabacion...
%pathacestream% %enlace% --sout=#transcode{vcodec=mp4v,acodec=mpga,vb=800,ab=128,deinterlace}:standard{access=file,mux=ts,dst="%ruta%%nombre%.mpg"} --run-time=%tiempograbseg% --stop-time=%tiempograbseg% vlc://quit
ping -n 300 127.0.0.1 > nul 

Goto End

:Yes
echo ----NO CIERRES EL SCRIPT MIENTRAS DURA LA GRABACION----

echo El equipo esperara 5 minutos y una vez terminada la grabacion se apagara.
echo La grabacion comenzara en %esperamin% minutos.
ping -n %esperaseg% 127.0.0.1 > nul 
echo Comenzando grabacion...
%pathacestream% %enlace% --sout=#transcode{vcodec=mp4v,acodec=mpga,vb=800,ab=128,deinterlace}:standard{access=file,mux=ts,dst="%ruta%%nombre%.mpg"} --run-time=%tiempograbseg% --stop-time=%tiempograbseg% vlc://quit
echo En 5 minutos se apagara el equipo...
shutdown -s -t 300

:End
exit0
