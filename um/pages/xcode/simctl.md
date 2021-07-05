# simctl -- command line utility to control device simulators
{:data-section="xcode"}
{:data-date="May 06, 2021"}

## SYNOPSIS

The `simctl` command is used to manage and control the Xcode device simulators.
This command is not available directly in the standard PATH, so it must be
started via `xcrun`.

## SUBCOMMANDS

`list`
: List available devices, device types, runtimes, or device pairs.

`delete`
: Delete specified devices, unavailable devices, or all devices.

## EXAMPLES

To list all device simulators:

`xcrun simctl list devices`

To delete a specific device:

`xcrun simctl delete <device>`

To remove old devices for runtimes that are no longer supported:

`xcrun simctl delete unavailable`
