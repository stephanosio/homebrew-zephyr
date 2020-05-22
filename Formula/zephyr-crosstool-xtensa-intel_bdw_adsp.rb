require "formula"

class ZephyrCrosstoolXtensaIntelBdwAdsp < Formula
  desc "Xtensa Cross Compiler Toolchain"
  homepage "https://github.com/stephanosio/zephyr-crosstool-ng"
  url "https://github.com/stephanosio/zephyr-crosstool-ng/releases/download/zephyr-crosstool-ng-1.24.0.2/zephyr-crosstool-ng-1.24.0.2_macos-x86_64_xtensa-intel_bdw_adsp_zephyr-elf.tar.gz"
  version "1.24.0.2"
  sha256 "6c0ae358fe36c23853c07befb2781eeba4783adc31c78d802197d7ea425856c1"
  revision 1

  depends_on "python"
  depends_on "xz"

  def install
    prefix.install Dir["./*"]
    Dir.glob(prefix/"xtensa-intel_bdw_adsp_zephyr-elf/bin/*") { |file| bin.install_symlink file }
  end

  test do
    expected = "(zephyr-crosstool-NG 1.24.0.2)"

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
      assert_match expected, shell_output("#{bin}/xtensa-intel_bdw_adsp_zephyr-elf-#{cmd} --version")
    end
  end
end
