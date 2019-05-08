# Docker cred-helperer

This repository contains the source used to build a Docker image for use
inside a `Tekton` Task.
This image contains a set of `docker-credential-helpers`.
When run, it exports these binaries (and the necessary configuration) to the `/workspace' directory.

## Usage

To use this `Step` in a `Task`, add a `Step` like this:

```yaml
- name: creds
  image: gcr.io/dlorenc-vmtest2/cred-dropper
```

Then modify the `Step` that publishes an image with the following:

* /workspace/bin must be on the $PATH
* The `DOCKER_CONFIG` environment variable should point to /workspace/.docker/config.json

## Motivation

The Docker binary (and many other tools in the container building and publishing
ecosystem) uses a credential-helper system to obtain the necessary creds forr
pushing to a remote registry.
The flow roughly looks like:

* User runs tool, indicating it should push to location `foo.bar/myrepo/myimage:mytag`.
* The tool parses this location and extracts the registry `foo.bar` from it.
* The tool opens the configuration file to determine what credential helper to use
  for that registry.
* The tool executes the credential helper, and uses the resulting credential.

This is problematic when these tools run inside a container image, inside of Kubernetes for a few reasons:

* Credential helpers are designed to be installed by users for the registries they
  care about, but `Tasks` and `Steps` are designed to be generic and reusable.
  A `Task` author (or worse, every `Task` author) cannot be reasonably expected to
  package every credential helper.
* Users cannot easily modify the `Steps` inside a `Task`, and should not be expected to.

This repository helps to serve as a location where all credential helpers can be
managed, and easily integrated with the rest of the `Task` ecosystem.
