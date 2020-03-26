import { updateEndDate } from 'handleAvailabilityDates';

const removeFields = (event) => {
  const parentDiv = event.currentTarget.closest('div');
  event.currentTarget.previousElementSibling.value = '1'; // hidden field _destroy
  // console.log(parentDiv);
  parentDiv.classList.add('d-none');
  // parentDiv.parentElement.scrollIntoView({behavior: "smooth", block: "end"});
  var y = parentDiv.parentElement.offsetTop + parentDiv.parentElement.offsetHeight + 40
  window.scrollTo({top: y, behavior: 'smooth'});
  return event.preventDefault();
}

const addFields = (event) => {
  var regexp, time;
  time = new Date().getTime();
  regexp = new RegExp(event.currentTarget.dataset.id, 'g');
  const target = event.currentTarget;
  var insertIn = target.nextElementSibling; //field where the new form-field must be inserted
  insertIn.insertAdjacentHTML('beforeend', event.currentTarget.dataset.fields.replace(regexp, time)); //insert form-field
  // var insertedElement = insertIn.querySelectorAll('.availability-fields')[insertIn.querySelectorAll('.availability-fields').length - 1];
  // console.log(insertIn);
  var allRemoveButtons = insertIn.querySelectorAll('.remove_record')
  var insertedRemoveButton = allRemoveButtons[allRemoveButtons.length - 1]; //inserted Remove_record Button

  if (insertedRemoveButton) insertedRemoveButton.addEventListener('click', removeFields);

  // handle dates
  var allAvailabilityFields = insertIn.querySelectorAll('.availability-fields');
  // console.log(allAvailabilityFields)
  if (allAvailabilityFields.length > 0) {
    var insertedElement = allAvailabilityFields[allAvailabilityFields.length - 1];
    if (insertedElement) {
      console.log(insertedElement);
      var startDateContainer = insertedElement.querySelector('.date');
      var day = startDateContainer.children[0].value;
      var month = startDateContainer.children[1].value;
      var year = startDateContainer.children[2].value;

      var endDateContainer = insertedElement.querySelector('.time');
      var allEndDateInputs = endDateContainer.querySelectorAll('input');
      allEndDateInputs[0].value = day;
      allEndDateInputs[1].value = month;
      allEndDateInputs[2].value = year;

      startDateContainer.querySelectorAll('select').forEach((select)=>{
        select.addEventListener('change', updateEndDate)
      });
    }
  }

  var y = insertIn.offsetTop + insertIn.offsetHeight + 40;
  window.scrollTo({top: y, behavior: 'smooth'});

  // insertIn.scrollIntoView({behavior: "smooth", block: "end"});
  // window.scrollBy(0, 20);

  return event.preventDefault();
}

function addOrRemoveFields() {
  const addFieldButtons = document.querySelectorAll('.add_fields');
  const alreadyPresentRemoveFieldButtons = document.querySelectorAll('.remove_record');
  if (addFieldButtons.length > 0) {
    addFieldButtons.forEach((addFieldButton) => {
      addFieldButton.addEventListener('click', addFields)
    });
    alreadyPresentRemoveFieldButtons.forEach((removeFieldButton) => {
      removeFieldButton.addEventListener('click', removeFields)
    })
  };

  // handleAvailabilityDates
  const dateFields = document.querySelectorAll('.date');
  if (dateFields.length > 0) {
    dateFields.forEach((date) => {
      date.querySelectorAll('select').forEach((select)=>{
        var startDateContainer = select.parentElement;
        // console.log(startDateContainer)
        var day = startDateContainer.children[0].value;
        var month = startDateContainer.children[1].value;
        var year = startDateContainer.children[2].value;
        var allEndDateInputs = select.parentElement.nextElementSibling.querySelectorAll('input');
        allEndDateInputs[0].value = day;
        allEndDateInputs[1].value = month;
        allEndDateInputs[2].value = year;
        select.addEventListener('change', updateEndDate)
      });
    });
  };
}

function clickOnHand() {
  const availabilityHands = document.querySelectorAll('.availability-hand');
  if (availabilityHands.length > 0) {
    availabilityHands.forEach((hand) => {
      hand.addEventListener('click', function(){
        hand.parentElement.nextElementSibling.click();
      })
    })
  }
}


export { addOrRemoveFields }
export { clickOnHand }
