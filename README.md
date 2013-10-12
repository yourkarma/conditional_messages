# Conditional Messages

Conditional Messages is a small rule engine for selecting one of several
possible messages. You can use this, for example, to display a personalized
headline.

The DSL is made to be verifiable and editable by your non-technical colleages.

### Example

``` ruby
messages = ConditionalMessages.define do

  # define a category for the possible messages of :introduction
  category :introduction do

    # The different kind of introduction messages are defined below:

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

  category :follow_up do
    # etc ...
  end

end

david = { name: "David", widgets_count: 8 }
messages[:introduction].for(david).text
# => "Good job, David, why not add some more?"

sandra = { name: "Sandra", widgets_count: 11 }
messages[:introduction].for(sandra).text
# => "What are you going to do with 11 widgets?"
```

## Installation

Add this line to your application's Gemfile:

``` ruby
gem 'conditional_messages'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install conditional_messages
```

## Usage

The example above shows all the basic concepts. Here are some more details.

### Rules

For a category, a message will be selected according to these rules:

* All required rules must pass.
* Each rule is then scored: required rule yields 100 points, optional rule yields 10 points.
* The message with the highest score will be selected.
* In the event of a tie, one will be chosen at random.

### Directory loading

You can also specify a directory to load categories from, if that is your thing.
When you do that, the file names become the names of the category.

So imagine you have a file called `config/messages/introduction.rb`, with the
following content:

``` ruby
message "Good morning, %{name}" do
  required { Time.now.hour < 12 }
end

message "Good afternoon, %{name}" do
  required { Time.now.hour >= 12 }
  required { Time.now.hour < 19 }
end

message "Good evening, %{name}" do
  required { Time.now.hour >= 19 }
end

message "Hi, %{name}"
```

Then you can load this, by specifying the directory:

``` ruby
directory = Rails.root.join("config/messages")
messages = ConditionalMessages.directory(directory)

messages[:introduction].for(name: "John").text
```

### Markdown support

When you have Redcarpet and Nokogiri loaded, texts will be parsed as markdown.
In this case, there will be two versions you can access: one with HTML, and one
with all the HTML stripped out.

``` ruby
require "redcarpet"
require "nokogiri"

messages = ConditionalMessages.define do
  category :introduction do
    message "Hi, **%{name}**"
  end
end

message = messages[:introduction].for(name: "Sarah")
message.text # => "Hi, Sarah"
message.html # => "Hi, <strong>Sarah</strong>"
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
