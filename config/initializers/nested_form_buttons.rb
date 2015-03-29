module NestedForm::BuilderMixin
  def button_to_add(*args, &block)
  options = args.extract_options!.symbolize_keys
  association = args.pop

  unless object.respond_to?("#{association}_attributes=")
    raise ArgumentError, "Invalid association. Make sure that accepts_nested_attributes_for is used for #{association.inspect} association."
  end

  model_object = options.delete(:model_object) do
    reflection = object.class.reflect_on_association(association)
    reflection.klass.new
  end
  options[:class] = [options[:class], "add_nested_fields"].compact.join(" ")
  options["data-association"] = association
  options["data-blueprint-id"] = fields_blueprint_id = fields_blueprint_id_for(association)
  options["type"] = "button"
  args << options
  @fields ||= {}
  @template.after_nested_form(fields_blueprint_id) do
    blueprint = {:id => fields_blueprint_id, :style => 'display: none'}
    block, options = @fields[fields_blueprint_id].values_at(:block, :options)
    options[:child_index] = "new_#{association}"
    blueprint[:"data-blueprint"] = fields_for(association, model_object, options, &block).to_str
    @template.content_tag(:div, nil, blueprint)
  end
  @template.button_tag(*args, &block)
end


  def button_to_remove(*args, &block)
    options = args.extract_options!.symbolize_keys
    options[:class] = [options[:class], "remove_nested_fields"].compact.join(" ")
    # Extracting "milestones" from "...[milestones_attributes][...]"
    md = object_name.to_s.match /(\w+)_attributes\]\[[\w\d]+\]$/
    association = md && md[1]
    options["data-association"] = association
    options["type"] = "button"
    args << options
    hidden_field(:_destroy) << @template.button_tag(*args, &block)
  end
end
