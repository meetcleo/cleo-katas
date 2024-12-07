# frozen_string_literal: true

module CleoKatas
  # Represents a Kata README file in the katas directory
  class KataFile
    KATAS_DIR = 'katas'
    KATA_FILE_NAME_REGEX = %r{#{KATAS_DIR}/(?<kata_number>[0-9]*)-(?<kata_name>.*)/README\.md}
    KATA_FILE_NAME_GLOB = "#{KATAS_DIR}/[0-9]*-*/README.md".freeze

    attr_reader :number, :name, :path, :numbered_name

    def self.all
      Dir.glob(File.join(Dir.pwd, KATA_FILE_NAME_GLOB)).map do |kata_file|
        puts kata_file
        match_data = kata_file.match(KATA_FILE_NAME_REGEX)
        new(number: match_data[:kata_number],
            name: match_data[:kata_name])
      end
    end

    def self.find(kata_name)
      all.find { |kata_file| kata_file.name == kata_name }
    end

    def initialize(number:, name:)
      @number = number
      @name = name
      @numbered_name = "#{number}-#{name}"
      @path = File.join(Dir.pwd, KATAS_DIR, "#{numbered_name}/README.md")
    end
  end
end
