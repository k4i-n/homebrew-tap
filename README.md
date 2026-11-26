# k4i-n/tap

Homebrew formulae for k4i-n's tools.

```sh
brew install k4i-n/tap/<formula>
```

| Formula | What it is | After install |
|---|---|---|
| [engineer-hub](https://github.com/k4i-n/engineer-hub) | Engineering dashboard kept current by your coding agents | `brew services start engineer-hub` |

## Release a new version

1. Publish a release `vX.Y.Z` in the formula's repo.
2. Open the bump PR: `brew bump-formula-pr --no-fork --url https://github.com/k4i-n/<repo>/archive/refs/tags/vX.Y.Z.tar.gz k4i-n/tap/<formula>`
3. When `brew test-bot` passes, publish the bottles: `gh workflow run publish.yml -R k4i-n/homebrew-tap -f pull_request=<PR number>`. This uploads the bottles, adds the `bottle do` block to the formula, pushes to main and closes the PR.
