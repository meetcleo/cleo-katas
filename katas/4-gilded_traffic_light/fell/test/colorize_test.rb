require_relative '../lib/colorize'
require 'minitest/autorun'

class ColorizeTest < Minitest::Test
  class ColorizedClass
    include Colorize
  end

  def test_red
    test_instance = ColorizeTest::ColorizedClass.new

    assert_equal "\e[31mtest_string\e[0m", test_instance.red("test_string")
  end

  def test_green
    test_instance = ColorizeTest::ColorizedClass.new

    assert_equal "\e[32mtest_string\e[0m", test_instance.green("test_string")
  end

  def test_amber
    test_instance = ColorizeTest::ColorizedClass.new

    assert_equal "\e[33mtest_string\e[0m", test_instance.amber("test_string")
  end
end
