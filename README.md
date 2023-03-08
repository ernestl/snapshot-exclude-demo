## How to build, install and use the snapshot-exclude-demo snap:

### Install snapcraft
```
sudo snap install snapcraft --classic
```
### Install lxd
```
sudo snap install lxd
```
### Install git
```
sudo apt update
sudo apt install -y git
```
### Clone repo
```
cd ~/
git clone https://github.com/ernestl/snapshot-exclude-demo.git
```
### Build the snapshot-exclude-demo snap in lxd container
```
cd ~/snapshot-exclude-demo
snapcraft --use-lxd --debug
```
### Install the snap (note: this is a development mode snap)
```
sudo snap install snapshot-exclude-demo_0.1_amd64.snap --devmode --dangerous
```
> ⓘ This snap uses devmode confinement as specified in `snapcraft.yaml` top-level metadata

### Inspect the content of the snap
```
unsquashfs -f snapshot-exclude-demo_0.1_amd64.snap
tree squashfs-root
```
This shows the optional metadata file `snapshots.yaml` installed into the snap meta directory:
```
squashfs-root/
├── bin
│   ├── bash.sh
│   ├── create-system-data.sh
│   └── create-user-data.sh
└── meta
    ├── gui
    ├── snapshots.yaml
    └── snap.yaml
```

### Run the snap bash application to create directories `$SNAP_USER_COMMON` and `$SNAP_USER_DATA` and exit
```
snapshot-exclude-demo.bash
```
and exit
```
exit
```

### Create the system data for the test case as super user (required)
```
sudo snapshot-exclude-demo.create-system-data
```
This creates the following system data in `/var/snap/snapshot-exclude-demo/`:
```
├── common
│   └── generic
│       └── file.dat
├── current -> x1
└── x1
    ├── excl-1
    │   └── file.log
    ├── excl-2
    │   └── file.log
    └── state-info
        └── state.dat
```
### Create the user data for the test case
```
snapshot-exclude-demo.create-user-data
```
This creates the following user data in `~/snap/snapshot-exclude-demo/`:
```
├── common
│   ├── generic
│   │   └── file.dat
│   └── tmp
│       └── file.tmp
├── current -> x1
└── x1
    └── large-files
        ├── large-file-not-used.bin
        ├── large-file-not-used.dat
        └── large-file-used.bin
```
### Take a snapshot
```
snap save snapshot-exclude-demo
```
> ⓘ Take note of the *set ID* provided on completion of the `snap save` command

### Restore the snapshot
```
snap restore <set ID>
```
This restores the system data that was not excluded from the snapshot in `/var/snap/snapshot-exclude-demo/`:
```
├── common
│   └── generic
│       └── file.dat
├── current -> x1
└── x1
    └── state-info
        └── state.dat
```
as well as the user data that was not excluded from the snapshot in `~/snap/snapshot-exclude-demo/`:
```
├── common
│   └── generic
│       └── file.dat
├── current -> x1
└── x1
    └── large-files
        └── large-file-used.bin
```

### Diagram illustrating the snapshot data exclusion during the save and restore actions:


![snapshot-exclusion-demo drawio (1)](https://user-images.githubusercontent.com/5872705/215036359-087cd60c-dc46-4281-a145-ef2a6e256a1f.png)

