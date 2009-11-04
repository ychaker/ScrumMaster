module SprintsHelper 
  def burndown sprint
    "<img src=" + sprint.burndown.to_url + " alt='burndown' title='burndown' />"
  end

  def sort_tasks_table_helper(text, param)
    key = param
    key += "_reverse" if params[:sort] == param
    options = {
        :url => { :action => "show", :params => {:sort => key} },
        :method => :get
    }
    html_options = {
      :title => "Sort by this field",
      :href => url_for( :action => "show", :params => {:sort => key})
    }
    link_to(text, options, html_options)
  end
  
  def sprint_sums_helper(text, array)
    render :partial => '/sprints/sums_row', :locals => { :text => text, :array => array }
  end
end
