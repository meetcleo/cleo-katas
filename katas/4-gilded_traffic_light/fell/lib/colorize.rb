# Provides helper methods for colorized text
module Colorize
  RED = -"\e[31m"
  GREEN = -"\e[32m"
  AMBER = -"\e[33m"
  RESET = -"\e[0m"

  def red(string)
    "#{RED}#{string}#{RESET}"
  end

  def green(string)
    "#{GREEN}#{string}#{RESET}"
  end

  def amber(string)
    "#{AMBER}#{string}#{RESET}"
  end
end
