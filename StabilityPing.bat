::BATCH FOR TESTING CONNECTION STABILITY

@echo off
setlocal

REM get Start time
set "Starttime=%time%"
echo Start: %Starttime%

REM Target Adress
set TargetHost=88.99.192.186

REM Number of tracer Hops
set TracertHops=30

REM Number of Tracer-loops
set loops=10

REM Number of sended pakets
set Pakets=100
set results=ResultsOfPing.txt

echo pings sending now

REM Ping running
ping %TargetHost% -n %Pakets% > %results%

REM breakline
echo ------------------------------------- >> %results%

echo start Traceroute

for /l %%i in (1,1,%loops%) do (
REM tracert running
tracert -h %TracertHops% %TargetHost% >> %results%

echo Traceroute test number: %%i
echo. >> %results%
)

REM show results
type %results%

echo Ping test and Traceroute end

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
