$ ->
  CKEDITOR.config.protectedSource.push( /{{[\s\S]*?}}/g )

  if ($.fn.ckeditor)
    $('textarea[data-ckeditor]').each ->
      input = $(@)
      config = $.parseJSON input.attr('data-ckeditor')
      config.resize_enabled = config.resize_enabled || false
      config.toolbarCanCollapse = config.toolbarCanCollapse || false
      input.ckeditor(config)
