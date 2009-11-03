module SprintsHelper 
  
  def burndown sprint
    "<img src=" + sprint.burndown.to_url + " alt='burndown' title='burndown' />"
  end

end
