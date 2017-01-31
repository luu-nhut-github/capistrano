namespace :debug do
  desc 'List roles'
  task :list_roles do
    on roles(:all), in: :parallel do |host|
      #host.properties.roles.each { |role| puts role}
      if host.properties.roles.include?(:web)
        puts 'includes web : ' + host.hostname
      end
      if host.properties.roles.include?(:admin)
        puts 'includes admin : ' + host.hostname
      end
    end

    roles(:all).map{ |server| server.roles_array }.flatten.uniq.sort.each do |role|
      puts role
    end
  end

  desc 'List servers'
  task :list_servers do
    roles(:all).map(&:hostname).sort.each { |hostname| puts hostname }
  end
end
