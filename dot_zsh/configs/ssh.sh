# Ensure compatible behavior if on macOS 12+
export APPLE_SSH_ADD_BEHAVIOR=macos

# Load ssh keys into auth agent for Git authentication
ssh-add -K ~/.ssh/id_rsa ~/.ssh/id_ed25519 2> /dev/null
