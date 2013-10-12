require "conditional_messages/category"

module ConditionalMessages
  describe Category do

    subject(:category) { Category.new(:name_of_category) }

    it "has a name" do
      expect(category.name).to eq :name_of_category
    end

    context "when writing messages in a category" do

      before do
        category.define do
          message "source text"
          message "other text"
        end
      end

      it "remembers the messages" do
        expect(category.messages.map(&:source_text)).to eq ["source text", "other text"]
      end

      it "can apply a context to each message" do
        context_holder = double :context_holder
        applied_messages = category.apply(context_holder)
        expect(applied_messages.map(&:context_holder)).to eq [context_holder, context_holder]
      end

    end

  end
end
