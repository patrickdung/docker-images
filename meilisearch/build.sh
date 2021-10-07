ARCH=arm64
#ARCH=amd64
MEILISEARCH_VERSION=v0.23.0rc2
TAG_VERSION=0.5

sudo podman run --rm --privileged multiarch/qemu-user-static --reset -p yes

buildah build-using-dockerfile \
--override-arch ${ARCH} \
--build-arg ARCH=${ARCH} --build-arg MEILISEARCH_VERSION=${MEILISEARCH_VERSION} \
-t "patrickdung/meilisearch:${TAG_VERSION}-${ARCH}"
