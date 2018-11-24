import React, { Fragment } from "react";
import { Field, reduxForm } from "redux-form";
import { Row, Col } from "react-bootstrap";

const FormGenerator = ({ fields }) => (
  <Fragment>
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
  </Fragment>
);

const FgForm = reduxForm({
  form: "wizard",
  destroyOnUnmount: false,
  forceUnregisterOnUnmount: true
})(FormGenerator);

export default FgForm;
