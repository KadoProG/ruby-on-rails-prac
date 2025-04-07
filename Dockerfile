FROM ruby:3.2.8

# ロケールとタイムゾーンの設定
ENV TZ="Asia/Tokyo"
ENV LANG="C.UTF-8"

# 作業ディレクトリを /app に設定
WORKDIR /myapp

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential curl git pkg-config libyaml-dev && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Gemfile と Gemfile.lock をコピーして、依存関係をインストール
COPY Gemfile Gemfile.lock ./
RUN bundle install

# アプリケーションのコード全体をコピー
COPY . .
