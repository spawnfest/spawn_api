import React, { Fragment } from 'react'
import { Field, reduxForm } from 'redux-form'
import { Row, Col } from 'react-bootstrap'
import submit from './Submit'

const FormGenerator = props => {
  const { handleSubmit, submitting, fields } = props
  return (
    <Fragment>
      <form onSubmit={handleSubmit(submit)}>
        <Row>
          <Col md={6} label='Field Name' /> Field Name
          <Col md={3} /> &nbsp;
          <Col md={6} label='Type' /> Type
        </Row>
        <Row>
          {fields.map(f => (
            <span key={`${f.name}-${f.type}`}>
              <Col md={6} key={f.name}>
                <Field
                  name={f.name}
                  component='input'
                  label={f.name}
                  placeholder={f.name}
                />
              </Col>
              <Col md={3} /> &nbsp;
              <Col md={6} key={f.type}>
                <Field
                  name={f.type}
                  component='input'
                  label={f.type}
                  placeholder={f.type}
                />
              </Col>
            </span>
          ))}
        </Row>
        <button type='submit' disabled={submitting}>
    Create Mock Data
        </button>
      </form>
    </Fragment>
  )
}

const FgForm = reduxForm({
  form: 'wizard',
  destroyOnUnmount: false,
  forceUnregisterOnUnmount: true
})(FormGenerator)

export default FgForm
