# デプロイスクリプト

jenkinsでのビルド後の成果物を
s3://ecotech-files 配下から取得してデプロイする。

## 準備

    $ sudo gem install capistrano
    $ sudo gem install capistrano-ext
    $ sudo yum install ruby-devel
    $ sudo yum install ruby20-devel gcc-c++
    $ sudo gem install io-console

capistrano3.4、ruby2.0以上

## インストール

`$ git clone http://gitbucket.team-lab.local/git/ecotech/capistrano.git`


## 実行方法
基本はjenkinsから実行する。
社内開発機のフロントをデプロイする場合

    $ BUILD_NO=[jenkinsでのビルドNo] application=front revision=`date +"%Y%m%d_%H%M%S"` cap labdev deploy

BUILD_NO は必須。
