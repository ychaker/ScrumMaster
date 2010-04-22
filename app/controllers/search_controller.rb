class SearchController < ApplicationController
  
  def index
    @klasses = SearchableItem.find_grouped_by_model_and_type.keys
    if params[:model].blank? || params[:model] == 'All'
      klasses = @klasses.collect { |klass| Object.const_get(klass) }
      @search = Sunspot.search(klasses) do
        keywords(params[:q])
        paginate :page => params[:page], :per_page => 15
      end
    else
      @search = Sunspot.search(Object.const_get(params[:model])) do
        keywords(params[:q])
        paginate :page => params[:page], :per_page => 15
      end
    end
  end

end
