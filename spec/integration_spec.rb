require "spec_helper"
require "conditional_messages"

describe ConditionalMessages do

  it "finds a conditional message" do

    messages = ConditionalMessages.define do

      category :introduction do

        message "Hi %{name}, buy some widgets to get started!" do
          required { widgets_count == 0 }
          optional { name == "Bob" }
        end

        message "Good job, %{name}, why not add some more?" do
          required { widgets_count > 0 }
          required { widgets_count < 10 }
        end

        message "What are you going to do with %{widgets_count} widgets?" do
          required { widgets_count > 10 }
        end

      end

    end

    david = { name: "David", widgets_count: 8 }
    message = messages[:introduction].for(david).text
    expect(message).to eq "Good job, David, why not add some more?"

    sandra = { name: "Sandra", widgets_count: 11 }
    message = messages[:introduction].for(sandra).text
    expect(message).to eq "What are you going to do with 11 widgets?"

  end

  it "can load a directory, where each file is a category" do
    directory = File.expand_path("../support/examples", __FILE__)
    messages = ConditionalMessages.directory(directory)

    david = { name: "David", widgets_count: 8 }
    message = messages[:introduction].for(david).text
    expect(message).to eq "Good job, David, why not add some more?"

    sandra = { name: "Sandra", widgets_count: 11 }
    message = messages[:introduction].for(sandra).text
    expect(message).to eq "What are you going to do with 11 widgets?"
  end

  it "can parse markdown" do
    require "redcarpet"
    require "nokogiri"

    messages = ConditionalMessages.define do
      category :introduction do
        message "Hi, **%{name}**"
      end
    end

    message = messages[:introduction].for(name: "Sarah")
    expect(message.text).to eq "Hi, Sarah"
    expect(message.html).to eq "Hi, <strong>Sarah</strong>"
  end

end
