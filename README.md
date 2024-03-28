# How install subspace with ansible.

Ansible is just a tool to deploy on server with idempotence. This is for linux only sorry Windows lover.
It can work on windows, but I'm not doing ansible on windows so...

## Configure your env

You will need to choses if you want to:

- Install ansible on your server and then deploy on it
- Configure an ansible server to deploy on your other server (strongly recommended)

In both scenario thoses action are requiered to do on the server who will run ansible.
Keep in mind that if you run software in production, you should never stuff which allow you to compile any binaries on the same server.

Security is something that everyone should take care.

### Configure your hosts file.

You will find under `inventory/` a file called `hosts` this file will contain information about server to deploy:

The pattern should follow this one

````yaml
[group_name]
server_name ansible_host="server_ip"

````

Here an example with a local server if you need, and two remote.
Three of them are into subspace_group.

````yaml
[localhost]
subspace_local ansible_host="127.0.0.1" ansible_connection=local

[remote_server]
subspace_01 ansible_host="192.168.1.176"
subspace_02 ansible_host="192.168.1.177"

[subspace]
subspace_local
subspace_01
subspace_02

````

- `server_name` is internal to ansible it's called `inventory_hostname`
- `[subspace]` if a group. keep it as `[susbpace]` for the host targeting.
- `ansible_host` is what ansible use to connect on remote hosts. can be ip or dns.

Choose what do feat your use case.

## Prepare server

### User you need

You will need a user with sudo right on server. We need it for some tasks, like filesystem, user creation, etc etc) Nothing nasty, but read what the playbook does. As awlays, this is a security concern.

### Set remote user for ssh

```shell
export ANSIBLE_USER=user_from_previous_step
```




## Configure Ansible

Into `group_vars/all.yml` you will find all configuration requiered. you need to adjust according to your os.`
Into `groups_vars/subspace/node.yml` you will find anything relating to node install
Into `groups_vars/subspace/farmer.yml` you will find anything relating to farmer install
Into `groups_vars/subspace/commun.yml` you will find anything common between  node & farmer install

Ansible is fully configurable. You can edit whatever you want to feat your usecase. Please refer to [my ansible collection](https://github.com/Tocard/ansible_collection) if you need to overide default variable.

Precedence into ansible allow you to have order of loading. In this sample

groups_vars/all < groups_vars/any < inventory_vars/all < inventory_vars/any < hostsvars

if we want to transpose.

groups_vars/all if your whole global configuration.
groups_vars/subspace is only about subspace_group into hosts file.
inventory/all is to have global config for the whole hosts file
inventory/subspace is only about susbspace_group into inventory hosts file
hostsvars is only about the given host into host file.

Don't forget to replace `subspace_farmer_wallet_adress`

## Run 

````shell
make install-requirements
make install-ansible-dep
make install-subspace
````

Then you will be promptep for two password. This is the password from user in `${ANSIBLE_USER}`. One for SSH, one for become method.