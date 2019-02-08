FROM maven:3.3.9-jdk-8

# Install git and pull chitchat
RUN apt-get update && apt-get -y install git
RUN git clone https://bitbucket.org/arvid/chitchat.git && cd chitchat && git checkout dfca7f0

# build ==> skip the dependency check because it throws an error
#  Do:
#   - Use maven to create the jar file
#   - Retrieve the version of the current ChitChat jar
#   - Copy the settings, version and the jar file to the 'chitchat' volume
CMD cd chitchat && mvn -e clean install -Ddependency-check.skip=true && ccversion=$(grep -oPm1 "(?<=<version>)[^<]+" "pom.xml") && cp /chitchat/target/chitchat-$ccversion.jar /var/chitchat/chitchat-latest.jar && echo "CHITCHAT_VERSION=${ccversion}" >> /var/chitchat/VERSION.txt && cp /chitchat/settings.yml /var/chitchat && cp -R /chitchat/data /var/chitchat
