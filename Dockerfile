# Quarantine Stories — Dockerfile for Railway deployment
# Ruby 2.7 + Rails 6 + PostgreSQL + Webpacker

FROM ruby:2.7-slim AS build

# Install system dependencies for building native gems and JS assets
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
      build-essential \
      libpq-dev \
      curl \
      gnupg \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 14 (required by Webpacker 4)
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

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

# Precompile assets
RUN bundle exec rake assets:precompile

# ============================================
FROM ruby:2.7-slim AS runtime

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
      libpq-dev \
      curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy gems and app from build stage
COPY --from=build /usr/local/bundle/ /usr/local/bundle/
COPY --from=build /app /app

EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:3000/ || exit 1

# Run database migrations on startup, then start Puma
CMD ["sh", "-c", "bundle exec rake db:migrate 2>/dev/null || true && bundle exec puma -C config/puma.rb -b tcp://0.0.0.0:3000"]
