FROM ruby:2.5.1

# リポジトリを更新し依存モジュールをインストール
RUN apt-get update -qq && \
    apt-get install -y build-essential

# BootStrap用にnodejsのバージョンを指定してインストール
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
        && apt-get install -y nodejs

# ルート直下にwebappという名前で作業ディレクトリを作成（コンテナ内のアプリケーションのルート）
RUN mkdir /webapp
WORKDIR /webapp

# ホストのGemfileとGemfile.lockをコンテナにコピー
ADD Gemfile /webapp/Gemfile
ADD Gemfile.lock /webapp/Gemfile.lock

# bundle installを実行
RUN bundle install

# ホストのアプリケーションディレクトリをコンテナに全てコピー
ADD . /webapp

# puma.sockを配置するディレクトリを作成
RUN mkdir -p tmp/sockets