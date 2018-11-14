document.addEventListener("turbolinks:load", function () {
  input = $("#member-autocomplete");
  var options = {
    // getValue: "id_number",
    getValue: function (element) {
      return element.name + " (" +
             element.id_number + ")";
    },
    url: function (phrase) {
      console.log("phrase = " + phrase);
      return "/members/search.json?q=" + phrase;
    },
    listLocation: "members",
    list: {






      onChooseEvent: function () {
        var url = input.getSelectedItemData().url;
        var id_number = input.getSelectedItemData().id_number;

        console.log("url = " + url);
        input.val("");

        Turbolinks.visit(url);
      },
      match: {
        enabled: true
      }
    },
    template: {
      type: "custom",
      method: function (value, person) {
        return person.name + " (" +
              person.id_number + ")";
      }
    }
  }

  input.easyAutocomplete(options)
});