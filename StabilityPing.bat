::BATCH FOR TESTING CONNECTION STABILITY

@echo off
setlocal

REM get Start time
set "Starttime=%time%"
echo Start: %Starttime%

REM Options
set TargetHost=www.google.com

REM Number of sended pakets
set Pakets=1000
set results=ResultsOfPing.txt

REM Ping running
ping %TargetHost% -n %Pakets% > %results%

REM show results
type %results%

echo Ping test end

REM get end time
set "Endtime=%time%"

REM calculation of seconds
for /f "tokens=1-3 delims=:." %%a in ("%Starttime%") do (
    set /a "StartSeconds=(((%%a*60)+1%%b %% 100)*60)+1%%c %% 100"
)
for /f "tokens=1-3 delims=:." %%a in ("%Endtime%") do (
    set /a "EndSeconds=(((%%a*60)+1%%b %% 100)*60)+1%%c %% 100"
)

set /a "totalDuration=EndSeconds - StartSeconds"

REM show total duration time 
echo total duration: %totalDuration% seconds

endlocal
exit /b
