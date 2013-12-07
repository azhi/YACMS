$ ->
  CKEDITOR.config.extraAllowedContent = 'img[!data-image-id, data-image-resizing-width, data-image-resizing-height]; a[data-file-id]'
  CKEDITOR.on 'instanceReady', (evt) ->
    editor = evt.editor
    html_rules = elements:
      hr: (element) ->
        if element.attributes.class == 'CKEDITOR_cut'
          element.name = 'cut'
          $.each Object.keys(element.attributes), (i, key) ->
            delete element.attributes[key]
          $.each element.children, (child) ->
            child.remove
        element
    data_rules = elements:
      cut: (element) ->
        element.name = 'hr'
        element.attributes.class = 'CKEDITOR_cut'
        element

    editor.dataProcessor.htmlFilter.addRules html_rules
    editor.dataProcessor.dataFilter.addRules data_rules

    editor.filter.allow "cut"


  if ($.fn.ckeditor)
    $('textarea[data-ckeditor]').each ->
      input = $(@)
      config = $.parseJSON input.attr('data-ckeditor')
      config.resize_enabled = config.resize_enabled || false
      config.toolbarCanCollapse = config.toolbarCanCollapse || false
      input.ckeditor(config)
