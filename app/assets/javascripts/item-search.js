document.addEventListener("DOMContentLoaded", function () {
  var input = $("#borrow_item_field");
  var options = {
    getValue: function (element) {
      return element.brand + " " +
        element.name + " (" + element.inventory_tag + ")";
    },
    url: function (phrase) {
      return "/items/search.json?q=" + phrase;
    },
    adjustWidth: true,
    listLocation: "items",
    list: {
      onChooseEvent: function () {
        var value = input.getSelectedItemData().inventory_tag;
        input.val(value);
        $("#borrow_item").submit();
      },
      maxNumberOfElements: 8,
    },
    template: {
      type: "custom",
      method: function (value, item) {
        return item.brand + " " +
          item.name + " (" + item.inventory_tag + ")";
      }
    }
  }

  input.easyAutocomplete(options);
});
