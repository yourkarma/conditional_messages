require "pathname"

module ConditionalMessages
  class Directory

    EXTENSION = ".rb"

    attr_reader :directory

    def initialize(name)
      @directory = Pathname(name)
    end

    def load
      files.each do |file|
        name = file.basename(EXTENSION).to_s
        code = directory.join(file).read
        collection.category(name).define(code)
      end
      collection
    end

    private

    def collection
      @collection ||= Collection.new
    end

    def files
      directory.children(false).select { |f| f.extname == EXTENSION }
    end

  end
end
