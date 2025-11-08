# Add ~/.local/bin to PATH
$env.PATH = ($env.PATH | prepend $"($env.HOME)/.local/bin")
