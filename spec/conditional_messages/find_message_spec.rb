require "conditional_messages/find_message"

module ConditionalMessages
  describe FindMessage do

    let(:context) { double :context }

    it "finds message when all required rules pass" do
      passing_message = double :passing_message, all_required_rules_pass?: true, score: 1
      failed_message  = double :failed_message,  all_required_rules_pass?: false

      category = double :category, apply: [failed_message, passing_message]

      found_message = FindMessage.for(context, category)

      expect(found_message).to eq passing_message
    end

    it "finds the message with the highest score when more than one messages pass" do
      high_score = double :high_score, all_required_rules_pass?: true, score: 2
      low_score  = double :low_score,  all_required_rules_pass?: true, score: 1

      category = double :category, apply: [high_score, low_score]

      found_message = FindMessage.for(context, category)

      expect(found_message).to eq high_score
    end

    it "chooses one message at random when in a tie" do
      tie1  = double :tie1,   all_required_rules_pass?: true, score: 2
      tie2  = double :tie2,   all_required_rules_pass?: true, score: 2
      loser = double :loster, all_required_rules_pass?: true, score: 1

      category = double :category, apply: [tie1, tie2, loser]


      tie1_times = 0
      tie2_times = 0
      loser_times = 0

      100.times do
        case FindMessage.for(context, category)
        when tie1  then tie1_times += 1
        when tie2  then tie2_times += 1
        when loser then loser_times += 1
        else raise "Unexpected message!"
        end
      end

      expect(tie1_times + tie2_times).to eq 100
      expect(loser_times).to eq 0

      # this is bound to fail some times
      expect(tie1_times).to be_within(20).of(tie2_times)
    end

  end
end
