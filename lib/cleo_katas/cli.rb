# frozen_string_literal: true

require 'thor'

module CleoKatas
  class CLI < Thor
    include Thor::Actions

    source_root File.expand_path('../templates', __FILE__)
    desc 'list', 'List all available katas'
    def list
      say 'Listing katas...'
      Dir.glob(File.join(Dir.pwd, 'katas', '*')).each do |kata|
        say kata.split('/').last
      end
    end

    desc 'attempt DIRECTORY', 'Create a new kata attempt in the specified directory with a subdirectory named after the current user'
    def attempt(kata)
      username = `whoami`.strip.downcase
      target_directory = File.join(Dir.pwd, 'katas', kata, username)

      empty_directory(target_directory)

      target_file = File.join(target_directory, 'main.rb')

      template('main.rb.erb', target_file)

      say "Created new kata attempt directory at #{target_directory} with a main.rb file"
    end
  end
end