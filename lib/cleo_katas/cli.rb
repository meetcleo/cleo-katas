# frozen_string_literal: true

require 'thor'
require_relative 'configuration'

module CleoKatas
  # CLI for managing katas. Run bin/cleo-katas to see available commands
  class CLI < Thor
    include Thor::Actions

    source_root File.expand_path('templates', __dir__)
    desc 'list', 'List all available katas'
    def list
      say 'Listing katas...'
      Dir.glob(File.join(Dir.pwd, 'katas', '*')).each do |kata|
        say kata.split('/').last
      end
    end

    desc 'attempt DIRECTORY', 'Create a new kata attempt in your own directory'
    def attempt(kata)
      configuration = CleoKatas::Configuration.new
      target_directory = File.join(Dir.pwd, 'katas', kata, configuration.username)

      empty_directory(target_directory)

      target_file = File.join(target_directory, 'main.rb')

      template('main.rb.erb', target_file)

      say "Created new kata attempt directory at #{target_directory} with a main.rb file"
    end
  end
end
