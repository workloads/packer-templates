ansible_playbooks = ansible/playbooks

.PHONY: ansible-lint
ansible-lint: # Lints Ansible playbook(s)
	@yamllint \
		"$(ansible_playbooks)/$(wildcard *.yml)" \
	&& \
	ansible-lint \
		"$(ansible_playbooks)/main.yml"
