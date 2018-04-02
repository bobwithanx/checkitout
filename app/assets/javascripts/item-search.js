document.addEventListener("turbolinks:load", function () {
  $input = $("#item-autocomplete")
  var options = {
    getValue: "inventory_tag",
    url: function (phrase) {
      return "/items/search.json?q=" + phrase;
    },
    listLocation: "items",
    list: {
      onChooseEvent: function () {
        var inventory_tag = $input.getSelectedItemData().inventory_tag
        $input.val(inventory_tag)
        // $("#borrow-form").submit();
        $input.focus();
      },
      match: {
        enabled: true
      }
    },
    template: {
      type: "custom",
      method: function (value, item) {
        return item.name + " (" + item.inventory_tag + ")";
      }
    }
  }

  $input.easyAutocomplete(options)
});