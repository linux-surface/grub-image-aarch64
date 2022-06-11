ARG repo="https://github.com/linux-surface/grub.git"
ARG ref="grub-2.06"


# build stage
FROM fedora:latest as build

RUN dnf update -y                       \
    && dnf install -y                   \
        make                            \
        rpmdevtools                     \
        gcc-aarch64-linux-gnu           \
        python                          \
        "dnf-command(builddep)"         \
    && dnf builddep -y grub2

ARG repo
ARG ref
RUN git clone "${repo}" grub            \
    && cd grub                          \
    && git checkout "${ref}"

RUN cd grub                             \
    && ./bootstrap                      \
    && ./configure                      \
        HOST_CPPFLAGS="-I$(pwd)"        \
        TARGET_CPPFLAGS="-I$(pwd)"      \
        --with-platform="efi"           \
        --program-prefix="aarch64-"     \
        --disable-werror                \
        --disable-rpm-sort              \
        --target="aarch64-linux-gnu"

RUN cd grub && make -j $(nproc)

RUN cd grub && make DESTDIR="${PWD}/../install" install


# application stage
FROM fedora:latest as env

RUN dnf update -y                       \
    && dnf install -y                   \
        gettext file mtools

COPY --from=build install/ /

CMD /bin/bash
