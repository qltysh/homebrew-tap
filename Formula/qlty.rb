class Qlty < Formula
  desc "Code quality toolkit"
  homepage "https://qlty.sh"
  license "BUSL-1.1"
  version "0.655.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/qltysh/qlty/releases/download/v0.655.0/qlty-aarch64-apple-darwin.tar.xz"
      sha256 "3d0c462987a41e514957f5776427eea6419224d60c3c47d85fef8ccc61f1ab43"
    end
    if Hardware::CPU.intel?
      url "https://github.com/qltysh/qlty/releases/download/v0.655.0/qlty-x86_64-apple-darwin.tar.xz"
      sha256 "faf596bdfda2abd8c21ad7340c074a7325105ea8235d01a24a9eac5d6b098dd9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/qltysh/qlty/releases/download/v0.655.0/qlty-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6adaa0fd5aee9b277d9a20f58c2bf982ea6e0e99a9d1b780a03b5fdcb607c3b2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/qltysh/qlty/releases/download/v0.655.0/qlty-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d05d8e68aaa9f0f7434094d16a6cd37682511b55640625e0681257f4650db47f"
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
