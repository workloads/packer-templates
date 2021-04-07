# Image `${name}`

This image (version: `${version}`) was built on ${timestamp}.

---

%{ if build_config.toggles.enable_hashicorp && build_config.toggles.hashicorp.install_packages }
## HashiCorp Packages:

%{ for item in build_config.packages.hashicorp }
- `${item.name}` (version: `${item.version}`)
%{ endfor }
%{ endif }

%{ if build_config.toggles.enable_hashicorp && build_config.toggles.hashicorp.install_nomad_plugins }
## HashiCorp Nomad Plugins:

%{ for item in build_config.packages.hashicorp_nomad_plugins ~}
- `${item.name}` (version: `${item.version}`)
%{ endfor ~}
%{ endif }

%{ if build_config.toggles.enable_docker && build_config.toggles.docker.install_packages }
## Docker packages:

%{ for item in build_config.packages.docker ~}
- `${item.name}` (version: `${item.version}`)
%{ endfor ~}
%{ endif }

%{ if build_config.toggles.enable_podman && build_config.toggles.podman.install_packages }
## Podman packages:

%{ for item in build_config.packages.podman ~}
- `${item.name}` (version: `${item.version}`)
%{ endfor ~}
%{ endif }
