# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  config.boolean_label_class = nil
  config.button_class = 'btn btn-success'
  config.error_notification_class = 'alert alert-danger'
  config.form_class = 'form-horizontal' # DEPRECATED since simple_form 3.1. Will be removed in 4.0.
  config.default_form_class = 'form-horizontal'
  config.label_text = lambda { |label, required, explicit_label| "#{label} #{required}" }

  config.wrappers :horizontal_form, tag: 'div', class: 'form-group row', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: 'col-sm-2 control-label'

    b.wrapper tag: 'div', class: 'controls col-sm-10' do |ba|
      ba.use :input, class: 'form-control'
      ba.use :error, wrap_with: { tag: 'span', class: 'help-block' }
      ba.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    end
  end

  config.wrappers :horizontal_file_input, tag: 'div', class: 'form-group row', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :readonly
    b.use :label, class: 'col-sm-2 control-label'

    b.wrapper tag: 'div', class: 'controls col-sm-10' do |ba|
      ba.use :input, class: 'form-control'
      ba.use :error, wrap_with: { tag: 'span', class: 'help-block' }
      ba.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    end
  end

  config.wrappers :horizontal_boolean, tag: 'div', class: 'form-group row', error_class: 'has-error' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'col-sm-2 control-label'

    b.wrapper tag: 'div', class: 'controls col-sm-10' do |wr|
      wr.wrapper tag: 'div', class: 'checkbox' do |ba|
        ba.use :input
      end

      wr.use :error, wrap_with: { tag: 'span', class: 'help-block' }
      wr.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    end
  end

  config.wrappers :horizontal_radio_and_checkboxes, tag: 'div', class: 'form-group row', error_class: 'has-error' do |b|
    b.use :html5
    b.optional :readonly

    b.use :label, class: 'col-sm-2 control-label'

    b.wrapper tag: 'div', class: 'controls col-sm-10' do |ba|
      ba.use :input
      ba.use :error, wrap_with: { tag: 'span', class: 'help-block' }
      ba.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    end
  end

  config.wrappers :anonymous, tag: 'div', class: 'form-group row', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.use :label, class: 'col-sm-2 control-label'
    b.wrapper tag: 'div', class: 'controls col-sm-8' do |ba|
      ba.use :input, class: 'form-control'
      ba.use :hint,  wrap_with: { tag: 'span', class: 'help-block' }
      ba.use :error, wrap_with: { tag: 'span', class: 'help-block has-error' }
    end
  end

  config.wrappers :group, tag: 'div', class: 'form-group row', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.use :label, class: 'col-sm-2 control-label'
    b.wrapper tag: 'div', class: 'controls col-sm-10' do |ba|
      ba.wrapper tag: 'div', class: 'input-group' do |group|
        group.use :prepend, wrap_with: { tag: 'span', class: 'input-group-addon' }
        group.use :input, class: 'form-control'
        group.use :append, wrap_with: { tag: 'span', class: 'input-group-addon' }
      end
      ba.use :hint,  wrap_with: { tag: 'span', class: 'help-block' }
      ba.use :error, wrap_with: { tag: 'span', class: 'help-block has-error' }
    end
  end

  # Wrappers for forms and inputs using the Bootstrap toolkit.
  # Check the Bootstrap docs (http://getbootstrap.com)
  # to learn about the different styles for forms and inputs,
  # buttons and other elements.
  config.default_wrapper = :horizontal_form
  config.wrapper_mappings = {
    check_boxes: :horizontal_radio_and_checkboxes,
    radio_buttons: :horizontal_radio_and_checkboxes,
    file: :horizontal_file_input,
    boolean: :horizontal_boolean,
    generate_password: :group,
    destroyable: :group
  }
end

class SimpleForm::FormBuilder
  def submit_with_cancel text = nil, cancel_link = :back
    text ||= object.new_record? ? :create : :update
    template.content_tag(:hr) +
      template.content_tag(:div, class: 'clearfix') do
        template.content_tag(:div, class: 'col-sm-offset-2') do
          button(:submit, text, data: { disable_with: 'Loading...' }) +
            " of  " +
            template.link_to('Cancel', cancel_link)
        end
      end
  end
end

module SimpleForm
  module Components
    module Prepend
      def prepend _wrapper_options
        @prepend ||= begin
          options[:prepend].to_s.html_safe if options[:prepend].present?
        end
      end

      def has_prepend?
        prepend.present?
      end
    end
  end
end

module SimpleForm
  module Components
    module Append
      def append _wrapper_options
        @append ||= begin
          options[:append].to_s.html_safe if options[:append].present?
        end
      end

      def has_append?
        append.present?
      end
    end
  end
end

SimpleForm::Inputs::Base.send(:include, SimpleForm::Components::Prepend)
SimpleForm::Inputs::Base.send(:include, SimpleForm::Components::Append)
