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

````shell
make install-subspace
````