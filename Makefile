# bind system directories with aufs2?
# this is experimental, not enabled by default
include config.mk

all: ${ROOT}
	${MAKE} run

run:
	cd ${ROOT} && sudo shell/run ${ARCH} ${AUFS}

base/shell/qemu-${ARCH}:
	./build-qemu.sh

${ROOT}: base/shell/qemu-${ARCH}
	@./setup-rootfs
	@cp -f build-qemu/qemu-1.3.1/${ARCH}-linux-user/qemu-${ARCH} ${ROOT}/shell

clean:
	# TODO: cleanup all use reference
	@echo Nothing changed. Try 'make mrproper' to remove current rootfs

mrproper:
	rm -rf rootfs build-qemu
	#cd ${ROOT} && rm -rf `ls | grep -v shell`

.PHONY: all ${ROOT} install clean mrproper
