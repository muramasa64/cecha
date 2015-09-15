require 'cecha/client'
require 'thor'
require 'thor/aws'

module Cecha
  class CLI < Thor
    include Thor::Aws

    class_option :verbose, type: :boolean, default: false, aliases: [:v]

    desc :list, "show elb certificate list"
    def list
      client.list.each do |elbcert|
        puts elbcert
      end
    end

    default_task :list

    private
    def client
      @client ||= Client.new options, aws_configuration
    end
  end
end
