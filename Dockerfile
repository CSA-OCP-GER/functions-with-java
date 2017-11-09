FROM openjdk:8u151-jdk

# add a reference to install libssl1.0.0 -> required by the dotnet runtime
RUN sh -c 'echo "deb http://security.debian.org/debian-security jessie/updates main " >> /etc/apt/sources.list'

# add a reference to install node js
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -

# add a reference to install dotnet
RUN sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-artful-prod artful main" > /etc/apt/sources.list.d/dotnetdev.list'

# add a reference to install azure cli -> allows to push the code to azure
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | tee /etc/apt/sources.list.d/azure-cli.list
RUN apt-key adv --keyserver packages.microsoft.com --recv-keys 52E16F86FEE04B979B07E28DB02C46DF417A0893

# install the required software
RUN apt-get update
RUN apt-get install -y --allow-unauthenticated \ 
    libssl1.0.0 \
    maven \
    nodejs \
    dotnet-runtime-2.0.0 \
    dotnet-sdk-2.0.2 \
    azure-cli

# install the azure function tooling
RUN npm install -g azure-functions-core-tools@core --unsafe-perm true

# create a working directory
VOLUME /app
WORKDIR /app

EXPOSE 7071