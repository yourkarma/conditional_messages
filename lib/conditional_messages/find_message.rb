module ConditionalMessages
  class FindMessage

    def self.for(*args)
      new(*args).find_message
    end

    attr_reader :context_holder, :category

    def initialize(context_holder, category)
      @context_holder = context_holder
      @category = category
    end

    def find_message
      applied_messages = category.apply(context_holder)
      messages_where_all_required_rules_pass = applied_messages.select(&:all_required_rules_pass?)
      by_score = messages_where_all_required_rules_pass.group_by(&:score)
      winners = by_score.sort_by { |score, messages| score }.last.last
      winners.sample
    end

  end
end
