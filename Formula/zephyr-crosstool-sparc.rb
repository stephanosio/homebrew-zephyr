require "formula"

class ZephyrCrosstoolSparc < Formula
  desc "SPARC Cross Compiler Toolchain"
  homepage "https://github.com/stephanosio/zephyr-crosstool-ng"
  url "https://github.com/stephanosio/zephyr-crosstool-ng/releases/download/zephyr-crosstool-ng-1.24.0.4/zephyr-crosstool-ng-1.24.0.4_macos-x86_64_sparc-zephyr-elf.tar.gz"
  version "1.24.0.4"
  sha256 "deed77f333d579c114fb876892c66d191a4fc33b0fc79c0d2cdd28bb36ce9c17"
  revision 2

  depends_on "boost"
  depends_on "xz"

  def install
    prefix.install Dir["./*"]
    Dir.glob(prefix/"sparc-zephyr-elf/bin/*") { |file| bin.install_symlink file }
  end

  test do
    expected = "(zephyr-crosstool-NG 1.24.0.4)"

    [
      "addr2line",
      "ar",
      "as",
      "c++",
      "c++filt",
      "cc",
      "cpp",
      "elfedit",
      "g++",
      "gcc",
      "gcc-9.2.0",
      "gcc-ar",
      "gcc-nm",
      "gcc-ranlib",
      "gcov",
      "gcov-dump",
      "gcov-tool",
      "gdb",
      "gprof",
      "ld",
      "ld.bfd",
      "nm",
      "objcopy",
      "objdump",
      "ranlib",
      "readelf",
      "size",
      "strings",
      "strip",
    ].each do |cmd|
      assert_match expected, shell_output("#{bin}/sparc-zephyr-elf-#{cmd} --version")
    end
  end
end
