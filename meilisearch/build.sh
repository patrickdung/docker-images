ARCH=arm64
#ARCH=amd64
MEILISEARCH_VERSION=v0.23.0
#MEILISEARCH_VERSION=v0.23.0rc2-rust-cross-build-2

# Official
#SOURCE_BINARY_BASEURL="https://github.com/meilisearch/MeiliSearch/releases/download"
# My fork for testing meilisearch
#SOURCE_BINARY_BASEURL="https://github.com/patrickdung/MeiliSearch/releases/download"
# Repo with scripts only for cross build
SOURCE_BINARY_BASEURL="https://github.com/patrickdung/MeiliSearch-crossbuild/releases/download"
TAG_VERSION=0.7

sudo podman run --rm --privileged multiarch/qemu-user-static --reset -p yes

buildah build-using-dockerfile \
--override-arch ${ARCH} \
--build-arg ARCH=${ARCH} \
--build-arg MEILISEARCH_VERSION=${MEILISEARCH_VERSION} \
--build-arg SOURCE_BINARY_BASEURL=${SOURCE_BINARY_BASEURL} \
-t "patrickdung/meilisearch:${TAG_VERSION}-${ARCH}"
