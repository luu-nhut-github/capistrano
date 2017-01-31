set :stage, :dev

set :ssh_options, {
  user: 'ecotech',
  keys: %w(~/.ssh/ecotech.pem)
}

set :password, "rrPI250a"

#server 'purp-dev01', user: 'tlab-app', roles: %w{app}
role :dev, ['ec2-52-198-47-1.ap-northeast-1.compute.amazonaws.com']

set :application, ENV['application']
# warの成果物のファイル名と合わせること
#set :application, 'front'
set :deploy_to, "/var/deploy/#{fetch(:application)}"

# サービス名 サーバの相乗りなどがあるので各環境ファイルで設定する。
set :tomcat, 'service tomcat'

# tomcat settings
set :tomcat_sleep_sec, 5
set :tomcat_max_count, 12
set :tomcat_uniq, 'tomcat'

