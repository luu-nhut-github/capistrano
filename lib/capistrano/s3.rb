require 'capistrano/recipes/deploy/scm/base'

module Capistrano
  module Deploy
    module SCM

      # Implement the Capistrano SCM interface for deployments from S3.
      # requires s3sync (http://s3sync.net/).
      class S3 < Base
        # Sets the default command name for this SCM. Users may override this
        # by setting the :scm_command variable.
        default_command "s3sync -r"

	def head
	  configuration[:branch] || "current"
	end

	def query_revision(revision)
	  return revision
	end

	def checkout(revision, destination)
	  s3sync = command
	  branch = head

	  access_key = configuration[:access_key] || ENV['AWS_ACCESS_KEY_ID']
	  secret_key = configuration[:secret_key] || ENV['AWS_SECRET_ACCESS_KEY']

          env = "AWS_ACCESS_KEY_ID=#{access_key} AWS_SECRET_ACCESS_KEY=#{secret_key}"
	  execute = "mkdir -p #{destination} && #{env} #{s3sync} #{configuration[:repository]}/#{branch}/ #{destination}"

	  execute
	end
      end
    end
  end
end
