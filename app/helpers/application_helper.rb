# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def sort_th_class_helper(param)
    result = 'class="sortup"' if params[:sort] == param
    result = 'class="sortdown"' if params[:sort] == param + "_reverse"
    return result
  end
  
  def sort_link_helper(text, param, controller = 'sprints', action = 'index')
    key = param
    key += "_reverse" if params[:sort] == param
    options = {
        :url => { :controller => controller, :action => action, :params => {:sort => key} },
        :update => 'table',
        :method => :get,
        :before => "Element.show('spinner')",
        :success => "Element.hide('spinner')"
    }
    html_options = {
      :title => "Sort by this field",
      :href => url_for( :controller => controller, :action => action, :params => {:sort => key})
    }
    link_to_remote(text, options, html_options)
  end
end
