import axios from "axios";

const submit = values => {
  let rows = values.numRows;
  let schemaVals = values.fields.reduce((accumulator, f, index) => {
    let obj = {};
    obj[f] = values.types[index].value;
    return Object.assign(accumulator, obj);
  }, {});
  axios
    .post(API_URL, {
      schema: schemaVals
    })
    .then(response => {
      console.log(response);
    });
};

export default submit;
