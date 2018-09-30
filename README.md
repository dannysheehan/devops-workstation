# DevOps Workstation

Ansible playbook to configure your desktop with all the tools a DevOps could possibly need.

* docker
* postman
* gitKraken
* viscode
* terraform
* kops
* minikube
* kubectl
* helm
* virtualbox
* vagrant
* powershell
* pycharm, phpstorm, goland
* kvm
* chromium
* calible book reader

Also, implements a handy shell prompt that displays:

* current git branch and commit hash
* current aws assumed role
* current terraform workspace
* current python virtenv
* current nvm
* current k8s context


Optionally, allows you to easily push out bash profiles to the servers you manage with all your favourite aliases included:

* .basrhc aliases and settings
* .vimrc configuration
* .screenrc settings (specific to each host -todo )

## bootstrap

How to boot strap for the first time

```bash
apt install ansible git
echo 'localhost ansible_host=127.0.0.1 ansible_connection=local' >> /etc/ansible/hosts
pip install -r requirements.txt

ansible -l localhost deploy.yml --ask-become
```

ALTERNATIVE: You can use bootstrap.sh to install the git and ansible package

`bootstrap.yml` is included to help you setup servers that aren't configured for ansible playbooks to be deployed to.

If you want to make code changes, take advantage of pre-commit linting

```bash
git config --global user.name "User Name" $ git config --global core.editor "vi"
git config --global user.email user@email.com
pre-commit install
pre-commit autoupdate
pre-commit run --all-files
```

## .bashrc

* Configures bash prompt to include
  * git - branch
  * Python environment - working project
  * ruby environment - ruby and gem set versions

* Also adjusts title bar of terminal session to correctly display host
 you are logged in at.
* You can install git prompt manually if you have an old version of GIT
  * [download git prompt](https://github.com/git/git/raw/master/contrib/completion/git-prompt.sh)

* **Reference Articles**
  * [Shell customizations for python development](http://cewing.github.io/training.codefellows/lectures/day01/shell.html)
  * [rvm](http://sirupsen.com/get-started-right-with-rvm/)
  * [don't reinvent the (git shell prompt) wheel](http://ithaca.arpinum.org/2013/01/02/git-prompt.html)
  * [gitconfig](https://github.com/jamming/dotfiles/blob/master/git/gitconfig)
  * [awsome list for mac](https://natelandau.com/my-mac-osx-bash_profile/)
  * [git aliases](http://durdn.com/blog/2012/11/22/must-have-git-aliases-advanced-examples/)

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

## Git

[global git ignore](https://gist.github.com/subfuzion/db7f57fff2fb6998a16c)

```bash
git config --global core.excludesfile ~/.gitignore
```
