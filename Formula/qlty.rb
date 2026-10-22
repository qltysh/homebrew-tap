class Qlty < Formula
  desc "Code quality toolkit"
  homepage "https://qlty.sh"
  license "BUSL-1.1"
  version "0.661.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/qltysh/qlty/releases/download/v0.661.0/qlty-aarch64-apple-darwin.tar.xz"
      sha256 "9e21f954554d070c72343abe434d5e438b7ece4853c182bd493085538f098ed7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/qltysh/qlty/releases/download/v0.661.0/qlty-x86_64-apple-darwin.tar.xz"
      sha256 "8ced269ef9601b9b39a25e52662e51d46afa7824af3fb65162b8b65d97f3a9ce"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/qltysh/qlty/releases/download/v0.661.0/qlty-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "79d2d8f83f1ac1d39a4e856f93977122ee496199c19ab076eacb93857d9120ed"
    end
    if Hardware::CPU.intel?
      url "https://github.com/qltysh/qlty/releases/download/v0.661.0/qlty-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "fa07eb51fbb32a0854113e81ce2d957b73f1c027c58b478d32c233b6aba7a977"
    end
  end

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "aarch64-unknown-linux-gnu": {}, "aarch64-unknown-linux-musl-dynamic": {}, "aarch64-unknown-linux-musl-static": {}, "x86_64-apple-darwin": {}, "x86_64-pc-windows-gnu": {}, "x86_64-unknown-linux-gnu": {}, "x86_64-unknown-linux-musl-dynamic": {}, "x86_64-unknown-linux-musl-static": {}}

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "qlty"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "qlty"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "qlty"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "qlty"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end

  test do
    assert_match "qlty #{version}", shell_output("#{bin}/qlty --version")
    assert_match "qlty", shell_output("#{bin}/qlty --help")
  end
end
