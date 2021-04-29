# Image `${name}`

This image (version: `${version}`) was built on ${timestamp}.

---

%{ if shared.toggles.enable_hashicorp && shared.toggles.hashicorp.install_packages }
## HashiCorp Packages:

%{ for item in shared.packages.hashicorp }
- `${item.name}` (version: `${item.version}`)
%{ endfor }
%{ endif }

%{ if shared.toggles.enable_hashicorp && shared.toggles.hashicorp.install_nomad_plugins }
## HashiCorp Nomad Plugins:

%{ for item in shared.packages.hashicorp_nomad_plugins ~}
- `${item.name}` (version: `${item.version}`)
%{ endfor ~}
%{ endif }

%{ if shared.toggles.enable_docker && shared.toggles.docker.install_packages }
## Docker packages:

%{ for item in shared.packages.docker ~}
- `${item.name}` (version: `${item.version}`)
%{ endfor ~}
%{ endif }

%{ if shared.toggles.enable_podman && shared.toggles.podman.install_packages }
## Podman packages:

%{ for item in shared.packages.podman ~}
- `${item.name}` (version: `${item.version}`)
%{ endfor ~}
%{ endif }
