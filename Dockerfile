FROM rust:latest as builder

ENV TARGET_C_LIB="x86_64-unknown-linux-musl"
RUN rustup target add $TARGET_C_LIB && \
    cargo install mdbook --target $TARGET_C_LIB

FROM alpine:latest

COPY --from=builder /usr/local/cargo/bin/mdbook /usr/local/bin/mdbook
RUN mkdir -p /md_book/src
WORKDIR /md_book
ENTRYPOINT ["/usr/local/bin/mdbook"]
