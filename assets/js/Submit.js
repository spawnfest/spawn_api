import axios from "axios";

function submit(values) {
  event.preventDefault();
  let schemaVals = values.fields.reduce((accumulator, f, index) => {
    let obj = {}
    obj[f] = values.types[index]
    return Object.assign(accumulator, obj)}, {});
    axios
    .post(API_URL, {
      schema: schemaVals
    })
    .then(response => {
      console.log(response);
    });
};


export default submit
