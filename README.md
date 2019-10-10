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
Inspired by everstake's notifier https://github.com/everstake/icon-botnotificator/blob/master/notifier.sh
## Installation:
Copy the entire directory to a directory of your choice.  
After copying, simply fill out the config.ini with your preferences.  
Run the failure_notify.sh

Note: The script will create a file called 'data' that it uses to store the "last message state" so as to not repetitively send messages. It will send a message ONCE until it has a different message to send. It does not repeat alerts. 

There are many ways to keep the script running in the background from the terminal. One way is to use the 'screen' command. Another would be to send the process to the background.

## Dependencies:
You need both 'curl' and 'jq' installed on your machine.  
If you do not already have these installed, simply run the commands below.

```bash
sudo apt update
sudo apt install curl jq -y
```
