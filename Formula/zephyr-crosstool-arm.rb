require 'formula'

class ZephyrCrosstoolArm < Formula
    desc "ARM AArch32 (Cortex-A/R/M) Cross Compiler Toolchain (arm-zephyr-eabi)"
    homepage 'https://github.com/stephanosio/zephyr-crosstool-ng'
    version '1.24.0.2'

    url 'https://github.com/stephanosio/zephyr-crosstool-ng/releases/download/zephyr-crosstool-ng-1.24.0.2/zephyr-crosstool-ng-1.24.0.2_macos-x86_64_arm-zephyr-eabi.tar.gz'
    sha256 'd4de6252c9766801ef8ac4832650b4affbb2a035adceb34c131d6a08a8246384'

    def install
        (prefix).install Dir["./*"]
        Dir.glob(prefix/"arm-zephyr-eabi/bin/*") { |file| bin.install_symlink file }
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
          "strip"
      ].each { |cmd|
          assert_match expected, shell_output("#{bin}/arm-zephyr-eabi-#{cmd} --version")
      }
    end
end
