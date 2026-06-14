# homebrew-bar

Homebrew tap for [Beyond All Reason](https://www.beyondallreason.info/) on macOS
(Apple Silicon), distributing the [bar-lobby](https://github.com/ExaDev/bar-lobby)
client with its bundled patched engine.

## Install

```sh
brew tap ExaDev/bar
brew install --cask bar
```

The app is ad-hoc signed, not notarised, so on first launch Gatekeeper will
block it. Clear the quarantine flag once after installing:

```sh
xattr -dr com.apple.quarantine "/Applications/Beyond All Reason.app"
```

Upgrade later with `brew upgrade --cask bar`.

## Status

The `bar` cask's `version` and `sha256` are bumped automatically on each
`ExaDev/bar-lobby` release by that repo's `update-cask` job, which rewrites those
two lines and pushes here via a scoped SSH deploy key (this tap has no workflows
of its own).

Requirements: Apple Silicon Mac. GPU rendering (Mesa Zink → KosmicKrisp → Metal)
needs macOS 26 (Tahoe).
