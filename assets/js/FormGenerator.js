import React, { Fragment, Component } from "react";
import { Field, FieldArray, reduxForm } from "redux-form";
import { Row, Col } from "react-bootstrap";
import submit from "./Submit";
class renderSchemaFields extends Component {
  render() {
    const { fields } = this.props;
    return (
      <Row>
        {fields.map((f, index) => (
          <span key={index}>
            <Col md={4} label="Field Name">
              Field Name
              <Field
                name={`fields[${index}]`}
                type="text"
                component="input"
                label={f.name}
                placeholder={f.name}
              />
            </Col>
            <Col md={3} /> &nbsp;
            <Col md={4} label="Field Type">
              Field Type
              <Field
                name={`types[${index}]`}
                type="text"
                component="input"
                label={f.type}
                placeholder={f.type}
              />
            </Col>
          </span>
        ))}
      </Row>
    );
  }
}

const FormGenerator = props => {
  const { handleSubmit, submitting, fields, addRowHandler } = props;
  return (
    <form onSubmit={handleSubmit(submit)}>
      <FieldArray
        name="schemaFields"
        props={{ fields: fields }}
        component={renderSchemaFields}
      />
      <button
        type="button"
        onClick={addRowHandler({ name: "dummyField", type: "string" })}
      >
        Add Row
      </button>
      <button type="submit" disabled={submitting}>
        Create Mock Data
      </button>
    </form>
  );
};

const FgForm = reduxForm({
  form: "fgform",
  destroyOnUnmount: false,
  forceUnregisterOnUnmount: true
})(FormGenerator);

export default FgForm;
