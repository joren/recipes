jQuery ->
  $('.js-tags').selectize
    plugins: ['remove_button']
    delimiter: ','
    persist: false
    create: (input) ->
      {
        value: input
        text: input
      }
