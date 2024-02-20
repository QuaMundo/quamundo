describe('sign_in path', () => {
  beforeEach(() => {
    cy.request('/cypress_rails_reset_state')
  })

  it('refuses to login unknown user', () => {
    cy.visit('/users/sign_in')

    cy.getById('user_email').type('unknown@example.tld')
    cy.getById('user_password').type('xxxxxxxxxx')
    cy.getSubmit().click()

    cy.location('pathname').should('equal', '/users/sign_in')
    // FIXME: check flash msg
  })

  it('lets an existing user log in', () => {
    cy.visit('/users/sign_in')

    cy.getById('user_email').type('quamundo@example.tld')
    cy.getById('user_password').type('12345678')
    cy.getSubmit().click()

    cy.location('pathname').should('equal', '/')
    // FIXME: check flash msg
  })

  it('refuses to log in user with invalid password', () => {
    cy.visit('/users/sign_in')

    cy.getById('user_email').type('quamundo@example.tld')
    cy.getById('user_password').type('xxxxxxxxxx')
    cy.getSubmit().click()

    cy.location('pathname').should('equal', '/users/sign_in')
    // FIXME: check flash msg
  })
})
