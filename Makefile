# Define variables
VENV_NAME := ansible_venv
PYTHON := python3

# Targets
.PHONY: help create-venv install-requirements run-ansible

help:
	@echo "Available targets:"
	@echo "  make create-venv       	Create virtual environment"
	@echo "  make install-requirements 	Install requirements from requirements.txt"
	@echo "  make install-ansible-dep       Install ansible collection"
	@echo "  make install-susbpace       	Run Ansible playbook"

create-venv:
	$(PYTHON) -m venv $(VENV_NAME)

install-requirements: create-venv
	$(VENV_NAME)/bin/python3 -m pip install --upgrade pip
	$(VENV_NAME)/bin/pip install -r requirements.txt

install-ansible-dep:
	source $(VENV_NAME)/bin/activate; ansible-galaxy collection install tocard.utils -p collection/ -U

install-subspace:
	source $(VENV_NAME)/bin/activate;  ansible-playbook playbook_subspace.yml -i inventory/hosts -k -K -v --user ${ANSIBLE_USER} -c paramiko -D --tags subspace


