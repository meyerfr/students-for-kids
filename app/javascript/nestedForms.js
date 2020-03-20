// remove field function
// $('form').on('click', '.remove_record' function(event){
//   $(this).prev('input[type=hidden]').val('1');
//   $(this).closest('tr').hide();
//   return event.preventDefault();
// });


// add field function
// $('form').on('click', '.add_fields', function(event){
//   var regexp, time;
//   time = new Date().getTime();
//   regexp = new RegExp($(this).data('id'), 'g');
//   $('.fields').append($(this).data('fields').replace(regexp, time));
//   return event.preventDefault();
// });


const removeFields = (event) => {
  const parentDiv = event.currentTarget.closest('div')
  event.currentTarget.previousElementSibling.value = '1'; // hidden field _destroy
  parentDiv.parentElement.classList.add('d-none');
  parentDiv.querySelector('.form-control').value = '';
  return event.preventDefault();
}

const addFields = (event) => {
  var regexp, time;
  time = new Date().getTime();
  regexp = new RegExp(event.currentTarget.dataset.id, 'g');
  const target = event.currentTarget;
  var insertIn = target.parentElement.previousElementSibling; //field where the new form-field must be inserted
  insertIn.insertAdjacentHTML('beforeend', event.currentTarget.dataset.fields.replace(regexp, time)); //insert form-field
  var insertedElement = insertIn.lastElementChild;
  // now addEventListeners to the new add_fields button and to the remove_record button
  var insertedRemoveButton = insertIn.lastElementChild.querySelector('.remove_record'); //inserted Remove_record Button
  // var insertedAddButton = insertIn.lastElementChild.querySelector('.add_fields'); //inserted Add_fields button
  // var insertedAddButtons = insertIn.lastElementChild.querySelectorAll('.add_fields'); //inserted Add_fields button
  // console.log(insertedAddButtons);
  if (insertedRemoveButton) insertedRemoveButton.addEventListener('click', removeFields);
  // if (insertedAddButton){
  //   insertedAddButton.addEventListener('click', addFields);
  //   var addScriptButtons = insertIn.lastElementChild.querySelectorAll('.add-script-button');
  //   if (addScriptButtons.length > 0) {
  //     addScriptButtons[addScriptButtons.length - 1].click();
  //   }
  // }
  if (insertedElement.lastElementChild.lastElementChild.classList.contains('add_fields')) {
    insertedElement.lastElementChild.lastElementChild.addEventListener('click', addFields)
    insertedElement.lastElementChild.lastElementChild.click();
  };

  // if (insertIn.classList.contains('stage_fields')) {

  // }
  // scroll to taregt + 20px
  insertIn.nextElementSibling.scrollIntoView(false);
  window.scrollBy(0, 20);

  // const newAddFieldsButtons = document.querySelectorAll('.new-add-fields');
  // if (newAddFieldsButtons.length > 0) newAddFieldsButtons[newAddFieldsButtons.length - 1].addEventListener('click', addFields);
  return event.preventDefault();
}

// if press addStage, dann muss auch addSection.click(), dann muss addStcript.click()


function addOrRemoveFields() {
  // if button addField.click then addFields()
  // if button removeField.click then removeFields()
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


export { addOrRemoveFields }
