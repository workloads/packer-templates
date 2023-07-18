# Image `${image.name}`

| Image Information |                                    |
|-------------------|------------------------------------|
| build version     | `${image.version}`                  |
| build timestamp   | `${image.timestamp}`   |
%{~ if image.developer_mode }
| Developer Mode    | ⚠️ enabled                         |
%{~ endif}

## Table of Contents

* [Table of Contents](#table-of-contents)
  %{~ if can(shared.tools.docker) }* [Docker Packages](#docker-packages)%{ endif ~}
  %{~ if can(shared.tools.hashicorp) }* [HashiCorp Packages](#hashicorp-packages)%{ endif ~}
  %{~ if can(shared.nomad_plugins.plugins) }* [HashiCorp Nomad Plugins](#hashicorp-nomad-plugins)%{ endif ~}
  %{~ if can(shared.tools.osquery) }* [osquery Packages](#osquery-packages)%{ endif ~}

%{~ if can(shared.tools.docker) ~}
## Docker Packages

%{~ for item in shared.tools.docker.packages.to_install }
- `${item.name}`, version `${item.version}`
%{~ endfor ~}
%{ endif }

%{~ if can(shared.tools.hashicorp) ~}
## HashiCorp Packages

%{~ for item in shared.tools.hashicorp.packages.to_install ~}
- `${item.name}`, version `${item.version}`
%{~ endfor ~}
%{ endif }

%{~ if can(shared.nomad_plugins.plugins) ~}
## HashiCorp Nomad Plugins

%{~ for name, config in shared.nomad_plugins.plugins }
%{ if can(config.official) && can(config.version) }- `${name}`, version `${config.version}` (HashiCorp-maintained)%{ endif ~}
%{ if !can(config.official) && can(config.url) }- `${name}`, ([source](${config.url}))%{ endif ~}
%{~ endfor ~}
%{ endif }

%{~ if can(shared.tools.osquery) ~}
## osquery Packages

%{~ for item in shared.tools.osquery.packages.to_install }
- `${item.name}`, version `${item.version}`
%{~ endfor ~}
%{ endif }