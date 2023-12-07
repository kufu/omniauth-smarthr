# OmniAuth SmartHR
OmniAuth SmartHRはSmartHRとのOAuth連携処理を簡素化するための[OmniAuth](https://github.com/omniauth/omniauth) strategyです。

## インストール

```ruby
gem 'omniauth-smarthr'
```
## 使い方

### Rails

OmniAuthをミドルウェアとして登録します。

**config/initializers/omniauth.rb**:
```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :smarthr, ENV['SMARTHR_CLIENT_ID'], ENV['SMARTHR_CLIENT_SECRET']
end
```
※`SMARTHR_CLIENT_ID` 及び `SMARTHR_CLIENT_SECRET`を取得するには[SmartHR Plus について](https://www.smarthr.plus/about)をご参照の上、パートナープログラムについてお問い合わせください。

環境変数を用意します。

**.env**:
```
# Required
SMARTHR_CLIENT_ID=YOUR_CLIENT_ID
SMARTHR_CLIENT_SECRET=YOUR_CLIENT_SECRET

# Optional
# サンドボックス環境を利用する場合には、サンドボックス環境のエンドポイントを指定してください。
SMARTHR_AUTH_ENDPOINT=SANDBOX_ENVIRONMENT_ENDPOINT
```

ルーティングとコントローラを用意します。

**config/routes.rb**:

```ruby
  get 'auth/:provider/callback', to: 'sessions#create'
```

**app/controllers/sessions_controller.rb**:
```ruby
class SessionsController < ApplicationController
  def create
    user_info = request.env['omniauth.auth']
    raise user_info # 適宜セッション管理を行います。
  end
end
```

ユーザーを`/auth/smarthr`に遷移させることでOAuth認可コードフローが開始されます。  
OAuth認可コードフローが開始するとアプリケーションとの連携許可を求める認可画面が表示されます。  
認可画面で連携を許可するとアプリケーションにリダイレクトされ`Sessions#create`が呼び出されます。  
`Sessions#create`で`request.env['omniauth.auth']`を参照することでSmartHRから受け取ったユーザー情報(アクセストークン含む)を取得できます。

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kufu/omniauth-smarthr.
