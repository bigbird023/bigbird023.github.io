# Use a specific Ruby version to match the GitHub Pages environment
# You can check the latest dependency versions on the GitHub Pages website
FROM ruby:3.3-slim 

# Install Jekyll dependencies
RUN apt-get update -qq && \
    apt-get install -y build-essential node-gyp

# Set the working directory
WORKDIR /srv/jekyll

# Copy Gemfile and install dependencies
COPY Gemfile* ./
RUN bundle install

# Expose port 4000 for the Jekyll server
EXPOSE 4000
