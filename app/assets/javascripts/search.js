document.addEventListener("turbolinks:load", function () {
  $input = $("#member-autocomplete")
  var options = {
    getValue: function (element) {
      return element.name + " (" + element.id_number + ")";
    },
    url: function (phrase) {
      return "/members/search.json?q=" + phrase;
    },
    listLocation: "members",
    list: {
      onChooseEvent: function () {
        var url = $input.getSelectedItemData().url
        $input.val("")
        console.log("url = " + url);

        Turbolinks.visit(url)
      },
      match: {
        enabled: true
      }
    }
  }

  $input.easyAutocomplete(options)
});