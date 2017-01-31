namespace :none do
  task :check do
  end

  task :create_release do
    on release_roles :all do
      # releaseディレクトリ作成
      execute :mkdir, '-p', release_path
    end
  end

  task :set_current_revision do
    on release_roles :all do
      # revisionの設定
      # revisionはcapのコマンドライン引数で指定
      set :current_revision, ENV['revision']
    end
  end
end
