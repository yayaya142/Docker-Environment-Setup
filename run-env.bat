@echo off
echo Building image...
docker-compose build

echo.
echo Starting container...
docker-compose run --rm devbox

pause
