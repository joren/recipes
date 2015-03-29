jQuery ->
  # nested_form uses <a> elements by default. See config/initializers/nested_form_buttons.rb
  $(document)
    .delegate('form button.add_nested_fields',    'click', nestedFormEvents.addFields)
    .delegate('form button.remove_nested_fields', 'click', nestedFormEvents.removeFields);

  $('form').on 'keyup blur', '.js-nested-form-auto-add input[type=text]', (e) ->
    if $(this).val() && $(this).parents('.js-nested-form-auto-add').find('input[type=text]:visible, input[type=url]:visible').filter(-> $(this).val() == '').length == 0
      $(this).parents('.js-nested-form-auto-add').find('.add_nested_fields').trigger 'click'

  $(document).on 'nested:fieldRemoved', (e) ->
    $group = e.field.parents('.js-nested-form-auto-add')
    if $group.find('input[type=text]:visible, input[type=url]:visible').filter(-> $(this).val() == '').length == 0
      $group.find('.add_nested_fields').trigger 'click'
