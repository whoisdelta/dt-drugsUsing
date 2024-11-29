## dt-drugsUsing 

# discord.gg/mdstudios


A FiveM resource that adds realistic drug effects and animations to your server.

## Features

- Multiple drug types with unique effects:
  - Heroin
  - MDMA/Ecstasy
  - And more configurable drugs
- Realistic animations for different consumption methods:
  - Smoking
  - Injecting (syringe)
  - Sniffing
  - Pills
- Overdose system with configurable limits
- Screen effects and visual distortions
- Movement modifications while under influence
- Health deterioration effects
- Easy configuration

## Installation

1. Download the resource
2. Place it in your resources folder
3. Add `ensure dt-drugsUsing` to your server.cfg
4. Configure the drugs in `config.lua` to your liking

## Configuration

You can easily add new drugs or modify existing ones in the `config.lua` file. Each drug can have:

- Custom name and description
- Weight value
- Consumption type (smoke/syringe/sniff/pill)
- Maximum usage limit (until overdose)
- Effect duration
- Custom effect function

## Usage

Just trigger the event with the drug name:

```lua
TriggerEvent('dt-useDrug', 'drugName (Look in config.lua)');
```
