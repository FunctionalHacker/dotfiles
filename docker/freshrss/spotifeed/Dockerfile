FROM ruby:2.7.2
RUN git clone https://github.com/timdorr/spotifeed
WORKDIR /spotifeed
RUN bundle install
EXPOSE 8083
RUN apt-get update
RUN apt-get upgrade
RUN apt-get install redis-server -y
CMD puma -p 8083 & redis-server
