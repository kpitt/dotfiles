# Add PATH entries after all other shell initialization is complete.
# Use this for entries that may depend on previous configuration,
# or for prepending entries that need to have the highest precedence.

# Rust
if [[ -r "$HOME"/.cargo/env ]]; then
  source "$HOME"/.cargo/env
  alias ci="cargo install --path . --force"
fi

# mkdir .git/safe in the root of repositories you trust
PATH=".git/safe/../../bin:$PATH"

export -U PATH
