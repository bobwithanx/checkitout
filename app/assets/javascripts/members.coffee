# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# jQuery -> $("#member_loans").dataTable()

$(document).ready -> $('#member_loans').DataTable({scrollY: '50vh', scrollCollapse: true, paging: false, ordering: false, searching: false});
