class FreeeClock < Formula
  desc "Menu bar app that clocks you in and out on freee HR"
  homepage "https://github.com/k4i-n/freee-clock"
  url "https://github.com/k4i-n/freee-clock/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "26e67b52f7c460c1002ae71c70d463b8d354916c56b2decbbed1b70d3d532e8c"
  license "MIT"

  depends_on macos: :monterey

  def install
    system "swiftc", "-O", "freee.swift", "-o", "freee"
    bin.install "freee"
  end

  def caveats
    <<~EOS
      Start the menu bar app and keep it running at login:
        brew services start freee-clock
      If you installed with install.sh before, run `install.sh uninstall` first.
    EOS
  end

  service do
    run [opt_bin/"freee", "bar"]
    keep_alive true
    process_type :interactive
    log_path var/"log/freee-clock.log"
    error_log_path var/"log/freee-clock.log"
  end

  test do
    system bin/"freee", "selftest"
  end
end
