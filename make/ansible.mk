.PHONY: ansible-lint
ansible-lint: # Lints Ansible playbook(s)
	@yamllint \
		--config-data "{ rules: {line-length: { max: 125 } } }" \
		"playbooks/$(wildcard *.yml)" \
	&& \
	ansible-lint \
		playbooks/main.yml
