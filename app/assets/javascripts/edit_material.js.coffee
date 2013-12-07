$ ->
  $('a.show_select_images_popup').click (e) ->
    e.preventDefault()
    $('.image-select').dialog(
      autoOpen: true,
      modal: true,
      title: 'Please, select image',
      width: 500,
      height: 300,
      maxWidth: 1000,
      maxHeight: 500
    )

  $('.image-resize-params input#enable_resizing').click (e) ->
    disabled = $('.image-resize-params input[type=text]').attr('disabled')
    $('.image-resize-params input[type=text]').attr('disabled', !disabled)

  $('a.add_image').click (e) ->
    e.preventDefault()
    ckeditor_id = $(@).data('ckeditor-id')
    enable_resizing = $('.image-resize-params input#enable_resizing').is(':checked')
    resizing_width = $('.image-resize-params input#resizing_width').val()
    resizing_height = $('.image-resize-params input#resizing_height').val()
    $.ajax({
      dataType: "json",
      url: $(@).attr('href'),
      method: 'post',
      data: {
        image_id: $(@).data('image-id'),
        enable_resizing: enable_resizing,
        resizing_width: resizing_width,
        resizing_height: resizing_height
      },
      success: (data) ->
        editor = CKEDITOR.instances[ckeditor_id]
        if editor
          editor.insertHtml(data.img)
        $('.image-select').dialog('close')
    })

  $('a.add_file').click (e) ->
    e.preventDefault()
    ckeditor_id = $(@).data('ckeditor-id')
    file_id = $('select#select_file').val()
    $.ajax({
      dataType: "json",
      url: $(@).attr('href'),
      method: 'post',
      data: {
        file_id: file_id,
      },
      success: (data) ->
        editor = CKEDITOR.instances[ckeditor_id]
        if editor
          editor.insertHtml(data.file)
    })

  $('a.add_snippet').click (e) ->
    e.preventDefault()
    ckeditor_id = $(@).data('ckeditor-id')
    snippet_id = $('select#select_snippet').val()
    $.ajax({
      dataType: "json",
      url: $(@).attr('href'),
      method: 'post',
      data: {
        snippet_id: snippet_id,
      },
      success: (data) ->
        editor = CKEDITOR.instances[ckeditor_id]
        if editor
          editor.insertHtml(data.snippet)
    })
