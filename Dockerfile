FROM debian:latest

LABEL com.github.actions.name="rosinstall-credentials-action"
LABEL com.github.actions.description="Inject credentials to rosinstall file in order to clone private repositories"
LABEL com.github.actions.icon="terminal"
LABEL com.github.actions.color="gray-dark"

LABEL repository="https://github.com/Thazz/rosinstall_credentials_action"
LABEL maintainer="Gregor Seljak <gregor.seljak@gmail.com>"

WORKDIR /build
RUN apt-get update
RUN apt-get -qq -y install gettext

ADD entrypoint.sh /entrypoint.sh
COPY . .
CMD ["bash", "/entrypoint.sh"]