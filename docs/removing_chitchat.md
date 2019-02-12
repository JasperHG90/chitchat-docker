# Removing all files related to ChitChat

If you want to completely remove ChitChat or start a fresh installation, follow the steps below.

1. Run `docker-compose down` to stop all running services
2. Remove all images `docker rmi chitchat/chitchat_db chitchat/chitchat_app`
3. Remove all volumes `docker volume rm chitchat chitchat_postgres`
