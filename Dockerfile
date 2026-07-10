# Quarantine Stories — Dockerfile for Railway deployment
# Ruby 2.7 + Rails 6 + PostgreSQL + Webpacker

FROM ruby:2.7-bullseye AS build

# Install system dependencies for building native gems and npm modules
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
      build-essential \
      libpq-dev \
      python2 \
      curl \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 14 from official binary tarball (avoids Nodesource GPG key issues)
# Node 14 is required because @rails/webpacker 4.3.0 pulls in node-sass 4.14.1,
# which only supports Node <= 14. Node 18+ breaks native compilation.
RUN curl -fsSL https://nodejs.org/dist/v14.21.3/node-v14.21.3-linux-x64.tar.xz | tar -xJ -C /usr/local --strip-components=1 && \
    node --version && npm --version

# node-sass needs Python 2 for native compilation
ENV PYTHON=/usr/bin/python2

# Install Yarn
RUN npm install -g yarn && \
    npm cache clean --force

WORKDIR /app

# Install Ruby gems
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4 --retry 3

# Install JS dependencies
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

# Copy application code
COPY . .

# Precompile assets (with RAILS_ENV=production, dummy SECRET_KEY_BASE for assets:precompile)
RUN SECRET_KEY_BASE=dummy RAILS_ENV=production bundle exec rake assets:precompile

# ============================================
FROM ruby:2.7-slim AS runtime

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
      libpq-dev \
      curl \
      shared-mime-info \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy gems and app from build stage
COPY --from=build /usr/local/bundle/ /usr/local/bundle/
COPY --from=build /app /app

EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:${PORT:-3000}/ || exit 1

# Run database migrations on startup (log failures), then start Puma on Railway's PORT
CMD ["sh", "-c", "echo 'Running migrations...' && bundle exec rake db:migrate 2>&1 || echo 'Migration issue (non-fatal, will retry on next deploy)' && echo 'Starting Puma...' && bundle exec puma -C config/puma.rb"]
