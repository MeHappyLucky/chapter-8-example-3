#
# Publishes a Docker image.
#
# Environment variables:
#
#   CONTAINER_REGISTRY - The hostname of your container registry.
#   REGISTRY_UN - User name for your container registry.
#   REGISTRY_PW - Password for your container registry.
#   VERSION - The version number to tag the images with.
#
# Usage:
#
#       ./scripts/push-image.sh
#

set -u # or set -o nounset
: "$CONTAINER_REGISTRY"
: "$VERSION"
: "$REGISTRY_UN"
: "$REGISTRY_PW"

# CONTAINER_REGISTRY may include a namespace (e.g. docker.io/<user>).
# Docker login expects the registry host only.
LOGIN_REGISTRY="$(echo "$CONTAINER_REGISTRY" | cut -d'/' -f1)"

echo "$REGISTRY_PW" | docker login "$LOGIN_REGISTRY" --username "$REGISTRY_UN" --password-stdin
docker push $CONTAINER_REGISTRY/video-streaming:$VERSION
