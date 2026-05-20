# cognitive-os/homebrew-tap

Homebrew tap for [Sci](https://github.com/cognitive-os/sci) — a sovereign
cognitive interface that acts as a local privacy proxy for AI traffic.

## Installation

```sh
brew tap cognitive-os/tap
brew install sci
```

This installs the `sci-helper` binary into your Homebrew prefix (`$(brew --prefix)/bin/sci-helper`).

## What it installs

`sci-helper` is the Sci engine binary — a long-running Rust process that:

- Intercepts AI API traffic on your machine (via macOS Network Extension)
- Anonymises personally-identifiable information before it leaves your device
- Recalls relevant context from your local memory store (`~/.sci/`)
- Forwards anonymised requests to upstream AI providers and deanonymises responses

The binary supports both Apple Silicon (`aarch64-apple-darwin`) and Intel
(`x86_64-apple-darwin`) Macs. Homebrew selects the correct architecture
automatically at install time.

## Updating

```sh
brew update && brew upgrade sci
```

## Uninstalling

```sh
brew uninstall sci
brew untap cognitive-os/tap
```

The `~/.sci/` directory (which contains your local memory store and CA
certificate) is intentionally left in place on uninstall. Remove it manually
if you want a clean slate:

```sh
rm -rf ~/.sci
```
