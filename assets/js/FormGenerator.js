import React, {Fragment} from 'react'
import { Field, reduxForm } from 'redux-form'
import { Row, Col } from 'react-bootstrap'

const FormGenerator = ({ fields }) => (
  <Fragment>
  <Row>
  <Col md={6} key="Field Name"></Col>
  </Row>
  <Row>
  <Col md={6} key="Type"></Col>
  </Row>
  <Row>
  {fields.map(f => (
    <div>
    <Fragment>
    <Col md={6} key={f.name}>
    <Field
    name={f.name}
    component="input"
    label={f.name}
    placeholder={f.name}>
    </Field>
    </Col>
    </Fragment>
    <Fragment>
    <Col md={6} key={f.type}>
    <Field
    name={f.type}
    component="input"
    label={f.type}
    placeholder={f.type}></Field>
    </Col>
    </Fragment>
    </div>
  ))}
  </Row>
  </Fragment>
)

const FgForm = reduxForm({
  form: 'wizard',
  destroyOnUnmount: false,
  forceUnregisterOnUnmount: true
})(FormGenerator)

export default FgForm
