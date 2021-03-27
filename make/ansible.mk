ansible_playbooks = ansible/playbooks

.PHONY: ansible-lint
ansible-lint: # Lints Ansible playbook(s)
	@yamllint \
		--config-data "{ rules: {line-length: { max: 125 } } }" \
		"$(ansible_playbooks)/$(wildcard *.yml)" \
	&& \
	ansible-lint \
		"$(ansible_playbooks)/main.yml"
