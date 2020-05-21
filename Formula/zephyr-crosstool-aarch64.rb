require 'formula'

class ZephyrCrosstoolAarch64 < Formula
    desc "ARM AArch64 Cross Compiler Toolchain (aarch64-zephyr-elf)"
    homepage 'https://github.com/stephanosio/zephyr-crosstool-ng'
    version '1.24.0.2'

    url 'https://github.com/stephanosio/zephyr-crosstool-ng/releases/download/zephyr-crosstool-ng-1.24.0.2/zephyr-crosstool-ng-1.24.0.2_macos-x86_64_aarch64-zephyr-elf.tar.gz'
    sha256 '352892f41958c9ed558884acac5452515a467141be0c572fab4ce47e970f8829'

    def install
        (prefix).install Dir["./*"]
        Dir.glob(prefix/"aarch64-zephyr-elf/bin/*") { |file| bin.install_symlink file }
    end
end
