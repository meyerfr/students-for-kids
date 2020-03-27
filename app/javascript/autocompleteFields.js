// import 'js-autocomplete/auto-complete.css';
import autocomplete from 'js-autocomplete';

const autocompleteSearch = function() {
  const formSearch = document.getElementById('search-data');

  if (formSearch) {
    const data = JSON.parse(document.getElementById('search-data').dataset.data)
    const searchInput = formSearch.querySelector('.search-input');
    if (data && searchInput) {
      new autocomplete({
        selector: searchInput,
        minChars: 1,
        source: function(term, suggest){
          term = term.toLowerCase();
          const choices = data;
          const matches = [];
          for (let i = 0; i < choices.length; i++)
              if (~choices[i].toLowerCase().indexOf(term)) matches.push(choices[i]);
          suggest(matches);
          console.log(matches);
        },
      });
    };
  };
};

export { autocompleteSearch };
