## How to configure GUI in Azure, AWS and GCP VM.

```
sudo yum grouplist 
```
```
sudo yum group install "Server with GUI" -y
```
```
sudo yum install http://mirror.centos.org/centos/8/extras/aarch64/os/Packages/epel-release-8-8.el8.noarch.rpm -y
sudo yum install xrdp tigervnc-server
```
```
systemctl enable --now rxdp
```
```
passwd root
```
```
systemctl set-default graphical.target
```

