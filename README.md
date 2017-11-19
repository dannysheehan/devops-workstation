# devops-workstation

Ensure your `/etc/ansible/hosts` file has at least the following entry

```
[local]
localhost ansible_connection=local
```

Configuration for devops workstation. 

Put your /home environment under ansible control so you can
easily push out profiles to the servers you manage.

- .basrhc aliases and settings
- .vimrc configuration
- .screenrc settings (specific to each host -todo )
- .ssh/config  - todo

## bootstrap

```bash
apt install ansible git
git config --global user.name "User Name" $ git config --global core.editor "vi"
git config --global user.email user@email.com
echo 'localhost ansible_host=127.0.0.1 ansible_connection=local' >> /etc/ansible/hosts
```

## .bashrc

- Configures bash prompt to include
  - git - branch
  - Python environment - working project
  - ruby environment - ruby and gem set versions

- Also adjusts title bar of terminal session to correctly display host
 you are logged in at.
- You can install git prompt manually if you have an old version of GIT
    - [download git prompt](https://github.com/git/git/raw/master/contrib/completion/git-prompt.sh)

- **Reference Articles**
    - [Shell customizations for python development](http://cewing.github.io/training.codefellows/lectures/day01/shell.html)
    - [rvm](http://sirupsen.com/get-started-right-with-rvm/)
    - [don't reinvent the (git shell prompt) wheel](http://ithaca.arpinum.org/2013/01/02/git-prompt.html)
    - [gitconfig](https://github.com/jamming/dotfiles/blob/master/git/gitconfig)
    - [awsome list for mac](https://natelandau.com/my-mac-osx-bash_profile/)
    - [git aliases](http://durdn.com/blog/2012/11/22/must-have-git-aliases-advanced-examples/)

### Example

```bash
$ . ./devops-bashrc
[rails-project]
[ruby-head@rails]

taurus:PROJECTS danny$ workon HPC-Scripts
[HPC-Scripts]
[ruby-head@rails]
[master= 25cfc86]
taurus:devops-workstation danny$ 
```

NOTES:

## Netmasks

[#1](http://www.routemeister.net/projects/sipcalc/)
[#2](http://www.jodies.de/ipcalc)

The netmask aliases support automatically figuring out minimal sets of subnets for a particular IP range, which I find to be handy. For example:

```bash
$netmask -c 10.32.0.0:10.255.255.255
      10.32.0.0/11
      10.64.0.0/10
      10.128.0.0/9
```
