# Docker Workflow

Build the image:

```bash
docker build -t scaling-book .
```

Serve locally:

```bash
docker compose up
```

Open:

```text
http://127.0.0.1:4000/scaling-book
```

The first `docker compose up` performs a full build. Later runs reuse Docker
volumes for Bundler, `_site`, and `.jekyll-cache`, and Jekyll runs with
`--incremental --watch`.

Rebuild the image after changing `Dockerfile`:

```bash
docker compose up --build
```

Run a one-shot incremental build, without serving it:

```bash
docker compose run --rm site sh -c "bundle install && bundle exec jekyll build --incremental"
```

Clear Docker build/runtime caches for this project:

```bash
docker compose down -v
```

Then the next run will do a full rebuild.
