FROM ruby:3.3

# 1. Install dependencies (using the Corepack/Yarn fix from before)
RUN apt-get update -qq && \
    apt-get install -y build-essential nodejs sqlite3 && \
    rm -rf /var/lib/apt/lists/*
RUN corepack enable && corepack prepare yarn@stable --activate

# 2. Set the working directory
WORKDIR /myapp

# 3. INSTALL GEMS (Crucial step)
# Copy the Gemfile first to leverage Docker caching
COPY Gemfile Gemfile.lock ./
RUN bundle install

# 4. Copy the rest of the app
COPY . .

# 5. Entrypoint setup
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]