const removeFields = (event) => {
  const parentDiv = event.currentTarget.closest('div');
  event.currentTarget.previousElementSibling.value = '1'; // hidden field _destroy
  parentDiv.classList.add('d-none');
  document.querySelector('.show-container').scrollIntoView({behavior: "smooth", block: "end"});
  return event.preventDefault();
}

const addFields = (event) => {
  var regexp, time;
  time = new Date().getTime();
  regexp = new RegExp(event.currentTarget.dataset.id, 'g');
  const target = event.currentTarget;
  var insertIn = target.nextElementSibling; //field where the new form-field must be inserted
  insertIn.insertAdjacentHTML('beforeend', event.currentTarget.dataset.fields.replace(regexp, time)); //insert form-field
  var insertedElement = insertIn.querySelectorAll('.availability-fields');

  var allRemoveButtons = insertIn.querySelectorAll('.remove_record')
  var insertedRemoveButton = allRemoveButtons[allRemoveButtons.length - 1]; //inserted Remove_record Button

  if (insertedRemoveButton) insertedRemoveButton.addEventListener('click', removeFields);

  document.querySelector('.show-container').scrollIntoView({behavior: "smooth", block: "end"});

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
