# xattr -- display and manipulate extended attributes
{:data-section="shell"}
{:data-date="June 05, 2020"}

## SYNOPSIS

The `xattr` command is used to display or modify the MacOS extended attributes
on a file.

## OPTIONS

`-d` *attr_name*
: remove the given attribute

`-r`
: operate recursively on directory contents

## EXAMPLES

To display the extended attributes of a file:

`xattr /path/to/my_file.sh`

To remove an attribute from a file:

`xattr -d attribute.id /path/to/my_file.sh`

To remove an attribute from all files in a directory (e.g. an application
package):

`xattr -d -r attr_name /path/to/MyApp.app`

## TIPS

If you get an error message like the following when you try to execute a shell
script, then you probably need to remove the `com.apple.quarantine` attribute.

`zsh: operation not permitted: ./my_script.sh`
