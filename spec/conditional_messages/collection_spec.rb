require "conditional_messages/collection"

module ConditionalMessages
  describe Collection do

    it "builds categories" do

      collection = Collection.new

      collection.define do
        category :the_name do
        end
        category :other_name do
        end
      end

      expect(collection).to have(2).categories

      expect(collection[:the_name]).not_to be_nil

    end

    it "is enumerable" do
      collection = Collection.new

      collection.define do
        category :the_name do
        end
        category :other_name do
        end
      end

      found = []

      found = collection.map(&:name)

      expect(found).to eq ["the_name", "other_name"]
    end

  end
end
