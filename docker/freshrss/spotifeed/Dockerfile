FROM ruby:2.7.2
RUN git clone https://github.com/timdorr/spotifeed
WORKDIR /spotifeed
RUN git checkout a105f0956b33444c71a47a1cddff44f12b77c297
RUN bundle install
EXPOSE 8083
RUN apt-get update
RUN apt-get upgrade
RUN apt-get install redis-server -y
CMD puma -p 8083 & redis-server
