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
sudo snap install hello-world_0.1_amd64.snap --devmode --dangerous 
```
### Run the snap bash application to create $SNAP_USER_COMMON and $SNAP_USER_DATA and exit
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
This creates the following system data in /var/snap/snapshot-exclude-demo/:
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
This creates the following user data in /var/snap/snapshot-exclude-demo/:
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
Take note of the set ID

### Restore the snapshot
```
snap restore <set ID>
```
This restores the system data that was not excluded from the snapshot in /var/snap/snapshot-exclude-demo/:
```
├── common
│   └── generic
│       └── file.dat
├── current -> x1
└── x1
    └── state-info
        └── state.dat
```
as well as the user data that was not excluded from the snapshot in /var/snap/snapshot-exclude-demo/:
```
├── common
│   └── generic
│       └── file.dat
├── current -> x1
└── x1
    └── large-files
        └── large-file-used.bin
```
