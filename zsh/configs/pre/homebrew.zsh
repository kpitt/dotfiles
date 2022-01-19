# Configure Homebrew before the rest of the configuration to ensure that
# all brew-installed utilities are available.

# Opt out of Homebrew analytics.
export HOMEBREW_NO_ANALYTICS=1
# Only run autoupdate once a day.
export HOMEBREW_AUTOUPDATE_SECS=86400
# Use `bat` for the `brew cat` command.
export HOMEBREW_BAT=1
# Disable additional hints about environment config.
export HOMEBREW_NO_ENV_HINTS=1

# Initialize Homebrew depending on Intel or Apple Silicon
if command -v /opt/homebrew/bin/brew > /dev/null; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/usr/local/bin/brew shellenv)"
fi
