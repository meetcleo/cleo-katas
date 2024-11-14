require_relative '../models/competition'

require 'bundler/inline'
gemfile do
  source 'https://rubygems.org'
  gem 'minitest', require: 'minitest/autorun'

end

class CompetitionTest < Minitest::Test
  def test_rock_beats_scissors
    competition = Competition.new(:rock, :scissor)
    assert_equal({ :rock=> 2, :scissor => 0 }, competition.impact_on_populations)
  end

  def test_rock_beats_scissors_reverse
    competition = Competition.new( :scissor, :rock)
    assert_equal({:scissor => 0, :rock => 2 }, competition.impact_on_populations)
  end

  def test_scissors_beats_paper
    competition = Competition.new(:scissor, :paper)
    assert_equal({:scissor => 2, :paper => 0 }, competition.impact_on_populations)
  end

  def test_scissors_beats_paper_reverse
    competition = Competition.new(:paper,:scissor)
    assert_equal({:scissor => 2, :paper => 0 }, competition.impact_on_populations)
  end

  def test_paper_beats_rock
    competition = Competition.new(:paper, :rock)
    assert_equal({:rock => 0, :paper => 2 }, competition.impact_on_populations)
  end
  def test_paper_beats_rock_reverse
    competition = Competition.new( :rock, :paper)
    assert_equal({:rock => 0, :paper => 2 }, competition.impact_on_populations)
  end

  def test_draws
    competition = Competition.new(:paper, :paper)
    assert_equal({:paper => 2}, competition.impact_on_populations)
  end
end