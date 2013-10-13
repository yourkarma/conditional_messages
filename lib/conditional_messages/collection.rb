require "conditional_messages/category"
require "conditional_messages/read_category"

module ConditionalMessages
  class Collection
    include Enumerable

    def define(&definition)
      instance_eval(&definition)
    end

    def category(name, &definition)
      category = Category.new(name.to_s)
      categories[name.to_s] = category
      category.define(&definition) if definition
      category
    end

    def categories
      @categories ||= {}
    end

    def [](key)
      ReadCategory.new(categories.fetch(key.to_s))
    end

    def each
      categories.each do |name, category|
        yield self[name]
      end
    end

  end
end
