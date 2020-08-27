# express-jwt-authentication

* [jkasun/stack\-abuse\-express\-jwt: Handling Authorization in Express\.js using JWT](https://github.com/jkasun/stack-abuse-express-jwt)がベース
* 認証サーバとAPIサーバが分離されている好例

## セットアップ

```shell
npm i
```

package.jsonが無い場合

```shell
npm init -y
npm install --save express body-parser jsonwebtoken dotenv
```

## 動作確認

認証サーバの起動

```shell
make run-auth
```

APIサーバの起動

```shell
make run
```

データ取得(loginタスクでトークンを取得してアクセス)

```shell
make get
[{"author":"Chinua Achebe","country":"Nigeria","language":"English","pages":209,"title":"Things Fall Apart","year":1958},{"author":"Hans Christian Andersen","country":"Denmark","language":"Danish","pages":784,"title":"Fairy tales","year":1836},{"author":"Dante Alighieri","country":"Italy","language":"Italian","pages":928,"title":"The Divine Comedy","year":1315}]
```

**POSTでのデータ登録は未確認**

## 動作確認(外部認証サーバを使う場合)

.envにて環境変数`JWT_SECRET_KEY`をサーバ側と合わせておく

APIサーバの起動

```shell
make run-external
```

データ取得(login-externalタスクでトークンを取得してアクセス)

```shell
make get-external
[{"author":"Chinua Achebe","country":"Nigeria","language":"English","pages":209,"title":"Things Fall Apart","year":1958},{"author":"Hans Christian Andersen","country":"Denmark","language":"Danish","pages":784,"title":"Fairy tales","year":1836},{"author":"Dante Alighieri","country":"Italy","language":"Italian","pages":928,"title":"The Divine Comedy","year":1315}]
```

**POSTでのデータ登録は未確認(adminロールが無い場合は無理)**

## リンク

* [Authentication and Authorization with JWTs in Express\.js](https://stackabuse.com/authentication-and-authorization-with-jwts-in-express-js/)
* [jkasun/stack\-abuse\-express\-jwt: Handling Authorization in Express\.js using JWT](https://github.com/jkasun/stack-abuse-express-jwt)
* [環境変数の代わりに \.env ファイルを使用する \(dotenv\) \| まくまくNode\.jsノート](https://maku77.github.io/nodejs/env/dotenv.html)
