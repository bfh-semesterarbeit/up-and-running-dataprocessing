# up-and-running-dataprocessing
up and running the dataprocessing

# going to use ansible to treat the processing
the processing_step.txt will be persistent on the efs
```
ansible-playbook playbooks/base.yml --extra-vars "processing_step=$(cat ../processing_step.txt)"
```
