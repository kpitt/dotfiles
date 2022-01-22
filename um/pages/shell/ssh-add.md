# ssh-add -- manage private key identities in the ssh authentication agent
{:data-section="shell"}
{:data-date="January 21, 2022"}

## SYNOPSIS

`ssh-add` [`-ADdKl`] [*file* *...*]

## OPTIONS

`-K`, `--apple-use-keychain`
: Stores passphrases in the user's keychain when adding identities.

`-A`, `--apple-load-keychain`
: Adds the identities for all passphrases stored in the user's keychain.
  An identity will be ignored if the stored passphrase is incorrect.

`-d`
: Deletes an identity from the agent.
  With `-K`, it will also remove the passphrase from the keychain.

`-D`
: Deletes all identities from the agent.

`-l`
: Lists the identities currently loaded into the agent.

## EXAMPLES

Load a specific identity file using the passphrase stored in the keychain,
or prompt for and store the passphrase if it is missing or incorrect:

    /usr/bin/ssh-add -K ~/.ssh/id_rsa

Load all identities that have correct passphrases already stored in the
keychain:

    /usr/bin/ssh-add -A

## COMPATIBILITY

The keychain options are specific to the Apple-provided `ssh-add`, so use
the full path `/usr/bin/ssh-add` to make sure you don't pick up a different
version.

The `--apple-use-keychain` and `--apple-load-keychain` options are new in
macOS 12, and using the `-K` and `-A` options will result in a prominent
deprecation warning message about the old option names.  You can suppress the
warning and ensure the expected behavior on macOS 12 by first setting the
APPLE_SSH_ADD_BEHAVIOR environment variable to "macos".  The environment
variable will have no effect in older macOS versions, so it can be set to
ensure compatibility across versions.

    export APPLE_SSH_ADD_BEHAVIOR=macos
    /usr/bin/ssh-add -K ~/.ssh/id_rsa

## TIPS

Use `ssh-keygen` to change the passphrase on a private key:

    ssh-keygen -p -f ~/.ssh/id_rsa

After changing the passphrase, you might want to re-add the identity with
`ssh-add -K` to update the stored passphrase.
