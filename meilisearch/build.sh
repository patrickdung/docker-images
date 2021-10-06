ARCH=arm64
#ARCH=amd64
MEILISEARCH_VERSION=v0.23.0rc0
TAG_VERSION=0.4

buildah build-using-dockerfile \
--override-arch ${ARCH} \
--build-arg ARCH=${ARCH} --build-arg MEILISEARCH_VERSION=${MEILISEARCH_VERSION} \
-t "patrickdung/meilisearch:${TAG_VERSION}-${ARCH}"
