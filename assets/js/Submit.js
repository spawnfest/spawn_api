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
    window.location = `${API_URL}/export_csv/${
    response.data.schema.id
  }?rows=${rows}&file=true`;
});
};

export default submit;
