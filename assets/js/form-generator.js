import React from "react";
import { Field, FieldArray, reduxForm } from "redux-form";
import { Row, Col, Alert } from "react-bootstrap";
import DropdownList from "react-widgets/lib/DropdownList";
import submit from "./submit";
import DATA_TYPES from "./data-types";

import "react-widgets/dist/css/react-widgets.css";

const maxValue = value =>
  parseInt(value) > 100000 ? "The max number of rows is 100,000" : undefined;

const minValue = value =>
  parseInt(value) < 1 ? "The minimum number of rows is 1" : undefined;

const notEmpty = value =>
  value && value.length > 0 ? undefined : "Must be filled";

const renderDropdownList = ({ input, data, valueField, textField }) => (
  <DropdownList
    {...input}
    data={data}
    valueField={valueField}
    textField={textField}
    onChange={input.onChange}
  />
);

const renderField = ({
  input,
  label,
  type,
  meta: { touched, error, warning }
}) => {
  return (
    <div>
      {label}
      <div>
        <input {...input} placeholder={label} type={type} />
        {touched &&
          ((error && <Alert bsStyle="danger">{error}</Alert>) ||
            (warning && <Alert bsStyle="danger">{warning}</Alert>))}
      </div>
    </div>
  );
};

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
                component={renderField}
                placeholder={f.name}
                validate={[notEmpty]}
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
        <Field
          name="numRows"
          type="number"
          component={renderField}
          label="Number of Rows"
          validate={[maxValue, minValue]}
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
