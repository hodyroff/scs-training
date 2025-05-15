#!/bin/bash

REPO="registry.scs.community/kaas/cluster-stacks"
DEST_DIR="./cluster-stacks-tmp"

# Check dependencies
command -v oras >/dev/null 2>&1 || { echo >&2 "oras not found. Install it first."; exit 1; }
command -v yq >/dev/null 2>&1 || { echo >&2 "yq not found. Install it first."; exit 1; }

mkdir -p "$DEST_DIR"

# Array to hold the output rows
declare -a rows
rows+=("infrastructure | ClusterStack.spec.kubernetesVersion | ClusterStack.spec.versions | k8sCluster.topology.version_minor")  # Header row

# Get list of tags (skip header line)
tags=$(oras repo tags "$REPO" | tail -n +2)

for tag in $tags; do
  echo "Pulling: $REPO:$tag"
  target_dir="$DEST_DIR/$tag"
  mkdir -p "$target_dir"

  if ! oras pull "$REPO:$tag" -o "$target_dir"; then
    echo "Failed to pull $tag" >&2
    continue
  fi

  metadata_file="$target_dir/metadata.yaml"
  if [[ -f "$metadata_file" ]]; then
    kubernetes=$(yq e '.versions.kubernetes' "$metadata_file")
    clusterstack=$(yq e '.versions.clusterStack' "$metadata_file")
    k8s_minor=$(echo "$kubernetes" | sed -E 's/v?([0-9]+\.[0-9]+)\..*/\1/')
    infrastructure=$(echo "$tag" | cut -d'-' -f1)

    rows+=("${infrastructure} | ${kubernetes} | ${clusterstack} | ${k8s_minor}")
  else
    echo "No metadata.yaml found in $tag" >&2
  fi
done

# Print all collected output at the end
echo
for row in "${rows[@]}"; do
  echo "$row"
done

rm -rf "$DEST_DIR"
