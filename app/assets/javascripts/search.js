document.addEventListener("DOMContentLoaded", function () {
  input = $("#member_search_field");
  var options = {
    getValue: function (element) {
      return element.name + " (" +
             element.id_number + ")";
    },
    url: function (phrase) {
      return "/members/search.json?q=" + phrase;
    },
    adjustWidth: true,
    listLocation: "members",
    list: {
      onChooseEvent: function () {
        var url = input.getSelectedItemData().url;
        location.href = url;
      },
      maxNumberOfElements: 8,
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