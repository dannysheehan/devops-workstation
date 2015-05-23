# devops-workstation

Configuration for devops workstation. 

Final phase will be to put under puppet control.


## devops .bashrc

- Configures bash prompt to include
    - git - branch 
    - Python environment - working project
    - ruby environment - ruby and gem set versions

- Also adjusts title bar of terminal session to correctly display host
 you are logged in at.


### Example 
````
$ . ./devops-bashrc 
[rails-project]
[ruby-head@rails]


taurus:PROJECTS danny$ workon HPC-Scripts
[HPC-Scripts]
[ruby-head@rails]
[master= 25cfc86]
taurus:devops-workstation danny$ 
```

