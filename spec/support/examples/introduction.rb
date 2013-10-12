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
