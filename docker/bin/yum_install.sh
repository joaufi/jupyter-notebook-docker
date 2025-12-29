#!/usr/bin/env bash
set -e

yum install -y sudo

# Install dependencies
sudo yum install -y git-core make gcc zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel tk-devel libffi-devel xz

# Clean up
sudo yum clean all
rm -rf /var/cache/yum
