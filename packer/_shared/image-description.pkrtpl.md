# Image `${name}`

This image (version: `${version}`) was built on ${timestamp}.

---
%{ if shared.hashicorp.enabled && shared.hashicorp.toggles.install_packages }
## HashiCorp Packages:

%{ for item in shared.hashicorp.packages }
- `${item.name}` (version: `${item.version}`)%{ endfor }
%{ endif }
%{ if shared.hashicorp.enabled && shared.hashicorp.toggles.install_nomad_plugins }
## HashiCorp Nomad Plugins:

%{ for item in shared.hashicorp.nomad_plugins ~}
- `${item.name}` (version: `${item.version}`)
%{ endfor ~}
%{ endif }
%{ if shared.docker.enabled && shared.docker.toggles.install_packages }
## Docker packages:

%{ for item in shared.docker.packages ~}
- `${item.name}` (version: `${item.version}`)%{ endfor ~}
%{ endif }
%{ if shared.podman.enabled && shared.podman.toggles.install_packages }
## Podman packages:

%{ for item in shared.podman.packages ~}
- `${item.name}` (version: `${item.version}`)%{ endfor ~}
%{ endif }
