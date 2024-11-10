# frozen_string_literal: true

require 'yaml'
require 'delegate'
module CleoKatas
  # Stores configured preferences for this user
  class Configuration < DelegateClass(Hash)
    def initialize
      super(YAML.load_file('.cleo-katas.yml'))
    end

    # The preferred username for this User or their system username
    # @return [String]
    def username
      self['username'] || `whoami`.strip.downcase
    end
  end
end
