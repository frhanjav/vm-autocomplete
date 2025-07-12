# VM Zsh Setup Script

Quickly install and configure zsh with autosuggestions on any Linux VM. Sets up intelligent command suggestions (gray text) based on your command history.

### Step 1:

```bash
TERM=xterm nano setup-zsh.sh
```

you wouldnt get any issues even when you use ghostty

### Step 2:

make it executable and run it

```bash
chmod +x setup-zsh.sh && ./setup-zsh.sh
```

restart SSH to make zsh your default

### To verify:

```bash
echo $SHELL
# shows your login shell (default)
echo $0
# shows your *current* shell process
```
