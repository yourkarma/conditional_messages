require "conditional_messages/version"
require "conditional_messages/collection"
require "conditional_messages/directory"

module ConditionalMessages

  def self.define(*args, &definition)
    collection = Collection.new(*args)
    collection.define(&definition)
    collection
  end

  def self.directory(directory)
    Directory.new(directory).load
  end

end
