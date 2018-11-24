import axios from "axios";

function submit(values) {
  event.preventDefault();
  axios
  .post(API_URL, {
    schema: values
  })
  .then(response => {
    console.log(response);
  });
};


export default submit
