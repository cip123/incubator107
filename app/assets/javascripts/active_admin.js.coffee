//= require active_admin/base
//= require tinymce-jquery
//= require just_datetime_picker/nested_form_workaround

$(document).ready ->
  tinyMCE.init
    selector: 'textarea.tinymce'
    menubar : false    
    plugins: "uploadimage link"
    toolbar1: "styleselect | bold italic | undo redo | link uploadimage"
    style_formats: [
        {title: 'Bold text', inline: 'b'},
        {title: 'Red text', inline: 'span', styles: {color: '#ff0000'}},
        {title: 'Red header', block: 'h1', styles: {color: '#ff0000'}},
        {title: 'Example 1', inline: 'span', classes: 'example1'},
        {title: 'Example 2', inline: 'span', classes: 'example2'},
        {title: 'Table styles'},
        {title: 'Table row 1', selector: 'tr', classes: 'tablerow1'}
    ]

  tinyMCE.init
    selector: 'textarea.tinymce-light'
    plugins: "link code"
    menubar : false
    height : 100    
    toolbar1: "bold italic | link | code"     
  return

