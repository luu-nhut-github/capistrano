# config valid only for current version of Capistrano
lock '3.7.1'

set :repo_url, '.'

# warファイルの展開なのでscmは使用しない
#set :scm, :none

#release control 世代管理
set :keep_releases, 10

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
# ssh時にttyを有効にする。
set :pty, true

#set :application, ENV['application']

set :aws_region, 'ap-northeast-1'
set :aws_releases_bucket, 's3://ecotech-files'
set :access_key, ENV['AWS_ACCESS_KEY_ID']
set :secret_access_key, ENV['AWS_SECRET_ACCESS_KEY']
set :build_no, ENV['BUILD_NO']
namespace :deploy do
    task :main do
      desc 'check_source'
      on roles(:all), in: :parallel do |host|
          # TODO : s3 のgem経由で配布可能なように
          execute :s3cmd, 'ls', "#{fetch(:aws_releases_bucket)}/#{fetch(:stage)}_#{fetch(:application)}/#{fetch(:build_no)}/build/libs/ecotech-front-0.0.1-SNAPSHOT.jar"
          execute :s3cmd, 'get', "#{fetch(:aws_releases_bucket)}/#{fetch(:stage)}_#{fetch(:application)}/#{fetch(:build_no)}/build/libs/ecotech-front-0.0.1-SNAPSHOT.jar", "#{release_path}"
          execute "nohup sh /var/deploy/dev_front.sh #{release_path}"
      end
  end
  after :publishing, :main

end
