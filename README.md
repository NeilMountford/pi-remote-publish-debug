# Deploy and debug remotely

This project is a basic template showing how to create a dotnet core project that can be edited in VS code on a nice powerful IDE machine, published there and then deployed and remotely debugged to a Raspberry Pi.

The best advice I can give is to go and have a read of https://github.com/OmniSharp/omnisharp-vscode/wiki/Remote-Debugging-On-Linux-Arm, it does a really good job of explaining how to set everything up.

## Development machine prerequisites

You'll need a few things setup on the machine you're going to use to develop:

- SSH - You should be able to call ssh pi@yourpi.local or somesuch from your command line. There's an ssh client packaged with git for Windows, it may just be a case of adding that to your path. You also need ssh keys
- SCP - You'll also need scp (if you're using the Linux tools bundled with git then again you'll be fine)
- .Net Core SDK
- Visual Studio Code

If you're not sure how to set up ssh with your Raspberry Pi then there are plenty of guides on the internet, just Google it ;)

## Remote machine prerequisites

You'll also need to get your Raspberry Pi set up with a few things:

- .Net Core SDK (at the moment only the 32 bit ones work, so make sure you get the linux arm32 build)
- VSDBG - This allows dotnet core apps to be debugged

## Setup

1. Create a new .Net Core app or clone this repo
2. If you created a new application you need to copy the `publish.bat`, `.vscode\launch.json` and `.vscode\tasks.json` files over to it (or just the contents you're interested in)
3. In `publish.bat` change the remote path to your pi (that's the second part), if you're using a version of .Net Core that isn't 2.2 then you may need to change the source too
4. In `.vscode\launch.json` change the dll listed in `args` to match the name of yours
5. In `.vscode\launch.json` change the `cwd` to be the path of the folder on the remote machine you want to deploy to
6. In `.vscode\launch.json` fill in `pipeArgs` with the path to your ssh key and the remote machine name

## Usage

1. Press F5!

Because the `preLaunchTask` in `.vscode\launch.json` is set to `publish`, the `publish` task from `.vscode\tasks.json` will be executed first. This task will execute `publish.bat`, trigger a `dotnet publish` (which will also build if it's not up to date) and then scp the files across to your pi. Once this is done the launch task will use ssh and remotely debug your newly deployed application using vsdbg, meaning you can drop into break points, view variable values etc all from your dev machine.
