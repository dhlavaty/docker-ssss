# ssss Docker Image

## Description

Small docker image with ssss (Shamir's secret sharing scheme) based on Alpine linux.

`ssss` tool is used. For more info see http://point-at-infinity.org/ssss/index.html

## What is "Secret Sharing"?

In cryptography, a secret sharing scheme is a method for distributing a secret amongst a group of participants, each of which is allocated a share of the secret. The secret can only be reconstructed when the shares are combined together; individual shares are of no use on their own.

More formally, in a secret sharing scheme there is one dealer and n players. The dealer gives a secret to the players, but only when specific conditions are fulfilled. The dealer accomplishes this by giving each player a share in such a way that any group of t (for threshold) or more players can together reconstruct the secret but no group of less than t players can. Such a system is called a (t,n)-threshold scheme.

## Usage

For `ssss` man page see http://point-at-infinity.org/ssss/ssss.1.html

### Split secret

To split my "`This is my password`" string to 5 shares, with 3 needed to reconstruct the secret:

```sh
$ echo 'This is my password' | docker run --rm -i dhlavaty/ssss:latest ssss-split -t 2 -n 3

# Generating shares using a (3,5) scheme with dynamic security level.
# Enter the secret, at most 128 ASCII characters:
# Using a 152 bit security level.
# 1-3bbc1b2a3af9a277d95363e3b3f9991a4a59f9
# 2-fe904b5c86b6e77ebeedbe97f4a8c535cebc6c
# 3-f144d29e0bc116487140d9c9bcc4f8a57853c8
# 4-f4def9447aa262769bfca2b39a7b0d8de7f71b
# 5-fb0a6086f7d593405451c5edd217301d5118ad
```

### Reconstruct secret

To reconstruct your secret from any 3 shares:

```sh
$ docker run --rm -i dhlavaty/ssss:latest ssss-combine -t 3

# Enter 3 shares separated by newlines:
# Share [1/3]: 4-f4def9447aa262769bfca2b39a7b0d8de7f71b
# Share [2/3]: 3-f144d29e0bc116487140d9c9bcc4f8a57853c8
# Share [3/3]: 1-3bbc1b2a3af9a277d95363e3b3f9991a4a59f9
# Resulting secret: This is my password
```

## Docker build

Build multi-arch image:

```sh
$ docker buildx create --name mybuilder
$ docker buildx use mybuilder

# (Optional) check your builder
$ docker buildx inspect

$ docker buildx build --platform linux/amd64,linux/arm64 --tag dhlavaty/ssss . --push

# (Optional) Inspect your image
$ docker buildx imagetools inspect dhlavaty/ssss
```

Lint dockerfile:

```sh
$ docker run --rm -i hadolint/hadolint < Dockerfile
```

## License

This project is licensed under MIT - http://opensource.org/licenses/MIT
