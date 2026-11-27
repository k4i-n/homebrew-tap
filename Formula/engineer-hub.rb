class EngineerHub < Formula
  desc "Local work record for an engineer's tickets, read and written by coding agents"
  homepage "https://github.com/k4i-n/engineer-hub"
  url "https://github.com/k4i-n/engineer-hub/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "6ded6c6f7956a456a38db2ab6fe2ed66f5ab3ef7e12ce0df0a935c37db5448f1"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/k4i-n/homebrew-tap/releases/download/engineer-hub-0.1.4"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "c53c923cf165daf50eb86825b525afee9eb2acc5f1b228339540abfa57189426"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3d762940466ccd8a2b0c88e4a30b641116a5492983922e3fb4dbc8064e03816d"
  end

  depends_on "node"

  def install
    libexec.install "src", "package.json"
    pkgshare.install "examples"
    (bin/"hub").write <<~SH
      #!/bin/sh
      exec "#{formula_opt_bin("node")}/node" "#{opt_libexec}/src/cli.ts" "$@"
    SH
  end

  def caveats
    <<~EOS
      Start hub serve with brew services, not `hub service install`:
        brew services start engineer-hub
      The database is ~/.hub/hub.db. Script source examples are in:
        #{opt_pkgshare}/examples
    EOS
  end

  service do
    run [opt_bin/"hub", "serve"]
    keep_alive true
    environment_variables PATH: std_service_path_env
    log_path var/"log/engineer-hub.log"
    error_log_path var/"log/engineer-hub.log"
  end

  test do
    ENV["HUB_DB"] = testpath/"hub.db"
    port = free_port
    ENV["HUB_URL"] = "http://127.0.0.1:#{port}"
    server = spawn bin/"hub", "serve", "--port", port.to_s
    begin
      30.times do
        break if quiet_system "curl", "-sf", "-o", File::NULL, "#{ENV["HUB_URL"]}/"

        sleep 0.5
      end
      system bin/"hub", "ticket-new", "BREW-1", "brew test"
      assert_match "BREW-1", shell_output("#{bin}/hub board")
    ensure
      Process.kill("TERM", server)
      Process.wait(server)
    end
  end
end
