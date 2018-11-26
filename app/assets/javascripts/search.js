document.addEventListener("turbolinks:load", function () {
  // $('#searchInput')
  //   .api({
  //     action: 'search',
  //     url: '/members/search.json?q={query}',
  //     onResponse: function(results) {
  //         var response = {
  //             results : []
  //         };
  //         $.each(results, function(index, item) {
  //             response.results.push({
  //               title: item.title, // $results['items'][]['name']
  //               description: item.description, // $results['items'][]['currency']
  //               url: item.url
  //             });
  //         });
  //         console.log(results);
  //         return {"results" : results};
  //     },
  //   })
  // ;
  //   $('#searchInput').search({
  //       action: 'search',
  //       minCharacters : 1
  //     });
  $('.ui.search')
    .search({
      minCharacters : 2,
      apiSettings: {
        url: '/members/search.json?q={query}'
      },
      fields: {
        results : 'results',
        title   : 'title',
        url     : 'html_url'
      }
    })
  ;

});