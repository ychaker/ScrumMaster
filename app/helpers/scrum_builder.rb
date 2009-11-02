class ScrumBuilder < ActionView::Helpers::FormBuilder
  
  # Genereate a select list of fibonacci numbers 
  def fibonacci_select(field_name, *args)
    @template.select(@object_name, field_name, [0,1,2,3,5,8,13,16,20])
  end
end