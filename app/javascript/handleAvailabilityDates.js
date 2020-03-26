const updateEndDate = (event) => {
  event.preventDefault();
  var target = event.currentTarget;
  // console.log(target)
  var startDateContainer = target.parentElement;
  var day = startDateContainer.children[0].value;
  var month = startDateContainer.children[1].value;
  var year = startDateContainer.children[2].value;

  var allEndDateInputs = target.parentElement.nextElementSibling.querySelectorAll('input');
  allEndDateInputs[0].value = day;
  allEndDateInputs[1].value = month;
  allEndDateInputs[2].value = year;
}

export { updateEndDate }
