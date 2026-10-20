class Qlty < Formula
  desc "Code quality toolkit"
  homepage "https://qlty.sh"
  license "BUSL-1.1"
  version "0.659.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/qltysh/qlty/releases/download/v0.659.0/qlty-aarch64-apple-darwin.tar.xz"
      sha256 "32fa05fe6979037607c0a2b1c450381a5818cd744ffa205221bd37bf63499c7c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/qltysh/qlty/releases/download/v0.659.0/qlty-x86_64-apple-darwin.tar.xz"
      sha256 "1d59a4297ba2ef71292609c01b867bab7d926d62dec973720e2af797b3d8c4a5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/qltysh/qlty/releases/download/v0.659.0/qlty-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "67eb0deb1f5d2de8b47a1b41957a060fd606f4cd546da306b52d38ff6fb2da5e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/qltysh/qlty/releases/download/v0.659.0/qlty-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a1b7a4707d880030b22c4715e3a33b2e4cfe4b2ecb7e0620d4c7269dec92aeb8"
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
