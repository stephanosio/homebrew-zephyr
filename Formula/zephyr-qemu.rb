require "formula"

class ZephyrQemu < Formula
  desc "Zephyr QEMU Target Platform Emulator"
  homepage "https://github.com/stephanosio/zephyr-qemu"
  url "https://github.com/stephanosio/zephyr-qemu/releases/download/zephyr-qemu-v5.0.0.1/zephyr-qemu-v5.0.0.1_macos-x86_64.tar.gz"
  version "5.0.0.1"
  sha256 "917a769a1c9dd9e4889e3a388f20b36d0be088fbcdc97a7ba0a3207a23b513d0"
  revision 2

  depends_on "gettext"
  depends_on "glib"
  depends_on "gnutls"
  depends_on "nettle"
  depends_on "pixman"
  depends_on "zstd"

  def install
    (prefix/"qemu").install Dir["./*"]
    Dir.glob(prefix/"qemu/bin/*") { |file| bin.install_symlink file }
  end

  test do
    expected = "QEMU emulator"

    %w[aarch64 arc arm i386 nios2 riscv32 riscv64 sparc x86_64 xtensa].each do |cmd|
      assert_match expected, shell_output("#{bin}/zephyr-qemu-system-#{cmd} --version")
    end
  end
end
