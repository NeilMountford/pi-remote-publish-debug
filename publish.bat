dotnet publish -r linux-arm
rsync -razvp --chmod=Fu=rwx ./bin/Debug/netcoreapp2.2/linux-arm/publish/* pi@raspberrypi.local:/home/pi/development/HelloPi