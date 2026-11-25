class Qlty < Formula
  desc "Code quality toolkit"
  homepage "https://qlty.sh"
  license "BUSL-1.1"
  version "0.674.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/qltysh/qlty/releases/download/v0.674.0/qlty-aarch64-apple-darwin.tar.xz"
      sha256 "c74250b3c9bcff0fcfe7b3a4197064d4d0991082e122de41659bdd240095c9b0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/qltysh/qlty/releases/download/v0.674.0/qlty-x86_64-apple-darwin.tar.xz"
      sha256 "65e0cddda1860688d689a80755ae628c176a3d925c5e53f8062175e97fecbdb3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/qltysh/qlty/releases/download/v0.674.0/qlty-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "fd7e186fa999612fc925592089d43115097b445c4dbea7cd41b7a4df0dbb71d1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/qltysh/qlty/releases/download/v0.674.0/qlty-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "dab85546a700ed5e7529ac9e1e87e4dde11c1f92cb8d3b7c7c16585dc69b9664"
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
