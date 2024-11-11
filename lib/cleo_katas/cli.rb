# frozen_string_literal: true

require 'thor'
require_relative 'configuration'

module CleoKatas
  # CLI for managing katas. Run bin/cleo-katas to see available commands
  class CLI < Thor
    include Thor::Actions

    KATA_FILE_NAME_REGEX = %r{katas/(?<kata_number>[0-9]*)-(?<kata_name>.*)\.md}

    source_root File.expand_path('templates', __dir__)
    desc 'list', 'List all available katas'
    def list
      say 'Listing katas...'

      Dir.glob(File.join(Dir.pwd, 'katas', '[0-9]*-*.md')).each do |kata|
        match_data = kata.match(KATA_FILE_NAME_REGEX)

        say "#{match_data[:kata_number]}: #{match_data[:kata_name]}"
      end
    end

    desc 'attempt DIRECTORY', 'Create a new kata attempt in your own directory'
    def attempt(kata)
      matching_kata_readme = Dir.glob(File.join(Dir.pwd, 'katas', "[0-9]*-#{kata}.md")).first
      raise "Unknown kata: #{kata}" if matching_kata_readme.nil?

      configuration = CleoKatas::Configuration.new
      target_directory = File.join(Dir.pwd, 'katas', kata, configuration.username)
      main_target_file = File.join(target_directory, 'main.rb')
      readme_target_file = File.join(target_directory, 'README.md')

      empty_directory(target_directory)
      copy_file(matching_kata_readme, readme_target_file)
      append_file(readme_target_file, <<~MARKDOWN)

        ---#{' '}

        ## How to run your main file#{' '}

        ```
        bundle exec ruby katas/#{kata}/#{configuration.username}/main.rb
        ```

      MARKDOWN
      template('main.rb.erb', main_target_file)

      say "Created new kata attempt directory at #{target_directory} with a main.rb file"
    end
  end
end
