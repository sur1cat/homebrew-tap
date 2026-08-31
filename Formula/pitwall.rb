# This formula is replaced on every tagged release: GoReleaser rewrites it with
# the release archives and their checksums. Until the first tag exists, the
# head build below is what `brew install --HEAD sur1cat/tap/pitwall` uses.
class Pitwall < Formula
  desc "The instrument panel for a fleet of coding agents"
  homepage "https://github.com/sur1cat/pitwall"
  license "MIT"
  head "https://github.com/sur1cat/pitwall.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags)
  end

  def caveats
    <<~EOS
      pitwall reads what Claude Code already wrote to disk. Start with:

        pitwall            one screen: who is working, what today cost
        pitwall perms      which permission rules can never match
        pitwall install    add a status line to Claude Code

      Only `pitwall quota` reaches the network, and only api.anthropic.com with
      your own credential.

      The macOS menu bar app is a separate formula:

        brew install sur1cat/tap/pitwall-bar
    EOS
  end

  test do
    assert_match "pitwall", shell_output("#{bin}/pitwall version")
  end
end
