class Generation
  attr_reader :populations
  def initialize(*populations)
    @populations = populations
  end

  def total_population_count
    populations.sum(&:count)
  end
  def randomly_select_competitor!
    random_creature_index = rand(total_population_count) + 1
    offset = 0
    selected_population = populations.find do |population|
      break population if (offset..offset + population.count).include?(random_creature_index)

      offset += population.count
      nil
    end
    selected_population.randomly_select_competitor!
  end
end