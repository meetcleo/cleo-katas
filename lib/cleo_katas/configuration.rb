# frozen_string_literal: true

require 'yaml'
require 'delegate'
module CleoKatas
  # Stores configured preferences for this user
  class Configuration < DelegateClass(Hash)
    CONFIG_FILE_PATH = '.cleo-katas.yml'

    def initialize
      if File.file?(CONFIG_FILE_PATH)
        super(YAML.load_file(CONFIG_FILE_PATH))
      else
        # Blank config
        super(Hash.new(''))
      end
    end

    # The preferred username for this User. Will fall back to their git config username or their
    # system username if not set.
    #
    # @return [String]
    def username
      [
        self['username'],
        git_username,
        whoami
      ].reject(&:empty?).first
    end

    private

    # The configured git username for the current git context (probably ~/.gitconfig)
    #
    # @return [String]
    def git_username
      `git config --get user.username`.strip.downcase
    end

    # The system username for the local machine
    #
    # @return [String]
    def whoami
      `whoami`.strip.downcase
    end
  end
end
