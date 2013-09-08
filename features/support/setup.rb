class Output
  def messages
    @messages ||= []
  end

  def puts(message)
    messages << message
  end
end

def output
  @output ||= Output.new
end

def buttons
  Swamp::Buttons.new
end

def fields
  Swamp::Fields.new
end

def input_buttons
  Swamp::InputButtons.new
end

def select_boxes
  Swamp::SelectBoxes.new
end

def wrapper
  meta_collection = [fields, buttons, input_buttons, select_boxes]
  Swamp::Wrapper.new(meta_collection)
end

def swamp
  @swamp ||= Swamp::Interface.new(output, wrapper)
end
