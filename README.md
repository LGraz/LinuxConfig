# Installation
## Dual Boot with windows
in advance use `cgdisk` to partition the disk  
**Attention** Naming is important
eg:
|  |size|    code  |  name/label |          
|--------|----|----------|-------------|        
|sda5    |1M  |    ef02  |  BIOSBOOT   |       
|sda6    |300M|    ef00  |  EFIBOOT    |      
|sda8    |100G|          |  ROOT       |   


## config files
my dotfiles are in configs/config_files/*  
note that `configs/config_files/homedir` contains the files that are to be linked into `~/`.  
initialize by running: `/.link_config.sh`

## Firefox
shortcuts are introduced with [this extenstion](https://github.com/crittermike/shortkeys)
`ui.key.menuAccessKey=17` disables the alt-key for the menu-bar (supposed to be mapped to ctrl+shift)
