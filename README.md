# pibakery-blocks

PiBakery is a program that allows super-easy presetup of Raspberry Pi SD cards. Customisation is done using a Scratch-style interface, where each block represents a script to run on startup.

Anyone can create and add new blocks to PiBakery, meaning that if there's a setup task you always do to a new Raspbian install, or if you have some software you'd like everyone to be able to easily add to their Pi, you can create a block, and people can just drag that block into their setup script to run your code! Anyone can create a block, and once it's been added to this GitHub repo, everyone running PiBakery will automatically get the newly added block.

### Creating a PiBakery block

There are two steps to creating a new PiBakery block. First is to define what the block looks like and what inputs it has. An example would be the wificonnect block:

```javascript
{
	"name": "wifisetup",
	"text": "Setup WiFi\\nNetwork: %1\\nPass: %2",
	"script": "wifiConnect.py",
	"args": [
		{
			"type": "field",
			"default": "network-name"
		},
		{
			"type": "field",
			"default": "network-password"
		}
	],
	"reboot": false,
	"continue": true,
	"type": "network"
}
```
This example shows the JSON format for creating a new block. ```name``` is used to define the name of the block, ```text``` is the actual text on the block, and within ```text```, ```\\n``` means a new line, ```%1``` means argument 1, ```%2``` means argument 2 and so on. ```script``` defines the name of the script to run, with the arguments from the block being passed as command line arguments.

```args``` is used to define the type, and placeholder, of each argument for the block. There are two types: ```field``` and ```menu```. An example for a ```menu``` argument can be seen for the [bootbehaviour block](https://github.com/davidferguson/pibakery-blocks/blob/master/bootbehaviour/bootbehaviour.json). For ```menu``` arguments, you need to provide a list of ```options``` that the user can choose, and for a ```field``` argument, you need to provide a ```default``` text string for that argument.

Once you have defined your block, the next stage is to create the script that runs the code on the Raspberry Pi for that block. Create a file with the same name as defined in your block specification, and in that file place the code you want to run. The arguments that you defined for your block are passed as command line arguments into your script. It's as simple as that!

Once you've made (and tested!) you're block - send it to me! I'll add it to this repository, and it'll then automatically get added to everyone who's using PiBakery!
