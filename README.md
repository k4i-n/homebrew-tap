# k4i-n/tap

Homebrew formulae for [engineer-hub](https://github.com/k4i-n/engineer-hub).

```sh
brew install k4i-n/tap/engineer-hub
brew services start engineer-hub
```

## Release a new version

1. Publish a release `vX.Y.Z` in engineer-hub.
2. Open the bump PR: `brew bump-formula-pr --no-fork --url https://github.com/k4i-n/engineer-hub/archive/refs/tags/vX.Y.Z.tar.gz k4i-n/tap/engineer-hub`
3. When `brew test-bot` passes, publish the bottles: `gh workflow run publish.yml -R k4i-n/homebrew-tap -f pull_request=<PR number>`. This uploads the bottles, adds the `bottle do` block to the formula, pushes to main and closes the PR.
