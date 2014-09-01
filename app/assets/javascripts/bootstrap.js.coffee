jQuery ->
    if $("a[rel~=popover], .has-popover").length != 0
        $("a[rel~=popover], .has-popover").popover()
    if $("a[rel~=tooltip], .has-tooltip").length != 0
        $("a[rel~=tooltip], .has-tooltip").tooltip()
