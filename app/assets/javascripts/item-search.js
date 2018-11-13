document.addEventListener("turbolinks:load", function () {
  input = $("#item-autocomplete");
  var options = {
    getValue: "inventory_tag",
    // getValue: function (element) {
    //   return element.brand + " " +
    //     element.name + " (" + element.inventory_tag + ")";
    // },
    url: function (phrase) {
      console.log("phrase = " + phrase);
      return "/items/search?q=" + phrase;
    },
    listLocation: "items",
    list: {
      // onSelectItemEvent: function () {
      //   var value = $("#function-data").getSelectedItemData().realName;

      //   $("#data-holder").val(value).trigger("change");
      // }

      onChooseEvent: function () {
        var value = $input.getSelectedItemData().inventory_tag;

        console.log("inventory_tag = " + value);
        $input.val(value);
        // $("#borrow-form").submit();
        // $input.focus();
      },
      match: {
        enabled: true
      }
    },
    template: {
      type: "custom",
      method: function (value, item) {
        return item.brand + " " +
          item.name + " (" + item.inventory_tag + ")";
      }
    }
  }

  input.easyAutocomplete(options)
});