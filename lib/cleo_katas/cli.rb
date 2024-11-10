# frozen_string_literal: true

require 'thor'
module CleoKatas
  class CLI < Thor
    desc 'list', 'List all available katas'
    def list
      puts 'Listing katas...'
      Dir.glob(File.join(Dir.pwd, 'katas', '*')).each do |kata|
        puts kata.split('/').last
      end
    end
  end
end
