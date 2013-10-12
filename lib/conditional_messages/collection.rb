require "conditional_messages/category"
require "conditional_messages/read_category"

module ConditionalMessages
  class Collection

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

  end
end
