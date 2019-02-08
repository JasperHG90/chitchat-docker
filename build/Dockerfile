FROM maven:3.3.9-jdk-8

# Install git and pull chitchat
RUN apt-get update && apt-get -y install git
RUN git clone https://bitbucket.org/arvid/chitchat.git && cd chitchat && git checkout dfca7f0

# build ==> skip the dependency check because it throws an error
#  Command creates the jar file and emits a message
CMD cd chitchat && mvn -e clean install -Ddependency-check.skip=true && ccversion=$(grep -oPm1 "(?<=<version>)[^<]+" "pom.xml") && cp /chitchat/target/chitchat-$ccversion.jar /var/chitchat/chitchat-latest.jar && echo "CHITCHAT_VERSION=${ccversion}" >> /var/chitchat/VERSION.txt && cp /chitchat/settings.yml /var/chitchat
