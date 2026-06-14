# homebrew-bar

Homebrew tap for [Beyond All Reason](https://www.beyondallreason.info/) on macOS
(Apple Silicon), distributing the [bar-lobby](https://github.com/ExaDev/bar-lobby)
client with its bundled patched engine.

## Install

```sh
brew tap ExaDev/bar
brew install --cask bar-lobby
```

The app is ad-hoc signed, not notarised, so on first launch Gatekeeper will
block it. Clear the quarantine flag once after installing:

```sh
xattr -dr com.apple.quarantine "/Applications/BeyondAllReason.app"
```

## Status

The `bar-lobby` cask is a scaffold: it becomes installable once
`ExaDev/bar-lobby` publishes its first macOS `.dmg` release, at which point the
cask's `version` and `sha256` are populated (manually, via `brew bump-cask-pr`,
or an auto-bump workflow).

Requirements: Apple Silicon Mac. GPU rendering (Mesa Zink → KosmicKrisp → Metal)
needs macOS 26 (Tahoe).
