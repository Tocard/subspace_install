# Define variables
VENV_NAME := ansible_venv
PYTHON := python3

# Targets
.PHONY: help create-venv install-requirements run-ansible

help:
	@echo "Available targets:"
	@echo "  make create-venv       Create virtual environment"
	@echo "  make install-requirements Install requirements from requirements.txt"
	@echo "  make run-ansible       Run Ansible playbook"

create-venv:
	$(PYTHON) -m venv $(VENV_NAME)

install-requirements: create-venv
	$(VENV_NAME)/bin/pip install -r requirements.txt

install-ansible-dep:
	source $(VENV_NAME)/bin/activate; ansible-galaxy collection install tocard.utils -p collection/ -U

install-subspace: create-venv install-requirements install-ansible-dep
	source $(VENV_NAME)/bin/activate;  ansible-playbook deploy.yml -i inventory/mox/hosts -k -K -u moz -v -c paramiko -D --tags streamr


