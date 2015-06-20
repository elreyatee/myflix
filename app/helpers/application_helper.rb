module ApplicationHelper
  def star_ratings 
    [5, 4, 3, 2, 1].map { |num| [pluralize(num, 'Star')] }
  end
end
