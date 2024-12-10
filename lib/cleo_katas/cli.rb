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

    desc 'create', 'Create a new kata'
    def create(kata_name)
      self.kata = kata_name

      kata_number = CleoKatas::KataFile.max_number.to_i + 1
      kata_name = kata_name.gsub(/[^a-z0-9]/i, '_').downcase
      kata_number_name = "#{kata_number}-#{kata_name}"

      say "Creating kata #{kata_number_name}"

      empty_directory(File.join(Dir.pwd, 'katas', "#{kata_number_name}"))
      empty_directory(File.join(Dir.pwd, 'katas', "#{kata_number_name}", 'source'))
      template('README.md.erb',
               File.join(Dir.pwd, 'katas', "#{kata_number_name}", 'README.md')
      )
      template(
        'main.rb.erb',
                File.join(Dir.pwd, 'katas', "#{kata_number_name}", 'source', 'main.rb')
      )
      template(
        'test.rb.erb',
               File.join(Dir.pwd, 'katas', "#{kata_number_name}", 'source', 'test.rb')
      )
    end

    desc 'list', 'List all available katas'
    def list
      say 'Listing katas...'
      CleoKatas::KataFile.all.each do |kata_file|
        say "#{kata_file.number}: #{kata_file.name}"
      end
    end

    # rubocop:disable Metrics/MethodLength
    desc 'attempt DIRECTORY', 'Create a new kata attempt in your own directory'
    def attempt(kata_name)
      self.kata = kata_name

      begin
        kata_file.numbered_name
      rescue
        say "Kata #{kata_name} not found"
        return
      end

      source_directory = File.join(Dir.pwd, 'katas', kata_file.numbered_name, 'source')
      target_directory = File.join(Dir.pwd, 'katas', kata_file.numbered_name, username)
      readme_target_file = File.join(target_directory, 'README.md')

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

    protected


    def kata_class_name
      kata.to_s.split(/[^a-z0-9]+/i).map(&:capitalize).join
    end

    private

    def username
      CleoKatas::Configuration.new.username
    end

    def kata_file
      @kata_file ||= CleoKatas::KataFile.find(kata)
    end
  end
end
