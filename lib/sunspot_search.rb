
module SunspotSearch
  
  # TODO: figure out a way to remove old searchable block
  def self.make_searchable(klasses = {})
    klasses.each_pair do
      |klass, hash|
      Object.const_get(klass).class_eval do
        searchable do
          hash.each_pair do |type, items|
            # TODO: Use dynamic type instead of just 'string'
            # example: send type, items.collect { |each| each.field.to_sym }
            items.each do |item|
              text item.field.to_sym
            end
          end
        end
      end
    end
  end
  
  def self.reindex(klasses = [])
    Sunspot.remove_all!(klasses.collect{ |klass| Object.const_get(klass) })
    klasses.each { |klass| Object.const_get(klass).reindex }
    Sunspot.commit
  end
  
end

