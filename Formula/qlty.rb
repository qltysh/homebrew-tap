class Qlty < Formula
  desc "Code quality toolkit"
  homepage "https://qlty.sh"
  license "BUSL-1.1"
  version "0.667.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/qltysh/qlty/releases/download/v0.667.0/qlty-aarch64-apple-darwin.tar.xz"
      sha256 "aba6c72624ed071971b4f0f8b99410bf60d0aadd1f4572e68d0ad7faa5b1970d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/qltysh/qlty/releases/download/v0.667.0/qlty-x86_64-apple-darwin.tar.xz"
      sha256 "e1e5ca82db94f0929d15964c4023dd421ab6236c711ccbe5de9486d43b440903"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/qltysh/qlty/releases/download/v0.667.0/qlty-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "33b071ccc78f8af5fe5e351b21b275f39309d3cb1f89930caee63d1f29e60089"
    end
    if Hardware::CPU.intel?
      url "https://github.com/qltysh/qlty/releases/download/v0.667.0/qlty-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ed85387153e75ef18631b8cc187daac9368ba2ef19fc8a9dbd972206fc6b326c"
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
