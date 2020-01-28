# README

このアプリケーション `feedbackbox` は、2019年12月に開催された「[レガシーをぶっつぶせ。現場でDDD！2nd](https://genbade-ddd.connpass.com/event/156060/)」の中のワークショップ「[システム設計の中でドメインモデルの役割を体感する / the Place of Domain Model in System Design - Speaker Deck](https://speakerdeck.com/hagifoo/the-place-of-domain-model-in-system-design)」で扱った対象システムを実装したサンプルアプリケーションです。

ワークショップで作成したドメインモデルを活用して、実際のアプリケーションコードを変更する体験をしてみてください。

## 動作環境

このアプリケーションを動作させるには、 Ruby v2.6.3 を用意してください。

この git リポジトリをローカルに clone した後、以下のコマンド実行によって、アプリケーションを起動することができます。

```bash
$ bundle install --path vendor/bundle
$ yarn install --check-files
$ rails db:migrate
$ rails db:seed
$ rails server
```

アプリケーションは [http://127.0.0.1:3000/](http://127.0.0.1:3000/) で起動しています。

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
