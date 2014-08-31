if typeof window.CMS != "undefined"
  window.CMS.wysiwyg = ->
    tinymce.init
        selector: 'textarea[data-cms-rich-text]'
        plugins: 'table fullscreen image link anchor media code'
        toolbar1: 'insertfile undo redo | styleselect | fontselect fontsizeselect | bold italic underline | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent '
        toolbar2: 'link image media | table fullscreen | anchor | code '