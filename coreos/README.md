### Packer CoreOS
Packer script to build a vagrant box from Fedora CoreOS.

### Instruction
1. Install packer
2. Run `packer build -force coreos-virtualbox-iso.json`
3. Artifacts is saved under build/virtualbox directory.