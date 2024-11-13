require_relative '../models/competition'

require 'bundler/inline'
gemfile do
  source 'https://rubygems.org'
  gem 'minitest', require: 'minitest/autorun'

end

class CompetitionTest < Minitest::Test
  def test_rock_beats_scissors
    competition = Competition.new('Rock', 'Scissor')
    assert_equal({ 'Rock'=> 2, 'Scissor' => 0 }, competition.impact_on_populations)
  end

  def test_rock_beats_scissors_reverse
    competition = Competition.new( 'Scissor', 'Rock')
    assert_equal({'Scissor' => 0, 'Rock' => 2 }, competition.impact_on_populations)
  end

  def test_scissors_beats_paper
    competition = Competition.new('Scissor', 'Paper')
    assert_equal({'Scissor' => 2, 'Paper' => 0 }, competition.impact_on_populations)
  end

  def test_scissors_beats_paper_reverse
    competition = Competition.new('Paper','Scissor')
    assert_equal({'Scissor' => 2, 'Paper' => 0 }, competition.impact_on_populations)
  end

  def test_paper_beats_rock
    competition = Competition.new('Paper', 'Rock')
    assert_equal({'Rock' => 0, 'Paper' => 2 }, competition.impact_on_populations)
  end
  def test_paper_beats_rock_reverse
    competition = Competition.new( 'Rock', 'Paper')
    assert_equal({'Rock' => 0, 'Paper' => 2 }, competition.impact_on_populations)
  end

  def test_draws
    competition = Competition.new('Paper', 'Paper')
    assert_equal({'Paper' => 2}, competition.impact_on_populations)
  end
end