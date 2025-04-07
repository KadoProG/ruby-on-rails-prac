FROM ruby:3.2.8

# ロケールとタイムゾーンの設定
ENV TZ="Asia/Tokyo"
ENV LANG="C.UTF-8"

# 作業ディレクトリを /app に設定
WORKDIR /app

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential curl git pkg-config libyaml-dev && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Gemfile と Gemfile.lock をコピーして、依存関係をインストール
COPY Gemfile Gemfile.lock /app/
RUN bundle install

# アプリケーションのコード全体をコピー
COPY . /app/

# エントリポイントスクリプトをコピー
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["sh","entrypoint.sh"]

# ポート 3000 をエクスポート
EXPOSE 3000

# Rails サーバーを起動
CMD ["rails", "server", "-b", "0.0.0.0"]