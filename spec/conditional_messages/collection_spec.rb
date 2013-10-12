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

  end
end
