# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# jQuery -> $("#member_loans").dataTable()
# jQuery ->
# $(document).ready -> $('#member_loans').DataTable({retrieve: true, ordering: false, searching: true, lengthChange: false});

@inventoryFocus = () ->
    $("input[autofocus='autofocus']").focus();

$('document').ready ->
    setTimeout(inventoryFocus, 50);