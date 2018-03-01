FROM ubuntu:16.04 as build
RUN export APT_CACHE_DIR=`pwd`/apt-cache && mkdir -pv $APT_CACHE_DIR
RUN apt-get update
RUN apt-get -o dir::cache::archives="$APT_CACHE_DIR" install -y software-properties-common curl
RUN apt-add-repository -y ppa:ansible/ansible
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update
RUN apt-get -o dir::cache::archives="$APT_CACHE_DIR"  install -y ansible ssh zip bzip2 git php php-curl php-zip php-mbstring php-xml nodejs yarn build-essential
RUN export COMPOSER_CACHE_DIR=`pwd`/.composercache && mkdir -pv .composercache
RUN mkdir -p /var/www/beacon
RUN eval $(ssh-agent -s)
