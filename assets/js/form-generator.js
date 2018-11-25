import React from "react";
import { Field, FieldArray, reduxForm } from "redux-form";
import { Row, Col } from "react-bootstrap";
import DropdownList from "react-widgets/lib/DropdownList";
import submit from "./submit";
import DATA_TYPES from "./data-types";

import "react-widgets/dist/css/react-widgets.css";

const renderDropdownList = ({ input, data, valueField, textField }) => (
  <DropdownList
    {...input}
    data={data}
    valueField={valueField}
    textField={textField}
    onChange={input.onChange}
  />
);

const RenderSchemaFields = ({ fields }) => {
  return (
    <div>
      {fields.map((f, index) => (
        <span key={index}>
          <Row>
            <Col sm={5} label="Field Name">
              Field Name
              <Field
                name={`fields[${index}]`}
                type="text"
                component="input"
                label={f.name}
                placeholder={f.name}
              />
            </Col>
            <Col sm={2} /> &nbsp;
            <Col sm={5} label="Field Type">
              Field Type
              <Field
                name={`types[${index}]`}
                component={renderDropdownList}
                data={DATA_TYPES}
                valueField="value"
                textField="name"
              />
            </Col>
          </Row>
        </span>
      ))}
    </div>
  );
};

const NumberOfRows = () => {
  return (
    <Row>
      <Col sm={12}>
        Number Of Rows
        <Field
          name="numRows"
          type="number"
          component="input"
          label="Number of Rows"
        />
      </Col>
    </Row>
  );
};

const Buttons = ({ addRowHandler, submitting }) => {
  return (
    <Row>
      <Col sm={6}>
        <button
          className="form-buttons add-row-button"
          type="button"
          onClick={addRowHandler({ name: "name", type: "email" })}
        >
          Add Row
        </button>
      </Col>
      <Col sm={6}>
        <button
          type="submit"
          disabled={submitting}
          className="form-buttons submit-button"
        >
          Create Mock Data
        </button>
      </Col>
    </Row>
  );
};

const FormGenerator = props => {
  const { handleSubmit, submitting, fields, addRowHandler } = props;
  return (
    <form onSubmit={handleSubmit(submit)}>
      <FieldArray
        name="schemaFields"
        props={{ fields: fields }}
        component={RenderSchemaFields}
      />
      <NumberOfRows />
      <Buttons submitting={submitting} addRowHandler={addRowHandler} />
    </form>
  );
};

const FgForm = reduxForm({
  form: "fgform",
  destroyOnUnmount: false,
  forceUnregisterOnUnmount: true,
  initialValues: {
    numRows: 100
  }
})(FormGenerator);

export default FgForm;
