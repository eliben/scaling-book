FROM ruby:3.4.5-bookworm@sha256:7a61aa7fe86768830f65d8e12571fc115f381a54557c7c88619a5368b92a0474

ENV BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3 \
    JEKYLL_ENV=development \
    VIRTUAL_ENV=/opt/jupyter

ENV PATH="${VIRTUAL_ENV}/bin:${PATH}"

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    imagemagick \
    nodejs \
    python3 \
    python3-pip \
    python3-venv \
  && rm -rf /var/lib/apt/lists/*

RUN python3 -m venv "${VIRTUAL_ENV}" \
  && pip install --no-cache-dir --upgrade pip==26.1.1 \
  && pip install --no-cache-dir jupyter==1.1.1

WORKDIR /site

COPY Gemfile ./
RUN bundle install

COPY . .

EXPOSE 4000

CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--port", "4000"]
