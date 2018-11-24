import React, { Fragment } from "react";
import { Field, reduxForm } from "redux-form";
import { Row, Col } from "react-bootstrap";
import submit from "./Submit";

const FormGenerator = props => {
  const { handleSubmit, submitting, fields } = props
  return(
    <Fragment>
    <form onSubmit={handleSubmit(submit)}>
    <Row>
    <Col md={6} key="Field Name" />
    </Row>
    <Row>
    <Col md={6} key="Type" />
    </Row>
    <Row>
    {fields.map(f => (
      <div key={`${f.name}-${f.type}`}>
      <Fragment>
      <Col md={6} key={f.name}>
      <Field
      name={f.name}
      component="input"
      label={f.name}
      placeholder={f.name}
      />
      </Col>
      </Fragment>
      <Fragment>
      <Col md={6} key={f.type}>
      <Field
      name={f.type}
      component="input"
      label={f.type}
      placeholder={f.type}
      />
      </Col>
      </Fragment>
      </div>
    ))}
    </Row>
    <button type="submit" disabled={submitting}>
    Create Mock Data
    </button>
    </form>
    </Fragment>
  )
}

const FgForm = reduxForm({
  form: "wizard",
  destroyOnUnmount: false,
  forceUnregisterOnUnmount: true
})(FormGenerator);

export default FgForm;
