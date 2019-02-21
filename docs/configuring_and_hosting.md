# Configuring and hosting ChitChat

In this tutorial, we show how you can configure and host ChitChat using [DigitalOcean](https://www.digitalocean.com/) in under 15 minutes.

1. Sign up for a DO account if you have not already done so.
2. In the DO dashboard, go to 'Droplets'

![DO1](img/DO1.png)

3. Create a new droplet using Ubuntu 18.04 as operating system. The other configurations are up to you.

![DO2](img/DO2.png)

4. Log into your new droplet

```
ssh root@<your-droplet-ip>
```

5. Create a new user (e.g. 'chitchat') and configure root access, passwords etc.

```
adduser chitchat
usermod -aG sudo chitchat
```

4. Configure the firewall

```
ufw allow OpenSSH
ufw enable
```

5. Switch to the 'chitchat' user

```
su - chitchat
```

6. Refresh the packages index

```
sudo apt update
sudo apt upgrade
```

7. Install docker dependencies

```
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
```

8. Add the docker APT repository

First, install

```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

then, run

```
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
```

9. Install docker

```
sudo apt-get update
sudo apt-get install docker-ce
```

10. Install docker-compose

```
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```

11. Make the file executable

```
sudo chmod +x /usr/local/bin/docker-compose
```

12. Clone the ChitChat repository

```
git clone https://github.com/JasperHG90/chitchat-docker.git
```

13. Follow the setup guide in the repository README
