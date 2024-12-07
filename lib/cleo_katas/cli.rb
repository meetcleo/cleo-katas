# frozen_string_literal: true

require 'thor'
require_relative 'configuration'
require_relative 'kata_file'
module CleoKatas
  # CLI for managing katas. Run bin/cleo-katas to see available commands
  class CLI < Thor
    include Thor::Actions

    attr_accessor :kata

    source_root File.expand_path('templates', __dir__)
    desc 'list', 'List all available katas'
    def list
      say 'Listing katas...'
      CleoKatas::KataFile.all.each do |kata_file|
        say "#{kata_file.number}: #{kata_file.name}"
      end
    end

    # rubocop:disable Metrics/MethodLength
    desc 'attempt DIRECTORY', 'Create a new kata attempt in your own directory'
    def attempt(kata)
      self.kata = kata


      source_directory = File.join(Dir.pwd, 'katas', kata_file.numbered_name, 'source')
      target_directory = File.join(Dir.pwd, 'katas', kata_file.numbered_name, username)
      readme_target_file = File.join(target_directory, 'README.md')

      puts <<~STRING
source_directory: #{source_directory}
target_directory: #{target_directory}
readme_target_file: #{readme_target_file}
      STRING
      directory(source_directory,target_directory)
      copy_file(kata_file.path, readme_target_file)
      append_file(readme_target_file, <<~MARKDOWN)


        ---#{' '}

        ## How to run your main file#{' '}

        ```
        bundle exec ruby katas/#{kata_file.numbered_name}/#{username}/main.rb
        ```

      MARKDOWN
      say "Created new kata attempt directory at #{target_directory} with a main.rb file"
    end
    # rubocop:enable Metrics/MethodLength

    private

    def username
      CleoKatas::Configuration.new.username
    end

    def kata_file
      @kata_file ||= CleoKatas::KataFile.find(kata)
    end
  end
end
