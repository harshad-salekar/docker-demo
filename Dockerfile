# ---- Stage 1: builder ----
FROM alpine:3.20 AS builder
ARG BUILD_ID=unknown
ARG GIT_COMMIT=unknown
WORKDIR /site
COPY index.html .
RUN sed -i "s/__BUILD_ID__/${BUILD_ID}/; s/__GIT_COMMIT__/${GIT_COMMIT}/" index.html

# ---- Stage 2: final image ----
FROM nginx:alpine
ARG BUILD_ID=unknown
ARG GIT_COMMIT=unknown
LABEL build_id="${BUILD_ID}" git_commit="${GIT_COMMIT}"
COPY --from=builder /site/index.html /usr/share/nginx/html/index.html
EXPOSE 80
