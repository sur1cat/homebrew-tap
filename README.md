# sur1cat/homebrew-tap

Homebrew formulae for [pitwall](https://github.com/sur1cat/pitwall).

```sh
brew tap sur1cat/tap
brew install pitwall            # the command line tool
brew install pitwall-bar        # the macOS menu bar panel, built locally
```

Or without tapping first:

```sh
brew install sur1cat/tap/pitwall
```

## Why a tap rather than homebrew-core

`brew install pitwall` with no tap requires the formula to live in
homebrew-core, which only accepts projects that are already widely used — the
guideline is on the order of 75 stars, forks or watchers, plus a track record of
maintained releases. A tap needs nobody's approval and installs the same way
after one `brew tap`.

## How these files are maintained

`Formula/pitwall.rb` is rewritten by GoReleaser on every tagged release of the
main repository, with the release archives and their checksums filled in. Do not
edit it by hand; edit the `brews:` block in `.goreleaser.yaml` there instead.

`Formula/pitwall-bar.rb` is maintained here, because it builds from source and
has no release artefacts to point at.
