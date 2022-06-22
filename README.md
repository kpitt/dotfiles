# Personal Dotfiles

These are my personal home-directory dotfiles, managed by [chezmoi](https://www.chezmoi.io). This configuration is currently used only on macOS. Much of it would probably apply on Linux also, and some might even be usable on Windows, but this is untested.

## Installing

1. Open a Terminal window and run the bootstrap script. Follow the prompts to install Homebrew and the basic packages needed to initialize the home-directory with `chezmoi`.

    ```sh
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/kpitt/dotfiles/chezmoi/init.sh)"
    ```

2. If Homebrew was not already installed, run this `eval` command to ensure that the Homebrew directory is in the PATH. Check the sample command shown at the end of the Homebrew installation, because the actual path to the `brew` command depends on the CPU type (Intel or Apple Silicon).

    ```sh
    eval "$(/opt/homebrew/bin/brew shellenv)"
    ```

3. Launch "1Password" and sign in, then go to "Preferences -> Developer" and enable the "Use the SSH agent" and "Biometric unlock for 1Password CLI" options.
4. Create a shortcut to the 1Password SSH auth socket (note that this command is all one line).

    ```sh
    mkdir -p ~/.1password && ln -s ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock ~/.1password/agent.sock
    ```

5. Set the `SSH_AUTH_SOCK` environment variable so Git will use the 1Password SSH agent.

    ```sh
    export SSH_AUTH_SOCK=~/.1password/agent.sock
    ```

6. Run the `init_age.sh` bootstrap script to install the identity file for `age` encryption.

    ```sh
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/kpitt/dotfiles/chezmoi/init_age.sh)"
    ```

7. Initialize the `chezmoi` configuration and download the dotfiles repository.

    ```sh
    chezmoi init kpitt -S ~/.dotfiles --branch chezmoi --ssh
    ```

8. Edit the file `~/.config/chezmoi/chezmoi.toml` and confirm the settings, or modify them as needed.
9. Apply the `chezmoi` configuration to the home-directory.

    ```sh
    chezmoi apply
    ```

10. After `chezmoi apply` completes successfully, close the terminal window and restart the machine to make sure that any updates to the system settings take effect.