module NavigationHelpers
  def path_to(page)
    case page
    when /^the front page$/
      root_path
    when /^the ([\w ]+) page$/
      send("#{$1.gsub(/\W+/, '_')}_path")
    else
      raise "Can't find mapping from \"#{page}\" to a path."
    end
  end
end


RSpec.configure { |c| c.include NavigationHelpers }