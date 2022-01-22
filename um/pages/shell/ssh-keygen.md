# ssh-keygen -- generate and modify ssh authentication keys
{:data-section="shell"}
{:data-date="January 21, 2022"}

## SYNOPSIS

`ssh-keygen` [`-q`] [`-b` *bits*] [`-C` *comment*]
  [`-f` *output_keyfile*] [`-t` *key_type*]

`ssh-keygen -p` [`-f` *keyfile*]

`ssh-keygen -y` [`-f` *input_keyfile*]

`ssh-keygen -c` [`-C` *comment*] [`-f` *keyfile*]

`ssh-keygen -l` [`-f` *input_keyfile*]

## OPTIONS

`-b` *bits*
: Specifies the number of bits in the key to create.

`-C`
: Provides a new comment.

`-c`
: Changes the comment in the private and public key files.

`-f` *keyfile*
: Specifies the filename of the key file.

`-l`
: Prints the fingerprint of the specified public key file.

`-p`
: Changes the passphrase of an existing private key file.

`-q`
: Silence informational messages from `ssh-keygen`.

`-t` `ed25519` | `rsa`
: Specifies the type of key to create. Types "dsa" and "ecdsa" are also
  valid, but are considered to be less secure.

## EXAMPLES

Change the passphrase on a private key:

    ssh-keygen -p -f ~/.ssh/id_rsa

Change the comment for an identity:

    ssh-keygen -c -C "new comment" -f ~/.ssh/id_rsa

Extract the public key from a private key:

    ssh-keygen -y -f ~/.ssh/id_rsa > ~/.ssh/id_rsa.pub
