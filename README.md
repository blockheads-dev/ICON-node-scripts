# ICON-node-scripts
###### Often used scripts by Blockheads Development System Administration

##### This repository is to share growing collection of scripts used by System Administration at Blockheads Development

### Included in this repository
* /custom-commands/ - a growing collection of scripts added to the PATH of our OS, as to be called at anytime
* /telegram-alert-monitor - a Telegram monitor to alert us of failure or possible stuck blocks.

# Custom commands
## Installation:
Copy the contents of '/bin/' to your profile '~/bin/'  
If you do not have a ~/bin/ set up, make a directory called 'bin' in the root of your user directory.  
Then add ~/bin/ to your PATH variable.

For more information, a google search on "Linux add directory to PATH variable" should be helpful.

# Telegram Alert Monitor
## Installation:
Copy the entire directory to a directory of your choice.  
After copying, simply fill out the config.ini with your preferences.  
Run the failure_notify.sh

There are many ways to keep the script running in the background from the terminal. One way is to use the 'screen' command. Another would be to send the process to the background.

## Dependencies:
You need both 'curl' and 'jq' installed on your machine.  
If you do not already have these installed, simply run the commands below.

```bash
sudo apt update
sudo apt install curl jq -y
```
