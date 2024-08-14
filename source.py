import decman
from decman import File, Directory

# Declare installed packages
decman.packages += [
        "python", 
        "git", 
        "networkmanager", 
        "neovim"
        ]

# Declare installed aur packages
# decman.aur_packages += ["protonvpn"]

# Declare configuration files
# Inline
# decman.files["/etc/vconsole.conf"] = File(content="KEYMAP=us")
# From files within your repository
# decman.files["/etc/pacman.conf"] = File(source_file="./dotfiles/pacman.conf")

# Declare a whole directory
# decman.directories["/home/user/.config/nvim"] = Directory(source_directory="./dotfiles/nvim", owner="user")

# Ensure that a systemd unit is enabled.
decman.enabled_systemd_units += ["NetworkManager.service"]
