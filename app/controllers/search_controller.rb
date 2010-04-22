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
  
  def make_searchable
    @not_prepared_items = SearchableItem.find_grouped_by_model_and_type
    SunspotSearch.make_searchable @not_prepared_items
    SearchableItem.update_all( "status = '#{SearchableItem::PREPARED}'", "status = '#{SearchableItem::NOTPREPARED}'" )
    redirect_to :action => :admin
  end

  def reindex
    @prepared_items = SearchableItem.find_grouped_by_model_and_type
    SunspotSearch.reindex @prepared_items.keys
    SearchableItem.update_all( "status = '#{SearchableItem::INDEXED}'", "status = '#{SearchableItem::PREPARED}'" )
    redirect_to :action => :admin
  end

  def make_searchable_and_reindex
    @not_prepared_items = SearchableItem.find_grouped_by_model_and_type
    SunspotSearch.make_searchable @not_prepared_items
    SunspotSearch.reindex @not_prepared_items.keys
    SearchableItem.update_all( "status = '#{SearchableItem::INDEXED}'", "status = '#{SearchableItem::NOTPREPARED}' OR status = '#{SearchableItem::PREPARED}'" )
    redirect_to :action => :admin
  end
  
  def admin
    Dir.glob(RAILS_ROOT + '/app/models/**/*.rb').each { |file| require file }
    @models = SearchableItem.find_nonsearchable_app_models_and_attributes
    @unprepared = SearchableItem.find(:all, :conditions => {:status => SearchableItem::NOTPREPARED}, :order => :model)
    @prepared = SearchableItem.find(:all, :conditions => {:status => SearchableItem::PREPARED}, :order => :model)
    @indexed = SearchableItem.find(:all, :conditions => {:status => SearchableItem::INDEXED}, :order => :model)
  end
  
  def add_searchable_item
    @item = SearchableItem.new(params[:attribute])

    respond_to do |format|
      if @item.save
        flash[:notice] = 'Item was successfully added.'
        format.html { redirect_to(:action => :admin) }
      else
        flash[:error] = 'Error adding item.'
        format.html { redirect_to(:action => :admin) }
      end
    end
  end
  
  def remove_searchable_item
    @item = SearchableItem.find(params[:id])
    @item.destroy
    @not_prepared_items = SearchableItem.find_grouped_by_model_and_type
    SunspotSearch.make_searchable @not_prepared_items
    SunspotSearch.reindex @not_prepared_items.keys
    SearchableItem.update_all( "status = '#{SearchableItem::INDEXED}'", "status = '#{SearchableItem::NOTPREPARED}' OR status = '#{SearchableItem::PREPARED}'" )
    redirect_to(:action => :admin)
  end
  
end
